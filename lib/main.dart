import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiefprompt/ui/screens/home_screen.dart';
import 'package:tiefprompt/ui/screens/open_file_screen.dart';
import 'package:tiefprompt/ui/screens/prompter_screen.dart';
import 'package:tiefprompt/ui/screens/settings_screen.dart';

void main() {
  runApp(const ProviderScope(child: TeleprompterApp()));
}

class TeleprompterApp extends StatelessWidget {
  const TeleprompterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Teleprompter',
      // TODO: Customize Theme
      //theme: ThemeData.dark(),
      routerConfig: _router,
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
