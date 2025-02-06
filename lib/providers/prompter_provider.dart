import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'prompter_provider.freezed.dart';
part 'prompter_provider.g.dart';

@freezed
class PrompterState with _$PrompterState {
  factory PrompterState({
    @Default(2.0) double speed,
    @Default(false) bool isPlaying,
  }) = _PrompterState;
}

@riverpod
class Prompter extends _$Prompter {
  @override
  PrompterState build() {
    return PrompterState();
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
}
