import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiefprompt/providers/prompter_provider.dart';
import 'dart:async';

class ScrollableText extends ConsumerStatefulWidget {
  final String text;
  final TextStyle? style;

  const ScrollableText({super.key, required this.text, this.style});

  @override
  ConsumerState<ScrollableText> createState() => _ScrollableTextState();
}

class _ScrollableTextState extends ConsumerState<ScrollableText> {
  late ScrollController _scrollController;
  Timer? _scrollTimer;

  void _startScrolling(double speed) {
    _scrollTimer?.cancel();
    _scrollTimer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(
          _scrollController.offset + speed,
        );
      }
    });
  }

  void _stopScrolling() {
    _scrollTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    _scrollController = ScrollController(
      initialScrollOffset: MediaQuery.of(context).size.height / 2,
    );

    final prompter = ref.watch(prompterProvider);

    if (prompter.isPlaying) {
      _startScrolling(prompter.speed);
    } else {
      _stopScrolling();
    }

    return SingleChildScrollView(
      controller: _scrollController,
      padding: EdgeInsets.fromLTRB(
        0,
        MediaQuery.of(context).size.height,
        0,
        MediaQuery.of(context).size.height,
      ),
      child: Text(widget.text, style: widget.style),
    );
  }

  @override
  void dispose() {
    _scrollTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }
}
