import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:record/record.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tiefprompt/providers/banner_provider.dart';
import 'package:tiefprompt/providers/prompter_provider.dart';

part 'voice_activation_provider.g.dart';

@Riverpod(keepAlive: true)
class VoiceActivation extends _$VoiceActivation {
  @override
  Future<double> build() async {
    final (:voiceActivationEnabled, :voiceActivationThreshold) = ref.watch(
      prompterProvider.select(
        (p) => (
          voiceActivationEnabled: p.config.voiceActivationEnabled,
          voiceActivationThreshold: p.config.voiceActivationThreshold,
        ),
      ),
    );

    if (!voiceActivationEnabled) {
      return 0.0;
    }

    if (!await AudioRecorder().hasPermission()) {
      ref
          .read(bannerMessageProvider.notifier)
          .set("Audio recording permission denied");
      return 0.0;
    }

    AudioRecorder audioRecorder = AudioRecorder();

    final _ = (await audioRecorder.startStream(
      RecordConfig(encoder: AudioEncoder.pcm16bits),
    ));

    audioRecorder.onAmplitudeChanged(Duration(milliseconds: 300)).listen((
      data,
    ) {
      state = AsyncValue.data(data.current);
    });

    return 0.0;
  }
}
