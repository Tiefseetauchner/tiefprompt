import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiefprompt/providers/prompter_provider.dart';

part 'settings_provider.g.dart';
part 'settings_provider.freezed.dart';

@freezed
class SettingsState with _$SettingsState {
  factory SettingsState(
      {required double scrollSpeed,
      required bool mirroredX,
      required bool mirroredY,
      required double fontSize,
      required double sideMargin}) = _SettingsState;
}

class SettingsService {
  static const _speedKey = 'scroll_speed';
  static const _mirroredXKey = 'mirror_text_x';
  static const _mirroredYKey = 'mirror_text_y';
  static const _fontSizeKey = 'font_size';
  static const _sideMarginKey = 'side_margin';

  Future<SettingsState> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    return SettingsState(
      scrollSpeed: prefs.getDouble(_speedKey) ?? 1.0,
      mirroredX: prefs.getBool(_mirroredXKey) ?? false,
      mirroredY: prefs.getBool(_mirroredYKey) ?? false,
      fontSize: prefs.getDouble(_fontSizeKey) ?? 42.0,
      sideMargin: prefs.getDouble(_sideMarginKey) ?? 0.0,
    );
  }

  Future<bool> resetSettings() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }

  Future<void> setScrollSpeed(double speed) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_speedKey, speed);
  }

  Future<void> setMirroredX(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_mirroredXKey, value);
  }

  Future<void> setMirroredY(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_mirroredYKey, value);
  }

  Future<void> setFontSize(double fontSize) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_fontSizeKey, fontSize);
  }

  Future<void> setSideMargin(double sideMargin) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_sideMarginKey, sideMargin);
  }

  Future<void> applySettingsFromPrompter(PrompterState prompterState) async {
    await setScrollSpeed(prompterState.speed);
    await setMirroredX(prompterState.mirroredX);
    await setMirroredY(prompterState.mirroredY);
    await setFontSize(prompterState.fontSize);
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

  Future<void> setScrollSpeed(double speed) async {
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

  Future<void> setFontSize(double fontSize) async {
    await _settingsService.setFontSize(fontSize);
    state = AsyncValue.data(state.value!.copyWith(fontSize: fontSize));
  }

  Future<void> setSideMargin(double sideMargin) async {
    await _settingsService.setSideMargin(sideMargin);
    state = AsyncValue.data(state.value!.copyWith(sideMargin: sideMargin));
  }

  Future<void> applySettingsFromPrompter(PrompterState prompterState) async {
    await _settingsService.applySettingsFromPrompter(prompterState);
    state = AsyncValue.data(await _settingsService.loadSettings());
  }
}
