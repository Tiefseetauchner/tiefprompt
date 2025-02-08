import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_provider.g.dart';
part 'settings_provider.freezed.dart';

@freezed
class SettingsState with _$SettingsState {
  factory SettingsState({
    required int scrollSpeed,
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
      scrollSpeed: prefs.getInt(_speedKey) ?? 1,
      mirroredX: prefs.getBool(_mirroredXKey) ?? false,
      mirroredY: prefs.getBool(_mirroredYKey) ?? false,
    );
  }

  Future<bool> resetSettings() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }

  Future<void> setScrollSpeed(int speed) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_speedKey, speed);
  }

  Future<void> setMirroredX(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_mirroredXKey, value);
  }

  Future<void> setMirroredY(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_mirroredYKey, value);
  }
}

@riverpod
class Settings extends _$Settings {
  final _settingsService = SettingsService();
  @override
  Future<SettingsState> build() async {
    return await _settingsService.loadSettings();
  }

  Future<void> resetSettings() async {
    final success = await _settingsService.resetSettings();

    if (!success) {
      state = AsyncValue.error("Could not reset settings.", StackTrace.current);
    } else {
      state = AsyncValue.data(await _settingsService.loadSettings());
    }
  }

  Future<void> setScrollSpeed(int speed) async {
    await _settingsService.setScrollSpeed(speed);
    state = AsyncValue.data(state.value!.copyWith(scrollSpeed: speed));
  }

  Future<void> setMirroredX(bool value) async {
    await _settingsService.setMirroredX(value);
    state = AsyncValue.data(state.value!.copyWith(mirroredX: value));
  }

  Future<void> setMirroredY(bool value) async {
    await _settingsService.setMirroredY(value);
    state = AsyncValue.data(state.value!.copyWith(mirroredY: value));
  }
}
