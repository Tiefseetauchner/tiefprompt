import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tiefprompt/providers/settings_provider.dart';

part 'theme_provider.freezed.dart';
part 'theme_provider.g.dart';

@freezed
abstract class ThemesState with _$ThemesState {
  factory ThemesState({
    required ThemeData darkTheme,
    required ThemeData lightTheme,
    required ThemeData prompterTheme,
  }) = _ThemesState;
}

@Riverpod(keepAlive: true, dependencies: [Settings])
class Themes extends _$Themes {
  @override
  Future<ThemesState> build() async {
    final appPrimaryColor = await ref.watch(
      settingsProvider.selectAsync((s) => s.appPrimaryColor),
    );
    final prompterBackgroundColor = await ref.watch(
      settingsProvider.selectAsync((s) => s.prompterBackgroundColor),
    );
    final prompterTextColor = await ref.watch(
      settingsProvider.selectAsync((s) => s.prompterTextColor),
    );

    return ThemesState(
      darkTheme: ThemeData.from(
        colorScheme: ColorScheme.dark(primary: appPrimaryColor),
      ),
      lightTheme: ThemeData.from(
        colorScheme: ColorScheme.light(primary: appPrimaryColor),
      ),
      prompterTheme: ThemeData.from(
        colorScheme: ColorScheme.highContrastDark(
          primary: appPrimaryColor,
          surface: prompterBackgroundColor,
          onSurface: prompterTextColor,
        ),
      ),
    );
  }
}
