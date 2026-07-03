import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tief_weave/markdown.dart';
import 'package:tiefprompt/providers/prompter_provider.dart';

class _UserScrolling extends Notifier<bool> {
  @override
  bool build() => false;
  void setValue(bool v) => state = v;
}

final _userScrollingProvider = NotifierProvider<_UserScrolling, bool>(
  _UserScrolling.new,
);

class ScrollableTextController {
  final ScrollController scrollController;

  ScrollableTextController({double initialScrollOffset = 0.0})
    : scrollController = ScrollController(
        initialScrollOffset: initialScrollOffset,
      );

  void jumpTo(double offset) {
    scrollController.jumpTo(offset);
  }

  void jumpRelative(double offset) {
    scrollController.jumpTo(scrollController.offset + offset);
  }

  void dispose() {
    scrollController.dispose();
  }
}

class ScrollableText extends ConsumerStatefulWidget {
  final ScrollableTextController controller;
  final String text;
  final TextStyle? style;
  final double sideMargin;

  const ScrollableText({
    super.key,
    required this.text,
    this.style,
    required this.sideMargin,
    required this.controller,
  });

  @override
  ConsumerState<ScrollableText> createState() => _ScrollableTextState();
}

class _ScrollableTextState extends ConsumerState<ScrollableText>
    with SingleTickerProviderStateMixin {
  Ticker? _ticker;
  double _scrollSpeed = 0;
  Duration _lastElapsed = Duration.zero;
  Function? _onReachedEnd;

  void _startScrolling(double speed) {
    _stopScrolling();
    _scrollSpeed = speed;
    _lastElapsed = Duration.zero;
    _ticker?.start();
  }

  void _stopScrolling() {
    _ticker?.stop();
  }

  @override
  void initState() {
    super.initState();

    ref.listen(_userScrollingProvider, (previous, next) {
      if (next) {
        _stopScrolling();
      } else {
        final prompter = ref.read(prompterProvider);
        if (prompter.isPlaying) {
          _startScrolling(prompter.speed);
        }
      }
    });

    ref.listen(prompterProvider, (previous, next) {
      if (next.isPlaying) {
        _startScrolling(next.speed);
      } else {
        _stopScrolling();
      }
    });

    _ticker = createTicker((Duration elapsed) {
      _tick(elapsed);
    });
  }

  void _tick(Duration elapsed) {
    final isUserScrolling = ref.read(_userScrollingProvider);

    final deltaSeconds =
        (elapsed - _lastElapsed).inMicroseconds /
        Duration.microsecondsPerSecond;
    _lastElapsed = elapsed;

    final calculatedScrollOffset =
        _getScrollOffsetInLinesPerSecond(_scrollSpeed) * deltaSeconds;

    if (widget.controller.scrollController.hasClients && !isUserScrolling) {
      if (widget.controller.scrollController.position.pixels +
              calculatedScrollOffset >=
          widget.controller.scrollController.position.maxScrollExtent) {
        _onReachedEnd?.call();
        return;
      }
      widget.controller.scrollController.jumpTo(
        widget.controller.scrollController.position.pixels +
            calculatedScrollOffset,
      );
    }
  }

  double _getScrollOffsetInLinesPerSecond(double speed) {
    final textStyle = widget.style ?? const TextStyle(fontSize: 14);
    final lineHeight = textStyle.height ?? 1.0;
    final fontSize = textStyle.fontSize ?? 14.0;
    final lineHeightInPixels = lineHeight * fontSize;

    return speed * lineHeightInPixels;
  }

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;
    final mediaWidth = MediaQuery.of(context).size.width;

    final (:mirroredX, :mirroredY, :markdownEnabled, :alignment) = ref.watch(
      prompterProvider.select(
        (s) => (
          mirroredX: s.mirroredX,
          mirroredY: s.mirroredY,
          markdownEnabled: s.markdownEnabled,
          alignment: s.alignment,
        ),
      ),
    );

    _onReachedEnd = () {
      ref.read(prompterProvider.notifier).togglePlayPause();
    };

    return Transform.flip(
      flipX: mirroredX,
      flipY: mirroredY,
      child: SingleChildScrollView(
        controller: widget.controller.scrollController,
        padding: EdgeInsets.fromLTRB(
          widget.sideMargin,
          mediaHeight,
          widget.sideMargin,
          0,
        ),
        child: Column(
          children: [
            if (markdownEnabled)
              Markdown(
                widget.text,
                textAlign: alignment,
                style: widget.style,
                width: mediaWidth - widget.sideMargin * 2,
              )
            else
              Text(widget.text, style: widget.style, textAlign: alignment),
            SizedBox(
              height: mediaHeight,
              child: Center(child: Text("The End", style: widget.style)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _stopScrolling();
    _ticker?.dispose();
    _ticker = null;
    super.dispose();
  }
}
