import 'package:dynamic_color/dynamic_color.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiefprompt/providers/combining_provider.dart';
import 'package:tiefprompt/providers/fonts_provider.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/providers/theme_provider.dart';
import 'package:tiefprompt/ui/screens/reset_settings_screen.dart';

class ThemedApp extends ConsumerWidget {
  final RouterConfig<Object> routerConfig;
  final TransitionBuilder? builder;
  final bool debugShowCheckedModeBanner;

  const ThemedApp({
    super.key,
    required this.routerConfig,
    this.builder,
    this.debugShowCheckedModeBanner = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final delegates = context.localizationDelegates;
    final supportedLocales = context.supportedLocales;
    final locale = context.locale;

    ref.watch(fontsProvider);

    final settings = ref.watch(
      settingsProvider.select(
        (s) => s.whenData(
          (d) => (themeMode: d.themeMode, useSystemColors: d.useSystemColors),
        ),
      ),
    );
    final lightTheme = ref.watch(
      themesProvider.select((t) => t.whenData((d) => d.lightTheme)),
    );
    final darkTheme = ref.watch(
      themesProvider.select((t) => t.whenData((d) => d.darkTheme)),
    );
    final combined = ref.watch(
      combinedAsyncDataProvider.call([settings, lightTheme, darkTheme]),
    );

    if (combined case AsyncError(:final error)) {
      return MaterialApp(
        title: 'Teleprompter',
        localizationsDelegates: delegates,
        supportedLocales: supportedLocales,
        locale: locale,
        home: ResetSettingsScreen(
          title: "An Exceedingly Scary Error",
          message: "Something went wrong loading your settings or maybe even the themes ( :c ). Resetting them should get things working again.",
          error: error,
        ),
      );
    }

    final combinedValue = combined.asData?.value;
    final resolvedLightTheme = combinedValue?.states[1] as ThemeData?;
    final resolvedDarkTheme = combinedValue?.states[2] as ThemeData?;
    final resolvedSettings =
        combinedValue?.states[0]
            as ({ThemeMode? themeMode, bool useSystemColors})?;
    final resolvedThemeMode = resolvedSettings?.themeMode ?? ThemeMode.system;
    final resolvedUseSystemColors = resolvedSettings?.useSystemColors ?? false;

    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        final lightDynamicTheme = lightDynamic == null
            ? null
            : createCustomTheme(
                brightness: Brightness.dark,
                primary: lightDynamic.primary,
                background: lightDynamic.background,
                surface: lightDynamic.surface,
                surfaceAlt: lightDynamic.surfaceVariant,
                border: lightDynamic.outline,
                onSurface: lightDynamic.onSurface,
              );
        final currentLightDynamicTheme =
            lightDynamicTheme ?? resolvedLightTheme;
        final darkDynamicTheme = darkDynamic == null
            ? null
            : createCustomTheme(
                brightness: Brightness.dark,
                primary: darkDynamic.primary,
                background: darkDynamic.background,
                surface: darkDynamic.surface,
                surfaceAlt: darkDynamic.surfaceVariant,
                border: darkDynamic.outline,
                onSurface: darkDynamic.onSurface,
              );
        final currentDarkDynamicTheme = darkDynamicTheme ?? resolvedDarkTheme;

        final currentLightTheme = resolvedUseSystemColors
            ? currentLightDynamicTheme
            : resolvedLightTheme;

        final currentDarkTheme = resolvedUseSystemColors
            ? currentDarkDynamicTheme
            : resolvedDarkTheme;

        return MaterialApp.router(
          title: 'Teleprompter',
          debugShowCheckedModeBanner: debugShowCheckedModeBanner,
          localizationsDelegates: delegates,
          supportedLocales: supportedLocales,
          locale: locale,
          routerConfig: routerConfig,
          builder: builder,
          theme: currentLightTheme,
          darkTheme: currentDarkTheme,
          themeMode: resolvedThemeMode,
        );
      },
    );
  }
}
