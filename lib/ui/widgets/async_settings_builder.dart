import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/ui/screens/reset_settings_screen.dart';
import 'package:tiefprompt/ui/widgets/safe_scaffold.dart';

class AsyncSettingsBuilder<T> extends ConsumerWidget {
  final AsyncValue<T> state;
  final Widget Function(WidgetRef ref, T value) builder;
  final String screenTitle;

  const AsyncSettingsBuilder({
    super.key,
    required this.state,
    required this.builder,
    required this.screenTitle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (state) {
      AsyncData(:final value) => builder(ref, value),
      AsyncLoading() => Center(
        child: SafeScaffold(
          appBar: AppBar(title: Text(screenTitle)),
          body: SpinKitRing(
            color:
                ref.read(settingsProvider).value?.appPrimaryColor ?? kBrandTeal,
          ),
        ),
      ),
      _ => const ResetSettingsScreen(),
    };
  }
}
