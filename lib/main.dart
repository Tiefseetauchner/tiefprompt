import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/providers/combining_provider.dart';
import 'package:tiefprompt/providers/router_provider.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  await el.EasyLocalization.ensureInitialized();

  runApp(
    ProviderScope(
      overrides: [],
      child: el.EasyLocalization(
        supportedLocales: kSupportedLocales.map((l10n) => l10n.$2).toList(),
        path: 'assets/translations',
        fallbackLocale: Locale('en', 'US'),
        child: TeleprompterApp(),
      ),
    ),
  );
}

class TeleprompterApp extends ConsumerWidget {
  const TeleprompterApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(
      settingsProvider.select((s) => s.whenData((d) => d.themeMode)),
    );
    final router = ref.watch(tiefPromptRouterProvider);
    final lightTheme = ref.watch(
      themesProvider.select((t) => t.whenData((d) => d.lightTheme)),
    );
    final darkTheme = ref.watch(
      themesProvider.select((t) => t.whenData((d) => d.darkTheme)),
    );
    final combiningProvider = ref.watch(
      combinedAsyncDataProvider.call([themeMode, lightTheme, darkTheme]),
    );

    return switch (combiningProvider) {
      AsyncData(:final value) => MaterialApp.router(
        title: 'Teleprompter',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        routerConfig: router,
        theme: value.states[1] as ThemeData,
        darkTheme: value.states[2] as ThemeData,
        themeMode: value.states[0] as ThemeMode,
      ),
      _ => Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: Column(
            children: [
              Text(
                "An exceedingly scary error occurred loading the settings or maybe even the themes ( :c ). Do you want to reset them?",
              ),
              ElevatedButton(
                onPressed: () =>
                    ref.read(settingsProvider.notifier).resetSettings(),
                child: Text("Reset Settings"),
              ),
            ],
          ),
        ),
      ),
    };
  }
}
