import 'package:record/record.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tiefprompt/providers/banner_provider.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/providers/talker_provider.dart';

part 'voice_activation_provider.g.dart';

@Riverpod(keepAlive: true, dependencies: [Settings])
class VoiceActivation extends _$VoiceActivation {
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

    logger.debug(
      "Voice activation build with voiceActivationEnabled: $voiceActivationEnabled, voiceActivationThreshold: $voiceActivationThreshold, voiceActivationDevice: $voiceActivationDevice",
    );

    if (!voiceActivationEnabled) {
      return -100.0;
    }

    if (!await AudioRecorder().hasPermission()) {
      ref
          .read(bannerMessageProvider.notifier)
          .set("Audio recording permission denied");
      return 0.0;
    }

    AudioRecorder audioRecorder = AudioRecorder();

    final selectedDevice = voiceActivationDevice == "default"
        ? null
        : (await audioRecorder.listInputDevices()).firstWhere(
            (d) => d.id == voiceActivationDevice,
          );

    final _ = (await audioRecorder.startStream(
      RecordConfig(encoder: AudioEncoder.pcm16bits, device: selectedDevice),
    ));

    audioRecorder.onAmplitudeChanged(Duration(milliseconds: 50)).listen((data) {
      state = AsyncValue.data(data.current);
    });

    return 0.0;
  }
}
