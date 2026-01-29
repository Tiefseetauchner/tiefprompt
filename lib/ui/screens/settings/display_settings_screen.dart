import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/ui/widgets/app_settings.dart';

class DisplaySettingsScreen extends ConsumerWidget {
  const DisplaySettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return switch (settings) {
      AsyncData(:final value) => Scaffold(
        appBar: AppBar(
          title: Text(context.tr("SettingsScreen.DisplaySettings")),
        ),
        body: ListView(
          children: [
            NumberAppSetting(
              feature: Feature.scrollSpeed,
              value: value.scrollSpeed,
              displayText: context.tr(
                "SettingsScreen.NumberAppSetting_DefaultScrollSpeed",
              ),
              onValueChanged: (updatedValue) => ref
                  .read(settingsProvider.notifier)
                  .setScrollSpeed(updatedValue),
              min: kPrompterMinSpeed,
              max: kPrompterMaxSpeed,
              stepSize: .1,
              unit: context.tr(
                "SettingsScreen.NumberAppSetting_DefaultScrollSpeed_Unit",
              ),
            ),
            BooleanAppSetting(
              feature: Feature.flipX,
              value: value.mirroredX,
              displayText: context.tr(
                "SettingsScreen.BooleanAppSetting_DefaultFlipX",
              ),
              onValueChanged: (updatedValue) => ref
                  .read(settingsProvider.notifier)
                  .setMirroredX(updatedValue),
            ),
            BooleanAppSetting(
              feature: Feature.flipY,
              value: value.mirroredY,
              displayText: context.tr(
                "SettingsScreen.BooleanAppSetting_DefaultFlipY",
              ),
              onValueChanged: (updatedValue) => ref
                  .read(settingsProvider.notifier)
                  .setMirroredY(updatedValue),
            ),
            BooleanAppSetting(
              feature: Feature.readingIndicatorBoxes,
              value: value.displayReadingIndicatorBoxes,
              displayText: context.tr(
                "SettingsScreen.BooleanAppSetting_ReadingIndicatorBoxes",
              ),
              onValueChanged: (updatedValue) => ref
                  .read(settingsProvider.notifier)
                  .setDisplayReadingIndicatorBoxes(updatedValue),
            ),
            NumberAppSetting(
              feature: Feature.readingIndicatorBoxes,
              value: value.readingIndicatorBoxesHeight,
              displayText: context.tr(
                "SettingsScreen.NumberAppSetting_ReadingIndicatorBoxes",
              ),
              onValueChanged: (updatedValue) => ref
                  .read(settingsProvider.notifier)
                  .setReadingIndicatorBoxesHeight(updatedValue),
              min: 0,
              max: 100,
              stepSize: 5,
              unit: context.tr(
                "SettingsScreen.NumberAppSetting_ReadingIndicatorBoxes_Unit",
              ),
            ),
            BooleanAppSetting(
              feature: Feature.verticalMargins,
              value: value.displayVerticalMarginBoxes,
              displayText: context.tr(
                "SettingsScreen.BooleanAppSetting_VerticalMarginBoxes",
              ),
              onValueChanged: (updatedValue) => ref
                  .read(settingsProvider.notifier)
                  .setDisplayVerticalMarginBoxes(updatedValue),
            ),
            NumberAppSetting(
              feature: Feature.verticalMargins,
              value: value.verticalMarginBoxesHeight,
              displayText: context.tr(
                "SettingsScreen.NumberAppSetting_VerticalMarginBoxes",
              ),
              onValueChanged: (updatedValue) => ref
                  .read(settingsProvider.notifier)
                  .setVerticalMarginBoxesHeight(updatedValue),
              min: 0,
              max: 100,
              stepSize: 5,
              unit: context.tr(
                "SettingsScreen.NumberAppSetting_VerticalMarginBoxes_Unit",
              ),
            ),
            BooleanAppSetting(
              feature: Feature.verticalMarginFade,
              value: value.verticalMarginBoxesFadeEnabled,
              displayText: context.tr(
                "SettingsScreen.BooleanAppSetting_VerticalMarginBoxes_FadeEnabled",
              ),
              onValueChanged: (updatedValue) => ref
                  .read(settingsProvider.notifier)
                  .setVerticalMarginBoxesFadeEnabled(updatedValue),
            ),
            NumberAppSetting(
              feature: Feature.verticalMarginFade,
              value: value.verticalMarginBoxesFadeLength,
              displayText: context.tr(
                "SettingsScreen.NumberAppSetting_VerticalMarginBoxes_FadeLength",
              ),
              onValueChanged: (updatedValue) => ref
                  .read(settingsProvider.notifier)
                  .setVerticalMarginBoxesFadeLength(updatedValue),
              min: 0,
              max: 100,
              stepSize: 20,
              unit: context.tr(
                "SettingsScreen.NumberAppSetting_VerticalMarginBoxes_FadeLength_Unit",
              ),
            ),
            NumberAppSetting(
              feature: Feature.sideMargins,
              value: value.sideMargin,
              displayText: context.tr(
                "SettingsScreen.NumberAppSetting_SideMargin",
              ),
              onValueChanged: (updatedValue) => ref
                  .read(settingsProvider.notifier)
                  .setSideMargin(updatedValue),
              min: kPrompterMinSideMargin,
              max: kPrompterMaxSideMargin,
              unit: context.tr(
                "SettingsScreen.NumberAppSetting_SideMargin_Unit",
              ),
            ),
            NumberAppSetting(
              feature: Feature.countdownTimer,
              value: value.countdownDuration,
              displayText: context.tr(
                "SettingsScreen.NumberAppSetting_CountdownTimer",
              ),
              onValueChanged: (updatedValue) => ref
                  .read(settingsProvider.notifier)
                  .setCountdownDuration(updatedValue),
              min: 0,
              max: 60,
              stepSize: 1,
              unit: context.tr(
                "SettingsScreen.NumberAppSetting_CountdownTimer_Unit",
              ),
            ),
            ColorAppSetting(
              feature: Feature.prompterBackgroundColor,
              value: value.prompterBackgroundColor,
              displayText: context.tr(
                "SettingsScreen.ColorAppSetting_PrompterBackgroundColor",
              ),
              onValueChanged: (updatedValue) => ref
                  .read(settingsProvider.notifier)
                  .setPrompterBackgroundColor(updatedValue),
            ),
            ColorAppSetting(
              feature: Feature.prompterTextColor,
              value: value.prompterTextColor,
              displayText: context.tr(
                "SettingsScreen.ColorAppSetting_PrompterTextColor",
              ),
              onValueChanged: (updatedValue) => ref
                  .read(settingsProvider.notifier)
                  .setPrompterTextColor(updatedValue),
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
