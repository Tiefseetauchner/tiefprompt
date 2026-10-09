import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'system_colors_service.g.dart';

typedef SystemColorSchemes = ({ColorScheme light, ColorScheme dark});

@Riverpod(keepAlive: true)
Future<SystemColorSchemes?> systemColorSchemes(Ref ref) async {
  try {
    final corePalette = await DynamicColorPlugin.getCorePalette();
    if (corePalette != null) {
      return (
        light: corePalette.toColorScheme(),
        dark: corePalette.toColorScheme(brightness: Brightness.dark),
      );
    }

    final accentColor = await DynamicColorPlugin.getAccentColor();
    if (accentColor != null) {
      return (
        light: ColorScheme.fromSeed(seedColor: accentColor),
        dark: ColorScheme.fromSeed(
          seedColor: accentColor,
          brightness: Brightness.dark,
        ),
      );
    }
  } on PlatformException {
    return null;
  } on MissingPluginException {
    return null;
  }

  return null;
}
