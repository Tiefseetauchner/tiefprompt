import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiefprompt/providers/di_injection.dart';
import 'package:tiefprompt/services/script_service.dart';
import 'package:tiefprompt/services/settings_service.dart';
import 'package:tiefprompt/ui/screens/home_screen.dart';
import 'package:tiefprompt/ui/screens/open_file_screen.dart';
import 'package:tiefprompt/ui/screens/prompter_screen.dart';
import 'package:tiefprompt/ui/screens/settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale("en", "US"),
        Locale("zh", "CN"),
      ],
      path: 'assets/translations',
      fallbackLocale: Locale('en', 'US'),
      child: TeleprompterApp(),
    ),
  );
}

class TeleprompterApp extends StatelessWidget {
  const TeleprompterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        scriptServiceProvider.overrideWithValue(ScriptService()),
        settingsServiceProvider.overrideWithValue(SettingsService())
      ],
      child: MaterialApp.router(
        title: 'Teleprompter',

        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,

        // TODO: Customize Theme
        //theme: ThemeData.dark(),
        routerConfig: _router,
      ),
    );
  }
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/teleprompter',
      builder: (context, state) => const PrompterScreen(),
    ),
    GoRoute(
      path: '/open_file',
      builder: (context, state) => const OpenFileScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
