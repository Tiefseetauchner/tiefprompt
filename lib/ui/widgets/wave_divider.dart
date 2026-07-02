import 'dart:math' as math;

import 'package:flutter/material.dart';

class WaveDivider extends StatelessWidget {
  final double height;

  const WaveDivider({super.key, this.height = 32});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(painter: _WavePainter(color)),
    );
  }
}

class _WavePainter extends CustomPainter {
  final Color color;

  _WavePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    _drawWave(
      canvas,
      size,
      amplitude: 6,
      phase: 1.2,
      alpha: 0.22,
      yOffset: 0.55,
    );
    _drawWave(
      canvas,
      size,
      amplitude: 30,
      phase: math.pi,
      alpha: 0.12,
      yOffset: 1,
    );
  }

  void _drawWave(
    Canvas canvas,
    Size size, {
    required double amplitude,
    required double phase,
    required double alpha,
    required double yOffset,
  }) {
    final paint = Paint()..color = color.withValues(alpha: alpha);
    final path = Path()..moveTo(0, size.height);
    final baseline = size.height * yOffset;
    const step = 4.0;
    for (double x = 0; x <= size.width; x += step) {
      final y =
          baseline +
          amplitude * math.sin((x / size.width * 2 * math.pi) + phase);
      path.lineTo(x, y);
    }
    path
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_WavePainter oldDelegate) => oldDelegate.color != color;
}
