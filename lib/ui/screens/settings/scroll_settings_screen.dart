import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:record/record.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/ui/widgets/app_settings.dart';
import 'package:tiefprompt/ui/widgets/async_settings_builder.dart';
import 'package:tiefprompt/ui/widgets/audio_level_display.dart';
import 'package:tiefprompt/ui/widgets/safe_scaffold.dart';

class ScrollSettingsScreen extends ConsumerStatefulWidget {
  const ScrollSettingsScreen({super.key});

  @override
  ConsumerState<ScrollSettingsScreen> createState() =>
      _ScrollSettingsScreenState();
}

class _ScrollSettingsScreenState extends ConsumerState<ScrollSettingsScreen> {
  bool voiceActivationPreviewEnabled = false;
  late final Future<List<InputDevice>> audioDevices;

  @override
  void initState() {
    audioDevices = AudioRecorder().listInputDevices();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    ref.listen(settingsProvider, (previous, next) {
      next.whenData(
        (value) => setState(() {
          voiceActivationPreviewEnabled = value.config.voiceActivationEnabled;
        }),
      );
    });

    return AsyncSettingsBuilder(
      state: settings,
      screenTitle: context.tr("SettingsScreen.ScrollSettings.Title"),
      builder: (ref, value) {
        final prompterConfig = value.config;
        return FutureBuilder(
          future: audioDevices,
          initialData: <InputDevice>[
            InputDevice(
              id: prompterConfig.voiceActivationDevice,
              label: prompterConfig.voiceActivationDevice,
            ),
          ],
          builder: (context, snapshot) {
            List<(String, String)> devices =
                snapshot.data
                    ?.map(
                      (device) => ("${device.label} (${device.id})", device.id),
                    )
                    .toList() ??
                [];

            if (prompterConfig.voiceActivationDevice != "default" &&
                !devices.any(
                  (device) => device.$2 == prompterConfig.voiceActivationDevice,
                )) {
              devices.add((
                context.tr("SettingsScreen.ScrollSettings.UnknownDevice"),
                prompterConfig.voiceActivationDevice,
              ));
            }

            return SafeScaffold(
              appBar: AppBar(
                title: Text(context.tr("SettingsScreen.ScrollSettings.Title")),
              ),
              body: ListView(
                children: [
                  NumberAppSetting(
                    key: const Key(
                      "SettingsScreen.ScrollSettings.DefaultScrollSpeed",
                    ),
                    feature: Feature.scrollSpeed,
                    value: prompterConfig.scrollSpeed,
                    displayText: context.tr(
                      "SettingsScreen.ScrollSettings.DefaultScrollSpeed",
                    ),
                    onValueChanged: (updatedValue) => ref
                        .read(settingsProvider.notifier)
                        .setScrollSpeed(updatedValue),
                    min: kPrompterMinSpeed,
                    max: kPrompterMaxSpeed,
                    stepSize: .1,
                    unit: context.tr(
                      "SettingsScreen.ScrollSettings.DefaultScrollSpeed_Unit",
                    ),
                  ),
                  NumberAppSetting(
                    key: const Key(
                      "SettingsScreen.ScrollSettings.CountdownTimer",
                    ),
                    feature: Feature.countdownTimer,
                    value: prompterConfig.countdownDuration,
                    displayText: context.tr(
                      "SettingsScreen.ScrollSettings.CountdownTimer",
                    ),
                    onValueChanged: (updatedValue) => ref
                        .read(settingsProvider.notifier)
                        .setCountdownDuration(updatedValue),
                    min: 0,
                    max: 60,
                    stepSize: 1,
                    unit: context.tr(
                      "SettingsScreen.ScrollSettings.CountdownTimer_Unit",
                    ),
                  ),
                  BooleanAppSetting(
                    key: const Key(
                      "SettingsScreen.ScrollSettings.VoiceActivation",
                    ),
                    feature: Feature.voiceActivation,
                    value: prompterConfig.voiceActivationEnabled,
                    displayText: context.tr(
                      "SettingsScreen.ScrollSettings.VoiceActivation",
                    ),
                    onValueChanged: (updatedValue) => ref
                        .read(settingsProvider.notifier)
                        .setVoiceActivationEnabled(updatedValue),
                  ),
                  NumberAppSetting(
                    key: const Key(
                      "SettingsScreen.ScrollSettings.VoiceActivationThreshold",
                    ),
                    feature: Feature.voiceActivation,
                    value: prompterConfig.voiceActivationThreshold,
                    displayText: context.tr(
                      "SettingsScreen.ScrollSettings.VoiceActivationThreshold",
                    ),
                    onValueChanged: (updatedValue) => ref
                        .read(settingsProvider.notifier)
                        .setVoiceActivationThreshold(updatedValue),
                    enabled: prompterConfig.voiceActivationEnabled,
                    min: -60,
                    max: 0,
                    stepSize: 1,
                    unit: context.tr(
                      "SettingsScreen.ScrollSettings.VoiceActivationThreshold_Unit",
                    ),
                  ),
                  DropdownAppSetting<String>(
                    key: const Key(
                      "SettingsScreen.ScrollSettings.VoiceActivationDevices",
                    ),
                    feature: Feature.voiceActivation,
                    enabled: prompterConfig.voiceActivationEnabled,
                    value: prompterConfig.voiceActivationDevice,
                    displayText: context.tr(
                      "SettingsScreen.ScrollSettings.VoiceActivationDevices",
                    ),
                    values: [("Default", "default")]
                        .followedBy(
                          devices.where((device) => device.$2 != "default"),
                        )
                        .toList(),
                    onValueChanged: (updatedValue) => ref
                        .read(settingsProvider.notifier)
                        .setVoiceActivationDevice(updatedValue),
                  ),
                  ListTile(
                    key: const Key(
                      "SettingsScreen.ScrollSettings.VoiceActivationPreview",
                    ),
                    title: Text(
                      context.tr(
                        "SettingsScreen.ScrollSettings.VoiceActivationPreview",
                      ),
                    ),
                    enabled: prompterConfig.voiceActivationEnabled,
                    trailing: voiceActivationPreviewEnabled
                        ? AudioLevelDisplay(config: prompterConfig)
                        : null,
                    onTap: () => setState(() {
                      voiceActivationPreviewEnabled =
                          !voiceActivationPreviewEnabled;
                    }),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
