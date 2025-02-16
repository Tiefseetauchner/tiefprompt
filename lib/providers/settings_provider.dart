import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tiefprompt/providers/prompter_provider.dart';
import 'package:tiefprompt/services/settings_service.dart';

part 'settings_provider.g.dart';
part 'settings_provider.freezed.dart';

@freezed
class SettingsState with _$SettingsState {
  factory SettingsState(
      {required double scrollSpeed,
      required bool mirroredX,
      required bool mirroredY,
      required double fontSize,
      required double sideMargin,
      required String fontFamily}) = _SettingsState;
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

  Future<void> setFontFamily(String fontFamily) async {
    await _settingsService.setFontFamily(fontFamily);
    state = AsyncValue.data(state.value!.copyWith(fontFamily: fontFamily));
  }
}
