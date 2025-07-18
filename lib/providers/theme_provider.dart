import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

@Riverpod(dependencies: [Settings])
class Themes extends _$Themes {
  @override
  Future<ThemesState> build() async {
    final settingsService = await ref.watch(settingsProvider.future);

    // TODO: Colors
    return ThemesState(
      // return ThemeData.from(colorScheme: ColorScheme.dark(primary: Color(0)));
      darkTheme: ThemeData.from(
        colorScheme: ColorScheme.dark(
          primary: Color.fromARGB(255, 77, 103, 214),
        ),
      ),
      // return ThemeData.from(colorScheme: ColorScheme.light(primary: Color(0)));
      lightTheme: ThemeData.from(
        colorScheme: ColorScheme.light(
          primary: Color.fromARGB(255, 77, 103, 214),
        ),
      ),
      prompterTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        canvasColor: Colors.black,
        primaryColor: Colors.white,
      ),
    );
  }
}
