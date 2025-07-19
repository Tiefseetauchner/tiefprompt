import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tiefprompt/providers/theme_provider.dart';
import 'package:tiefprompt/ui/screens/home_screen.dart';
import 'package:tiefprompt/ui/screens/open_file_screen.dart';
import 'package:tiefprompt/ui/screens/prompter_screen.dart';
import 'package:tiefprompt/ui/screens/settings_screen.dart';

part 'router_provider.g.dart';

@Riverpod(keepAlive: true, dependencies: [Themes])
class TiefPromptRouter extends _$TiefPromptRouter {
  @override
  GoRouter build() {
    return GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
        GoRoute(
          path: '/teleprompter',
          builder: (context, state) {
            final theme = ref
                .read(themesProvider)
                .whenOrNull(data: (d) => d.prompterTheme);

            return Theme(
              data: theme ?? ThemeData.dark(),
              child: const PrompterScreen(),
            );
          },
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
    );
  }
}
