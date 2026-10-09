import 'package:tiefprompt/providers/voice_activation_provider.dart';

class VoiceActivationFake extends VoiceActivation {
  VoiceActivationFake(this.level);

  final double level;

  @override
  Future<double> build() async {
    return level;
  }
}
