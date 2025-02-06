import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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

class _ScrollableTextState extends ConsumerState<ScrollableText>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  Ticker? _ticker;
  double _scrollSpeed = 0.0;

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
    _scrollController = ScrollController();
    _ticker = createTicker((Duration elapsed) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(
          (_scrollController.offset + _scrollSpeed).clamp(
            0.0,
            _scrollController.position.maxScrollExtent,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;
    final settings = ref.watch(settingsProvider);
    final prompter = ref.watch(prompterProvider);

    if (prompter.isPlaying) {
      _startScrolling(prompter.speed);
    } else {
      _stopScrolling();
    }

    return switch (settings) {
      AsyncData(:final value) => Transform.flip(
          flipX: value.mirroredX,
          flipY: value.mirroredY,
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: EdgeInsets.symmetric(vertical: mediaHeight),
            child: Text(widget.text, style: widget.style),
          )),
      AsyncError(:final error) => Text(error.toString()),
      _ => const CircularProgressIndicator(),
    };
  }

  @override
  void dispose() {
    _stopScrolling();
    _scrollController.dispose();
    super.dispose();
  }
}
