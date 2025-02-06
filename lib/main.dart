import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'ui/screens/home_screen.dart';
import 'ui/screens/prompter_screen.dart';

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
      theme: ThemeData.dark(),
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
  ],
);
