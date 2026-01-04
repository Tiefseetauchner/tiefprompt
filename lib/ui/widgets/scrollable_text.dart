import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tief_weave/markdown.dart';
import 'package:tiefprompt/providers/prompter_provider.dart';

final _userScrollingProvider = StateProvider<bool>((ref) => false);

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
  Function? _onReachedEnd;

  void _startScrolling(double speed) {
    _stopScrolling();
    _scrollSpeed = speed;
    _ticker?.start();
  }

  void _stopScrolling() {
    _ticker?.stop();
  }

  @override
  void initState() {
    super.initState();

    _ticker = createTicker((Duration elapsed) {
      _tick();
    });
  }

  void _tick() {
    final isUserScrolling = ref.watch(_userScrollingProvider);

    final calculatedScrollOffset =
        (_scrollSpeed * (widget.style?.fontSize ?? 48)) / 10;

    if (widget.controller.scrollController.hasClients && !isUserScrolling) {
      if (widget.controller.scrollController.position.pixels +
              calculatedScrollOffset >=
          widget.controller.scrollController.position.maxScrollExtent) {
        _onReachedEnd?.call();
        return;
      }

      widget.controller.scrollController.animateTo(
        widget.controller.scrollController.position.pixels +
            calculatedScrollOffset,
        duration: Duration(milliseconds: 100),
        curve: Curves.linear,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;
    final mediaWidth = MediaQuery.of(context).size.width;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.controller.scrollController.position.isScrollingNotifier
          .addListener(() {
            ref.read(_userScrollingProvider.notifier).state = widget
                .controller
                .scrollController
                .position
                .isScrollingNotifier
                .value;
          });
    });

    final prompter = ref.watch(prompterProvider);

    _onReachedEnd = () {
      ref.read(prompterProvider.notifier).togglePlayPause();
    };

    if (prompter.isPlaying) {
      _startScrolling(prompter.speed);
    } else {
      _stopScrolling();
    }
    return Transform.flip(
      flipX: prompter.mirroredX,
      flipY: prompter.mirroredY,
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
            Markdown(
              widget.text,
              textAlign: prompter.alignment,
              style: widget.style,
              width: mediaWidth - widget.sideMargin * 2,
            ),
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
