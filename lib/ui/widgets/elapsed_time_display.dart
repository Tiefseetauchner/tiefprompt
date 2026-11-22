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
  Duration _elapsed = Duration();

  @override
  void initState() {
    super.initState();

    _stopwatch = Stopwatch();
    _timer = Timer.periodic(Duration(milliseconds: 200), tick);
  }

  void tick(Timer timer) {
    setState(() => _elapsed = _stopwatch.elapsed);
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

    final hoursText = _elapsed.inHours > 0
        ? "${_elapsed.inHours}${context.tr("PrompterScreen.ElapsedTime.UnitHours")}"
        : "";

    final minutesText = _elapsed.inMinutes > 0
        ? "${_elapsed.inMinutes % 60}${context.tr("PrompterScreen.ElapsedTime.UnitMinutes")}"
        : "";

    final secondsText =
        "${_elapsed.inSeconds % 60}${context.tr("PrompterScreen.ElapsedTime.UnitSeconds")}";

    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        border: BoxBorder.all(color: theme.colorScheme.primary, width: 4),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(4),
      child: Text(
        "$hoursText$minutesText$secondsText",
        style: TextStyle(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _stopwatch.stop();
    _timer.cancel();

    super.dispose();
  }
}
