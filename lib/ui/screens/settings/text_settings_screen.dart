import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/ui/widgets/app_settings.dart';

class TextSettingsScreen extends ConsumerWidget {
  const TextSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return switch (settings) {
      AsyncData(:final value) => Scaffold(
        appBar: AppBar(title: Text(context.tr("SettingsScreen.TextSettings"))),
        body: ListView(
          children: [
            NumberAppSetting(
              feature: Feature.fontSize,
              value: value.fontSize,
              displayText: context.tr(
                "SettingsScreen.NumberAppSetting_DefaultFontSize",
              ),
              onValueChanged: (updatedValue) =>
                  ref.read(settingsProvider.notifier).setFontSize(updatedValue),
              min: kPrompterMinFontSize,
              max: kPrompterMaxFontSize,
              unit: context.tr(
                "SettingsScreen.NumberAppSetting_DefaultFontSize_Unit",
              ),
            ),
            DropdownAppSetting<TextAlign>(
              feature: Feature.textAlignment,
              value: value.alignment,
              displayText: context.tr(
                "SettingsScreen.DropdownAppSetting_DefaultTextAlignment",
              ),
              onValueChanged: (updatedValue) => ref
                  .read(settingsProvider.notifier)
                  .setAlignment(updatedValue),
              values: [
                (
                  context.tr(
                    "SettingsScreen.DropdownAppSetting_DefaultTextAlignment_Unit.Left",
                  ),
                  TextAlign.left,
                ),
                (
                  context.tr(
                    "SettingsScreen.DropdownAppSetting_DefaultTextAlignment_Unit.Center",
                  ),
                  TextAlign.center,
                ),
                (
                  context.tr(
                    "SettingsScreen.DropdownAppSetting_DefaultTextAlignment_Unit.Right",
                  ),
                  TextAlign.right,
                ),
                (
                  context.tr(
                    "SettingsScreen.DropdownAppSetting_DefaultTextAlignment_Unit.Justified",
                  ),
                  TextAlign.justify,
                ),
              ],
            ),
            DropdownAppSetting<String>(
              feature: Feature.fontFamily,
              value: value.fontFamily,
              displayText: context.tr(
                "SettingsScreen.DropdownAppSetting_DefaultFontFamily",
              ),
              onValueChanged: (updatedValue) => ref
                  .read(settingsProvider.notifier)
                  .setFontFamily(updatedValue),
              values: kAvailableFonts.map((e) => (e, e)).toList(),
            ),
            BooleanAppSetting(
              feature: Feature.markdown,
              displayText: context.tr(
                "SettingsScreen.BooleanAppSetting_Markdown",
              ),
              value: value.markdownEnabled,
              onValueChanged: (updatedValue) => ref
                  .read(settingsProvider.notifier)
                  .setMarkdownEnabled(updatedValue),
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
