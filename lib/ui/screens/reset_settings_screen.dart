import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/ui/widgets/safe_scaffold.dart';

const _defaultResetTitle = "Something went wrong";
const _defaultResetMessage =
    "We couldn't load your settings. Resetting them should get things working again.";

class ResetSettingsView extends ConsumerWidget {
  final String title;
  final String message;
  final Object? error;

  const ResetSettingsView({
    super.key,
    this.title = _defaultResetTitle,
    this.message = _defaultResetMessage,
    this.error,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Center(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: theme.colorScheme.error,
                ),
                const SizedBox(height: 24),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium,
                ),
                if (error != null) ...[
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(kBrandRadius),
                    ),
                    child: SelectableText(
                      error.toString(),
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontFamily: 'Roboto Mono',
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 32),
                Align(
                  child: ElevatedButton.icon(
                    onPressed: () =>
                        ref.read(settingsProvider.notifier).resetSettings(),
                    icon: const Icon(Icons.restart_alt),
                    label: const Text("Reset settings"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ResetSettingsScreen extends StatelessWidget {
  final String title;
  final String message;
  final Object? error;

  const ResetSettingsScreen({
    super.key,
    this.title = _defaultResetTitle,
    this.message = _defaultResetMessage,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      body: ResetSettingsView(title: title, message: message, error: error),
    );
  }
}
