import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/models/keybinding.dart';
import 'package:tiefprompt/providers/keybinding_provider.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/ui/widgets/app_settings.dart';

class KeybindingsSettingsScreen extends ConsumerWidget {
  const KeybindingsSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final keybindings = ref.watch(keybindingsProvider);

    return switch (keybindings) {
      AsyncData(:final value) => Scaffold(
        appBar: AppBar(
          title: Text(context.tr("SettingsScreen.KeybindingsSettings.Title")),
        ),
        body: ListView(
          children: [
            ...KeybindingAction.values.map((b) {
              return KeybindingAppSetting(
                feature: Feature.keybindings,
                displayText: context.tr(
                  "SettingsScreen.KeybindingsSettings.${b.name}",
                ),
                bindings: value.keybindings
                    .where((k) => k.$1 == b)
                    .map((e) => e.$2)
                    .toList(),
                bindingAction: b,
              );
            }),
            ListTile(
              title: Text(
                context.tr("SettingsScreen.KeybindingsSettings.ResetBindings"),
              ),
              onTap: () {
                ref.read(keybindingsProvider.notifier).resetToDefaults();
              },
            ),
          ],
        ),
      ),
      AsyncLoading() => Scaffold(
        appBar: AppBar(
          title: Text(context.tr("SettingsScreen.KeybindingsSettings.Title")),
        ),
        body: SpinKitRing(
          color:
              ref.read(settingsProvider).value?.appPrimaryColor ??
              Color.fromARGB(255, 77, 103, 214),
        ),
      ),
      _ => Center(
        child: Column(
          children: [
            Text(
              "An error occurred loading the settings. Do you want to reset them?",
            ),
            ElevatedButton(
              onPressed: () =>
                  ref.read(settingsProvider.notifier).resetSettings(),
              child: Text("Reset Settings"),
            ),
          ],
        ),
      ),
    };
  }
}
