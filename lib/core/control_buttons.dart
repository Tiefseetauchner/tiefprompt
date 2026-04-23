import 'dart:ui';

import 'package:flutter/material.dart';

const double kControlButtonMargin = 20;

enum ControlButtonsPosition { left, right, bottom, top }

class ControlButtonsPositionResolver {
  static AlignmentGeometry getAlignment(ControlButtonsPosition position) {
    switch (position) {
      case ControlButtonsPosition.left:
        return AlignmentGeometry.centerLeft;
      case ControlButtonsPosition.right:
        return AlignmentGeometry.centerRight;
      case ControlButtonsPosition.bottom:
        return AlignmentGeometry.bottomCenter;
      case ControlButtonsPosition.top:
        return AlignmentGeometry.topCenter;
    }
  }
}
