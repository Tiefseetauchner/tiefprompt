import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiefprompt/providers/theme_provider.dart';

class PrompterThemeScope extends ConsumerWidget {
  final Widget child;

  const PrompterThemeScope({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref
        .watch(themesProvider)
        .whenOrNull(data: (d) => d.prompterTheme);

    return Theme(data: theme ?? ThemeData.dark(), child: child);
  }
}
