import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  final int duration; // Countdown duration in seconds

  const CountdownTimer({super.key, required this.duration});

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late int remainingTime;
  late double progress;

  @override
  void initState() {
    super.initState();
    remainingTime = widget.duration;
    progress = 1.0; // Full progress at the start
    startCountdown();
  }

  void startCountdown() {
    Future.delayed(const Duration(seconds: 1), tick);
  }

  void tick() {
    if (!mounted) return;
    if (remainingTime > 0) {
      setState(() {
        remainingTime--;
        progress = remainingTime / widget.duration;
      });
      startCountdown();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Stack(
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200],
                ),
              ),
              SizedBox(
                width: 200,
                height: 200,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 16,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
            ],
          ),
          Text(
            '$remainingTime',
            key: ValueKey<int>(remainingTime),
            style: const TextStyle(
              fontSize: 100,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
