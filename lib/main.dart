import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/core/theme.dart';
import 'package:tiefprompt/providers/di_injection.dart';
import 'package:tiefprompt/services/script_service.dart';
import 'package:tiefprompt/services/settings_service.dart';
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
  await EasyLocalization.ensureInitialized();

  runApp(
    ProviderScope(
      overrides: [
        scriptServiceProvider.overrideWithValue(ScriptService()),
        settingsServiceProvider.overrideWithValue(SettingsService())
      ],
      child: EasyLocalization(
        supportedLocales: kSupportedLocales.map((l10n) => l10n.$2).toList(),
        path: 'assets/translations',
        fallbackLocale: Locale('en', 'US'),
        child: TeleprompterApp(),
      ),
    ),
  );
}

class TeleprompterApp extends ConsumerWidget {
  TeleprompterApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Teleprompter',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerConfig: _router,
    );
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
          builder: (context, state) => Theme(
                data: prompterBlackTheme,
                child: const PrompterScreen(),
              )),
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
}
