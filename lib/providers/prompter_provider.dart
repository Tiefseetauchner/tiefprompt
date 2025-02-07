import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tiefprompt/providers/settings_provider.dart';

part 'prompter_provider.freezed.dart';
part 'prompter_provider.g.dart';

@freezed
class PrompterState with _$PrompterState {
  factory PrompterState({
    @Default(0.35) double speed,
    @Default(false) bool mirroredX,
    @Default(false) bool mirroredY,
    @Default(48) double fontSize,
    @Default(false) bool isPlaying,
  }) = _PrompterState;
}

@riverpod
class Prompter extends _$Prompter {
  @override
  PrompterState build() {
    return PrompterState();
  }

  void applySettings(SettingsState settings) {
    state = state.copyWith(
      speed: settings.scrollSpeed,
      //fontSize: settings.fontSize,
      mirroredX: settings.mirroredX,
      mirroredY: settings.mirroredY,
    );
  }

  void setSpeed(double speed) {
    state = state.copyWith(speed: speed);
  }

  void increaseSpeed(double amount) {
    state = state.copyWith(speed: state.speed + amount);
  }

  void decreaseSpeed(double amount) {
    state = state.copyWith(speed: state.speed - amount);
  }

  void togglePlayPause() {
    state = state.copyWith(isPlaying: !state.isPlaying);
  }

  void toggleMirroredX() {
    state = state.copyWith(mirroredX: !state.mirroredX);
  }

  void toggleMirroredY() {
    state = state.copyWith(mirroredY: !state.mirroredY);
  }

  void increaseFontSize(double amount) {
    state = state.copyWith(fontSize: state.fontSize * amount);
  }

  void decreaseFontSize(double amount) {
    state = state.copyWith(fontSize: state.fontSize * amount);
  }
}
