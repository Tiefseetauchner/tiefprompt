import 'package:flutter/material.dart';

final prompterBlackTheme = ThemeData.light().copyWith(
  canvasColor: Colors.black,
  scaffoldBackgroundColor: Colors.black,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: Colors.black,
    secondary: Colors.black,
    onPrimary: Colors.white,
    onSecondary: Color.fromARGB(255, 100, 100, 100),
    surface: Color.fromARGB(255, 40, 40, 40),
    onSurface: Colors.white,
  ),
);
