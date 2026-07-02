import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tiefprompt/core/constants.dart';
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
      darkTheme: _shellTheme(
        brightness: Brightness.dark,
        primary: appPrimaryColor,
        background: kBrandAbyss,
        surface: kBrandAbyssSurface,
        surfaceAlt: kBrandAbyssSurfaceAlt,
        border: kBrandBorderDark,
        onSurface: kBrandDarkText,
      ),
      lightTheme: _shellTheme(
        brightness: Brightness.light,
        primary: appPrimaryColor,
        background: kBrandLightBackground,
        surface: kBrandLightSurface,
        surfaceAlt: kBrandLightBackground,
        border: kBrandBorderLight,
        onSurface: kBrandLightText,
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

ThemeData _shellTheme({
  required Brightness brightness,
  required Color primary,
  required Color background,
  required Color surface,
  required Color surfaceAlt,
  required Color border,
  required Color onSurface,
}) {
  final onPrimary = _readableOn(primary);
  final scheme = ColorScheme(
    brightness: brightness,
    primary: primary,
    onPrimary: onPrimary,
    secondary: primary,
    onSecondary: onPrimary,
    surface: surface,
    onSurface: onSurface,
    surfaceContainerLowest: background,
    surfaceContainerHighest: surfaceAlt,
    error: const Color(0xFFE5484D),
    onError: Colors.white,
    outline: border,
    outlineVariant: border,
  );

  final radius = BorderRadius.circular(kBrandRadius);
  final shape = RoundedRectangleBorder(
    borderRadius: radius,
    side: BorderSide(color: border),
  );

  final base = ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: scheme,
    fontFamily: 'Exo',
    scaffoldBackgroundColor: background,
    canvasColor: background,
  );

  return base.copyWith(
    appBarTheme: AppBarTheme(
      backgroundColor: background,
      surfaceTintColor: Colors.transparent,
      foregroundColor: onSurface,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: shape,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surface,
      border: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: primary, width: 2),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: onPrimary,
        elevation: 0,
        shape: shape,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primary,
        side: BorderSide(color: primary),
        shape: shape,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: primary),
    ),
    dividerTheme: DividerThemeData(color: border, thickness: 1, space: 1),
    bottomSheetTheme: BottomSheetThemeData(
      shape: shape,
      backgroundColor: surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: shape,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return onSurface.withValues(alpha: 0.25);
        }
        if (states.contains(WidgetState.selected)) return primary;
        return onSurface.withValues(alpha: 0.7);
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return onSurface.withValues(alpha: 0.1);
        }
        if (states.contains(WidgetState.selected)) {
          return primary.withValues(alpha: 0.5);
        }
        return border;
      }),
      trackOutlineColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.transparent;
        }
        if (states.contains(WidgetState.selected)) {
          return primary.withValues(alpha: 0.5);
        }
        return onSurface.withValues(alpha: 0.3);
      }),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: primary,
      thumbColor: primary,
      inactiveTrackColor: border,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: primary),
    listTileTheme: const ListTileThemeData(),
  );
}

Color _readableOn(Color background) =>
    background.computeLuminance() > 0.5 ? kBrandLightText : Colors.white;
