import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiefprompt/providers/prompter_provider.dart';

class ElapsedTimeDisplay extends ConsumerStatefulWidget {
  const ElapsedTimeDisplay({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ElapsedTimeDisplayState();
}

class _ElapsedTimeDisplayState extends ConsumerState<ElapsedTimeDisplay> {
  late final Timer _timer;
  late final Stopwatch _stopwatch;
  int _elapsed = 0;

  @override
  void initState() {
    super.initState();

    _stopwatch = Stopwatch();
    _timer = Timer.periodic(Duration(seconds: 1), tick);
  }

  void tick(Timer timer) {
    setState(() => _elapsed = _stopwatch.elapsed.inSeconds);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(prompterProvider.select((p) => (isPlaying: p.isPlaying)), (
      prev,
      next,
    ) {
      if ((prev == null || prev.isPlaying) && !next.isPlaying) {
        _stopwatch.stop();
        tick(_timer);
      }

      if ((prev == null || !prev.isPlaying) && next.isPlaying) {
        _stopwatch.reset();
        tick(_timer);
        _stopwatch.start();
      }
    });

    return Text("$_elapsed${context.tr("PrompterScreen.ElapsedTime.Unit")}");
  }

  @override
  void dispose() {
    _stopwatch.stop();
    _timer.cancel();

    super.dispose();
  }
}
