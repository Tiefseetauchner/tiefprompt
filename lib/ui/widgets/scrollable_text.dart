import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiefprompt/providers/prompter_provider.dart';
import 'dart:async';

import 'package:tiefprompt/providers/settings_provider.dart';

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
    _scrollTimer = Timer.periodic(Duration(milliseconds: 5), (timer) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(
          _scrollController.offset + speed / 10,
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

    final settings = ref.watch(settingsProvider);
    final prompter = ref.watch(prompterProvider);

    if (prompter.isPlaying) {
      _startScrolling(prompter.speed);
    } else {
      _stopScrolling();
    }

    return switch (settings) {
      AsyncData(:final value) => SingleChildScrollView(
          controller: _scrollController,
          padding: EdgeInsets.fromLTRB(
            0,
            MediaQuery.of(context).size.height,
            0,
            MediaQuery.of(context).size.height,
          ),
          child: Transform.flip(
              flipX: value.mirroredX,
              flipY: value.mirroredY,
              child: Text(widget.text, style: widget.style)),
        ),
      AsyncError(:final error) => Text(error.toString()),
      _ => const CircularProgressIndicator(),
    };
  }

  @override
  void dispose() {
    _scrollTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }
}
