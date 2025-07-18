import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/providers/combining_provider.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/providers/theme_provider.dart';
import 'package:tiefprompt/ui/screens/home_screen.dart';
import 'package:tiefprompt/ui/screens/open_file_screen.dart';
import 'package:tiefprompt/ui/screens/prompter_screen.dart';
import 'package:tiefprompt/ui/screens/settings_screen.dart';

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
    final settings = ref.watch(settingsProvider);
    final themes = ref.watch(themesProvider);
    final combiningProvider = ref.watch(
      combinedAsyncDataProvider.call([settings, themes]),
    );

    return switch (combiningProvider) {
      AsyncData(:final value) => MaterialApp.router(
        title: 'Teleprompter',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        routerConfig: GoRouter(
          initialLocation: '/',
          routes: [
            GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
            GoRoute(
              path: '/teleprompter',
              builder: (context, state) => Theme(
                data: (value.states[1] as ThemesState).prompterTheme,
                child: const PrompterScreen(),
              ),
            ),
            GoRoute(
              path: '/open_file',
              builder: (context, state) => const OpenFileScreen(),
            ),
            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingsScreen(),
              routes: [
                GoRoute(
                  path: 'display',
                  builder: (context, state) => const DisplaySettingsScreen(),
                ),
                GoRoute(
                  path: 'text',
                  builder: (context, state) => const TextSettingsScreen(),
                ),
              ],
            ),
          ],
        ),
        theme: (value.states[1] as ThemesState).lightTheme,
        darkTheme: (value.states[1] as ThemesState).darkTheme,
        themeMode: (value.states[0] as SettingsState).themeMode,
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
