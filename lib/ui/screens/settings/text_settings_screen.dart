import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tiefprompt/ui/widgets/async_settings_builder.dart';
import 'package:tiefprompt/ui/widgets/safe_scaffold.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/ui/widgets/app_settings.dart';

class TextSettingsScreen extends ConsumerWidget {
  const TextSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return AsyncSettingsBuilder(
      state: settings,
      screenTitle: context.tr("SettingsScreen.TextSettings"),
      builder: (ref, value) {
        final prompterConfig = value.config;

        return SafeScaffold(
          appBar: AppBar(
            title: Text(context.tr("SettingsScreen.TextSettings")),
          ),
          body: ListView(
            children: [
              NumberAppSetting(
                key: const Key("TextSettingsScreen.NumberAppSetting_FontSize"),
                feature: Feature.fontSize,
                value: prompterConfig.fontSize,
                displayText: context.tr(
                  "SettingsScreen.NumberAppSetting_DefaultFontSize",
                ),
                onValueChanged: (updatedValue) => ref
                    .read(settingsProvider.notifier)
                    .setFontSize(updatedValue),
                min: kPrompterMinFontSize,
                max: kPrompterMaxFontSize,
                unit: context.tr(
                  "SettingsScreen.NumberAppSetting_DefaultFontSize_Unit",
                ),
              ),
              DropdownAppSetting<TextAlign>(
                key: const Key(
                  "TextSettingsScreen.DropdownAppSetting_TextAlignment",
                ),
                feature: Feature.textAlignment,
                value: prompterConfig.alignment,
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
                key: const Key(
                  "TextSettingsScreen.DropdownAppSetting_FontFamily",
                ),
                feature: Feature.fontFamily,
                value: prompterConfig.fontFamily,
                displayText: context.tr(
                  "SettingsScreen.DropdownAppSetting_DefaultFontFamily",
                ),
                onValueChanged: (updatedValue) => ref
                    .read(settingsProvider.notifier)
                    .setFontFamily(updatedValue),
                values: kAvailableFonts.map((e) => (e, e)).toList(),
              ),
              BooleanAppSetting(
                key: const Key("TextSettingsScreen.BooleanAppSetting_Markdown"),
                feature: Feature.markdown,
                displayText: context.tr(
                  "SettingsScreen.BooleanAppSetting_Markdown",
                ),
                value: prompterConfig.markdownEnabled,
                onValueChanged: (updatedValue) => ref
                    .read(settingsProvider.notifier)
                    .setMarkdownEnabled(updatedValue),
              ),
              BooleanAppSetting(
                key: const Key(
                  "TextSettingsScreen.BooleanAppSetting_ShowCurrentChapter",
                ),
                feature: Feature.currentChapter,
                enabled: prompterConfig.markdownEnabled,
                value: prompterConfig.showCurrentChapter,
                displayText: context.tr(
                  "SettingsScreen.BooleanAppSetting_ShowCurrentChapter",
                ),
                onValueChanged: (updatedValue) => ref
                    .read(settingsProvider.notifier)
                    .setShowCurrentChapter(updatedValue),
              ),
            ],
          ),
        );
      },
    );
  }
}
