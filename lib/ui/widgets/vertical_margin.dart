import 'package:flutter/material.dart';

class VerticalMargin extends StatelessWidget {
  final double heightRatio;
  final Color color;

  const VerticalMargin(
      {super.key, required this.heightRatio, required this.color});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child:
                  _VerticalMarginBox(heightRatio: heightRatio, color: color)),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child:
                  _VerticalMarginBox(heightRatio: heightRatio, color: color)),
        ],
      ),
    );
  }
}

class _VerticalMarginBox extends StatelessWidget {
  final double heightRatio;
  final Color color;

  const _VerticalMarginBox({required this.heightRatio, required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * (heightRatio / 200),
      child: Container(color: color),
    );
  }
}
