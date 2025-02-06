import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_provider.g.dart';
part 'settings_provider.freezed.dart';

@freezed
class SettingsState with _$SettingsState {
  factory SettingsState({
    required double scrollSpeed,
    required bool mirroredX,
    required bool mirroredY,
  }) = _SettingsState;
}

class SettingsService {
  static const _speedKey = 'scroll_speed';
  static const _mirroredXKey = 'mirror_text_x';
  static const _mirroredYKey = 'mirror_text_y';

  Future<SettingsState> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    return SettingsState(
      scrollSpeed: prefs.getDouble(_speedKey) ?? 1.0,
      mirroredX: prefs.getBool(_mirroredXKey) ?? false,
      mirroredY: prefs.getBool(_mirroredYKey) ?? false,
    );
  }

  Future<void> setScrollSpeed(double speed) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_speedKey, speed);
  }

  Future<void> toggleMirroredX() async {
    final prefs = await SharedPreferences.getInstance();
    final currentValue = prefs.getBool(_mirroredXKey) ?? false;
    await prefs.setBool(_mirroredXKey, !currentValue);
  }

  Future<void> toggleMirroredY() async {
    final prefs = await SharedPreferences.getInstance();
    final currentValue = prefs.getBool(_mirroredYKey) ?? false;
    await prefs.setBool(_mirroredYKey, !currentValue);
  }
}

@riverpod
class Settings extends _$Settings {
  final _settingsService = SettingsService();
  @override
  Future<SettingsState> build() async {
    return await _settingsService.loadSettings();
  }

  Future<void> setScrollSpeed(double speed) async {
    state = AsyncValue.loading();
    await _settingsService.setScrollSpeed(speed);
    state = AsyncValue.data(state.value!.copyWith(scrollSpeed: speed));
  }

  Future<void> toggleMirroredX() async {
    state = AsyncValue.loading();
    await _settingsService.toggleMirroredX();
    state = AsyncValue.data(
        state.value!.copyWith(mirroredX: !state.value!.mirroredX));
  }

  Future<void> toggleMirroredY() async {
    state = AsyncValue.loading();
    await _settingsService.toggleMirroredY();
    state = AsyncValue.data(
        state.value!.copyWith(mirroredY: !state.value!.mirroredY));
  }
}
