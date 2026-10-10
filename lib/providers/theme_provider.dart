import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/services/system_colors_service.dart';

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
    final (
      :appPrimaryColor,
      :useSystemColors,
      :prompterBackgroundColor,
      :prompterTextColor,
    ) = await ref.watch(
      settingsProvider.selectAsync(
        (s) => (
          appPrimaryColor: s.appPrimaryColor,
          useSystemColors: s.useSystemColors,
          prompterBackgroundColor: s.prompterBackgroundColor,
          prompterTextColor: s.prompterTextColor,
        ),
      ),
    );
    final systemColors = useSystemColors
        ? await ref.watch(systemColorSchemesProvider.future)
        : null;

    return ThemesState(
      darkTheme: systemColors == null
          ? _createBrandDarkTheme(appPrimaryColor)
          : _createSystemTheme(systemColors.dark),
      lightTheme: systemColors == null
          ? _createBrandLightTheme(appPrimaryColor)
          : _createSystemTheme(systemColors.light),
      prompterTheme: _createPrompterTheme(
        primary: systemColors?.dark.primary ?? appPrimaryColor,
        background: prompterBackgroundColor,
        text: prompterTextColor,
      ),
    );
  }
}

ThemeData _createBrandDarkTheme(Color primary) => createCustomTheme(
  brightness: Brightness.dark,
  primary: primary,
  secondary: kBrandCoral,
  background: kBrandAbyss,
  surface: kBrandAbyssSurface,
  surfaceAlt: kBrandAbyssSurfaceAlt,
  border: kBrandBorderDark,
  onSurface: kBrandDarkText,
);

ThemeData _createBrandLightTheme(Color primary) => createCustomTheme(
  brightness: Brightness.light,
  primary: primary,
  secondary: kBrandCoral,
  background: kBrandLightBackground,
  surface: kBrandLightSurface,
  surfaceAlt: kBrandLightBackground,
  border: kBrandBorderLight,
  onSurface: kBrandLightText,
);

ThemeData _createSystemTheme(ColorScheme scheme) => createCustomTheme(
  brightness: scheme.brightness,
  primary: scheme.primary,
  secondary: scheme.secondary,
  background: scheme.surface,
  surface: scheme.surface,
  surfaceAlt: scheme.surfaceContainerHighest,
  border: scheme.outline,
  onSurface: scheme.onSurface,
);

ThemeData _createPrompterTheme({
  required Color primary,
  required Color background,
  required Color text,
}) => createCustomTheme(
  brightness: Brightness.dark,
  primary: primary,
  secondary: primary,
  background: background,
  surface: background,
  surfaceAlt: background,
  border: Colors.transparent,
  onSurface: text,
);

ThemeData createCustomTheme({
  required Brightness brightness,
  required Color primary,
  required Color secondary,
  required Color background,
  required Color surface,
  required Color surfaceAlt,
  required Color border,
  required Color onSurface,
}) {
  final onPrimary = _readableOn(primary);
  final error = const Color(0xFFE5484D).harmonizeWith(primary);
  final scheme = ColorScheme(
    brightness: brightness,
    primary: primary,
    onPrimary: onPrimary,
    secondary: secondary,
    onSecondary: _readableOn(secondary),
    surface: surface,
    onSurface: onSurface,
    surfaceContainerLowest: background,
    surfaceContainerHighest: surfaceAlt,
    error: error,
    onError: _readableOn(error),
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
        borderSide: BorderSide(color: secondary, width: 2),
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
          return secondary.withValues(alpha: 0.25);
        }
        if (states.contains(WidgetState.selected)) return primary;
        return secondary.withValues(alpha: 0.7);
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return secondary.withValues(alpha: 0.1);
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
        return secondary.withValues(alpha: 0.3);
      }),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: primary,
      thumbColor: primary,
      inactiveTrackColor: border,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: primary),
    listTileTheme: const ListTileThemeData(),
    disabledColor: onSurface.withValues(alpha: 0.38),
  );
}

Color _readableOn(Color background) =>
    background.computeLuminance() > 0.5 ? kBrandLightText : Colors.white;
