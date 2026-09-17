import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:tiefprompt/ui/widgets/async_settings_builder.dart';
import 'package:tiefprompt/ui/widgets/safe_scaffold.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/providers/feature_provider.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/ui/widgets/app_settings.dart';
import 'package:tiefprompt/ui/widgets/changelog_modal.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final featureKind = ref.watch(featuresProvider).featureKind;

    final title = context.tr("SettingsScreen.title");

    return AsyncSettingsBuilder(
      state: settings,
      screenTitle: title,
      builder: (ref, value) => SafeScaffold(
        appBar: AppBar(title: Text(title)),
        body: ListView(
          children: [
            DropdownAppSetting<Locale>(
              key: const Key(
                "SettingsScreen.DropdownAppSetting_DefaultLanguage",
              ),
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
              key: const Key("SettingsScreen.DisplaySettings"),
              displayText: context.tr("SettingsScreen.DisplaySettings"),
              feature: Feature.displaySettings,
              value: "/settings/display",
            ),
            LinkAppSetting(
              key: const Key("SettingsScreen.TextSettings"),
              displayText: context.tr("SettingsScreen.TextSettings"),
              feature: Feature.textSettings,
              value: "/settings/text",
            ),
            LinkAppSetting(
              key: const Key("SettingsScreen.KeybindingsSettings"),
              displayText: context.tr(
                "SettingsScreen.KeybindingsSettings.Title",
              ),
              feature: Feature.keybindings,
              value: "/settings/keybindings",
            ),
            DropdownAppSetting<ThemeMode>(
              key: const Key("SettingsScreen.DropdownAppSetting_Theme"),
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
              key: const Key("SettingsScreen.ColorAppSetting_AppPrimaryColor"),
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
              key: const Key("SettingsScreen.SettingsRestore"),
              displayText: context.tr("SettingsScreen.SettingsRestore.Title"),
              feature: Feature.settingsRestore,
              value: "/settings/settingsrestore",
            ),
            if (featureKind == FeatureKind.freeVersion ||
                featureKind == FeatureKind.paidVersion)
              ListTile(
                key: const Key("SettingsScreen.RestorePurchases"),
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
            LinkAppSetting(
              key: const Key("SettingsScreen.ShowHelpRequest"),
              displayText: context.tr("SettingsScreen.ShowHelpRequest"),
              feature: Feature.showHelpRequest,
              value: "/helprequest",
            ),
            ListTile(
              key: const Key("SettingsScreen.ShowChangelog"),
              title: Text(context.tr("SettingsScreen.ShowChangelog")),
              onTap: () => showChangelogModal(context),
            ),
            ListTile(
              key: const Key("SettingsScreen.ViewLogs"),
              leading: const Icon(Icons.bug_report_outlined),
              title: Text(context.tr("SettingsScreen.ViewLogs")),
              onTap: () => context.push('/settings/logs'),
            ),
            ListTile(
              key: const Key("SettingsScreen.ListTile_Reset"),
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
    );
  }
}
