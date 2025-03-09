import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CountdownTimer extends ConsumerStatefulWidget {
  final int duration;

  const CountdownTimer({super.key, required this.duration});

  @override
  ConsumerState<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends ConsumerState<CountdownTimer> {
  late int remainingTime;

  @override
  void initState() {
    super.initState();
    remainingTime = widget.duration;
    startCountdown();
  }

  void startCountdown() {
    Future.delayed(const Duration(seconds: 1), tick);
  }

  void tick() {
    if (!mounted) return;
    if (remainingTime > 0) {
      setState(() => remainingTime--);
      startCountdown();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (child, animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: Text(
        '$remainingTime',
        key: ValueKey<int>(remainingTime),
        style: const TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
