import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tief_weave/markdown.dart';
import 'package:tiefprompt/providers/current_chapter_provider.dart';
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
  Function? _onReachedEnd;

  MarkdownAst _ast = const MarkdownAst.empty();
  final MarkdownRendererController _markdownController =
      MarkdownRendererController();
  List<({String title, double offset})> _chapterOffsets = [];
  double _topPadding = 0;

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

    _rebuildAst();

    _markdownController.addListener(_recomputeChapterOffsets);
    widget.controller.scrollController.addListener(_updateCurrentChapter);
  }

  @override
  void didUpdateWidget(covariant ScrollableText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.text != oldWidget.text) {
      _rebuildAst();
    }
  }

  void _rebuildAst() {
    _ast = MarkdownAstBuilder().build(MarkdownTokenizer().parse(widget.text));
    _chapterOffsets = [];
  }

  void _recomputeChapterOffsets() {
    final blocks = _ast.document.blocks;
    _chapterOffsets = [
      for (var i = 0; i < blocks.length; i++)
        if (blocks[i] case final Heading heading)
          if (_markdownController.offsetOf(i) case final double offset)
            (
              title: _inlinesToText(heading.inlines),
              offset: offset + _topPadding,
            ),
    ];
    _updateCurrentChapter();
  }

  String _inlinesToText(List<Inline> inlines) {
    return inlines
        .map(
          (inline) => switch (inline) {
            PlainText(:final text) => text,
            Emphasis(:final children) => _inlinesToText(children),
            Strong(:final children) => _inlinesToText(children),
            Underline(:final children) => _inlinesToText(children),
          },
        )
        .join();
  }

  void _updateCurrentChapter() {
    final prompter = ref.read(prompterProvider);
    if (!prompter.showCurrentChapter || !prompter.markdownEnabled) {
      return;
    }

    final offset = widget.controller.scrollController.offset;
    String? current;
    for (final chapter in _chapterOffsets) {
      if (chapter.offset <= offset) {
        current = chapter.title;
      } else {
        break;
      }
    }

    ref.read(currentChapterProvider.notifier).setValue(current);
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
    final renderWidth = mediaWidth - widget.sideMargin * 2;
    _topPadding = mediaHeight;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.controller.scrollController.position.isScrollingNotifier
          .addListener(() {
            ref
                .read(_userScrollingProvider.notifier)
                .setValue(
                  widget
                      .controller
                      .scrollController
                      .position
                      .isScrollingNotifier
                      .value,
                );
          });
    });

    final prompter = ref.watch(prompterProvider);

    if (!prompter.markdownEnabled || !prompter.showCurrentChapter) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(currentChapterProvider.notifier).setValue(null);
      });
    }

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
            if (prompter.markdownEnabled)
              Markdown(
                widget.text,
                controller: _markdownController,
                textAlign: prompter.alignment,
                style: widget.style,
                width: renderWidth,
              )
            else
              Text(
                widget.text,
                style: widget.style,
                textAlign: prompter.alignment,
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
    widget.controller.scrollController.removeListener(_updateCurrentChapter);
    _markdownController.removeListener(_recomputeChapterOffsets);
    _markdownController.dispose();
    super.dispose();
  }
}
