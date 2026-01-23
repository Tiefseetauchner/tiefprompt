import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/providers/feature_provider.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/ui/widgets/app_settings.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final featureKind = ref.watch(featuresProvider).featureKind;

    return switch (settings) {
      AsyncData(:final value) => Scaffold(
        appBar: AppBar(title: Text(context.tr("SettingsScreen.title"))),
        body: ListView(
          children: [
            DropdownAppSetting<Locale>(
              feature: Feature.appLanguage,
              value: context.locale,
              displayText: context.tr(
                "SettingsScreen.DropdownAppSetting_DefaultLanguage",
              ),
              onValueChanged: (updatedValue) {
                context.setLocale(updatedValue);
              },
              values: kSupportedLocales,
            ),
            LinkAppSetting(
              displayText: context.tr("SettingsScreen.DisplaySettings"),
              feature: Feature.displaySettings,
              value: "display",
            ),
            LinkAppSetting(
              displayText: context.tr("SettingsScreen.TextSettings"),
              feature: Feature.textSettings,
              value: "text",
            ),
            LinkAppSetting(
              displayText: context.tr(
                "SettingsScreen.KeybindingsSettings.Title",
              ),
              feature: Feature.keybindings,
              value: "keybindings",
            ),
            DropdownAppSetting<ThemeMode>(
              feature: Feature.appTheme,
              value: value.themeMode,
              displayText: context.tr(
                "SettingsScreen.DropdownAppSetting_Theme",
              ),
              onValueChanged: (updatedValue) {
                ref.read(settingsProvider.notifier).setThemeMode(updatedValue);
              },
              values: ThemeMode.values
                  .map(
                    (mode) => (
                      mode.name[0].toUpperCase() + mode.name.substring(1),
                      mode,
                    ),
                  )
                  .toList(),
            ),
            ColorAppSetting(
              feature: Feature.primaryAppColor,
              value: value.appPrimaryColor,
              displayText: context.tr(
                "SettingsScreen.ColorAppSetting_AppPrimaryColor",
              ),
              onValueChanged: (updatedValue) => ref
                  .read(settingsProvider.notifier)
                  .setAppPrimaryColor(updatedValue),
            ),
            LinkAppSetting(
              displayText: context.tr("SettingsScreen.SettingsRestore.Title"),
              feature: Feature.settingsRestore,
              value: "settingsrestore",
            ),
            if (featureKind == FeatureKind.freeVersion ||
                featureKind == FeatureKind.paidVersion)
              ListTile(
                title: Text(context.tr("SettingsScreen.RestorePurchases")),
                leading: Icon(Icons.restore),
                onTap: () {
                  ref.read(featuresProvider.notifier).restorePurchase();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        context.tr("SettingsScreen.RestorePurchases_Snackbar"),
                      ),
                    ),
                  );
                },
              ),
            ListTile(
              hoverColor: const Color.fromARGB(255, 255, 175, 169),
              title: Text(context.tr("SettingsScreen.ListTile_Reset")),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(context.tr("SettingsScreen.Reset_Warning")),
                    icon: Icon(
                      Icons.warning_amber_rounded,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(context.tr("SettingsScreen.Abort")),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.error,
                          foregroundColor: Theme.of(
                            context,
                          ).colorScheme.onError,
                        ),
                        onPressed: () {
                          ref.read(settingsProvider.notifier).resetSettings();
                          Navigator.pop(context);
                        },
                        child: Text(context.tr("SettingsScreen.Confirm")),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
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
