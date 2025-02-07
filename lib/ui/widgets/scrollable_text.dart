import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiefprompt/providers/prompter_provider.dart';

final _userScrollingProvider = StateProvider<bool>((ref) => false);

class ScrollableText extends ConsumerStatefulWidget {
  final String text;
  final TextStyle? style;

  const ScrollableText({super.key, required this.text, this.style});

  @override
  ConsumerState<ScrollableText> createState() => _ScrollableTextState();
}

class _ScrollableTextState extends ConsumerState<ScrollableText>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  Ticker? _ticker;
  double _scrollSpeed = 0.0;
  Function? _onReachedEnd;

  void _startScrolling(double speed) {
    _stopScrolling();
    _scrollSpeed = speed; // Adjusted speed factor
    _ticker?.start();
  }

  void _stopScrolling() {
    _ticker?.stop();
  }

  @override
  void initState() {
    super.initState();

    _ticker = createTicker((Duration elapsed) {
      final isUserScrolling = ref.watch(_userScrollingProvider);

      if (_scrollController.hasClients && !isUserScrolling) {
        if (_scrollController.offset + _scrollSpeed >=
            _scrollController.position.maxScrollExtent) {
          _onReachedEnd?.call();
          return;
        }

        _scrollController.animateTo(_scrollController.offset + _scrollSpeed,
            duration: Duration(milliseconds: 3), curve: Curves.linear);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;

    _scrollController = ScrollController(initialScrollOffset: mediaHeight / 2);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollController.position.isScrollingNotifier.addListener(() {
        ref.read(_userScrollingProvider.notifier).state =
            _scrollController.position.isScrollingNotifier.value;
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
          controller: _scrollController,
          padding: EdgeInsets.fromLTRB(0, mediaHeight, 0, 0),
          child: Column(children: [
            Text(widget.text, style: widget.style),
            SizedBox(
                height: mediaHeight,
                child: Center(child: Text("The End", style: widget.style))),
          ]),
        ));
  }

  @override
  void dispose() {
    _stopScrolling();
    _scrollController.dispose();
    super.dispose();
  }
}
