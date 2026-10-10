import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:record/record.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tiefprompt/providers/banner_provider.dart';
import 'package:tiefprompt/providers/prompter_provider.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/providers/talker_provider.dart';

part 'voice_activation_provider.g.dart';

@Riverpod(keepAlive: true, dependencies: [Settings])
class VoiceActivation extends _$VoiceActivation {
  AudioRecorder? _audioRecorder;

  @override
  Future<double> build() async {
    final logger = ref.read(talkerProvider);

    final (
      :voiceActivationEnabled,
      :voiceActivationThreshold,
      :voiceActivationDevice,
    ) = await ref.watch(
      settingsProvider.selectAsync(
        (p) => (
          voiceActivationEnabled: p.config.voiceActivationEnabled,
          voiceActivationThreshold: p.config.voiceActivationThreshold,
          voiceActivationDevice: p.config.voiceActivationDevice,
        ),
      ),
    );

    final voiceActivationEnabledFromPrompter = ref.watch(
      prompterProvider.select((s) => s.config.voiceActivationEnabled),
    );
    final voiceActivationEnabledEffective =
        voiceActivationEnabled || voiceActivationEnabledFromPrompter;

    if (!voiceActivationEnabledEffective) {
      _audioRecorder?.dispose();
      _audioRecorder = null;
      return -100.0;
    }

    if (!await AudioRecorder().hasPermission()) {
      ref
          .read(bannerMessageProvider.notifier)
          .set("Audio recording permission denied");
      return -100.0;
    }

    _audioRecorder = AudioRecorder();

    if (_audioRecorder == null) {
      ref
          .read(bannerMessageProvider.notifier)
          .set("Failed to initialize audio recorder");
      return -100.0;
    }

    final availableDevices = await _audioRecorder!.listInputDevices();

    final selectedDevice =
        voiceActivationDevice == "default" ||
            !availableDevices.any(
              (device) => device.id == voiceActivationDevice,
            )
        ? null
        : availableDevices.firstWhere((d) => d.id == voiceActivationDevice);

    final _ = (await _audioRecorder!.startStream(
      RecordConfig(encoder: AudioEncoder.pcm16bits, device: selectedDevice),
    ));

    _audioRecorder!.onAmplitudeChanged(Duration(milliseconds: 200)).listen((
      data,
    ) {
      state = AsyncValue.data(data.current);
    });

    return -100.0;
  }
}
