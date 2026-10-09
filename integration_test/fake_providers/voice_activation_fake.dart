import 'package:tiefprompt/providers/voice_activation_provider.dart';

class VoiceActivationFake extends VoiceActivation {
  @override
  Future<double> build() async {
    return -22.0;
  }
}
