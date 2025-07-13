import 'package:flutter/material.dart';

class VerticalMargin extends StatelessWidget {
  final double heightRatio;
  final Color color;
  final bool fade;
  final double fadeLength;

  const VerticalMargin({
    super.key,
    required this.heightRatio,
    required this.color,
    this.fade = false,
    this.fadeLength = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _VerticalMarginBox(
              heightRatio: heightRatio,
              color: color,
              fade: fade ? fadeLength : 0,
              fadePosition: _FadePosition.bottom,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _VerticalMarginBox(
              heightRatio: heightRatio,
              color: color,
              fade: fade ? fadeLength : 0,
              fadePosition: _FadePosition.top,
            ),
          ),
        ],
      ),
    );
  }
}

class _VerticalMarginBox extends StatelessWidget {
  final double heightRatio;
  final Color color;
  final double fade;
  final _FadePosition fadePosition;

  const _VerticalMarginBox({
    required this.heightRatio,
    required this.color,
    this.fade = 0,
    this.fadePosition = _FadePosition.top,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * (heightRatio / 200);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: height,
      child: Container(
        decoration: fade > 0
            ? BoxDecoration(
                gradient: LinearGradient(
                  begin: fadePosition == _FadePosition.top
                      ? Alignment.topCenter
                      : Alignment.bottomCenter,
                  end: fadePosition == _FadePosition.top
                      ? Alignment.bottomCenter
                      : Alignment.topCenter,
                  colors: [
                    color.withValues(alpha: 0),
                    color.withValues(alpha: 1),
                  ],
                  stops: [0.0, fade.clamp(0.0, 1.0)],
                ),
              )
            : BoxDecoration(color: color),
      ),
    );
  }
}

enum _FadePosition {
  top,
  bottom,
}
