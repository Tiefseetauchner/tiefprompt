import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tiefprompt/providers/di_injection.dart';
import 'package:tiefprompt/providers/prompter_provider.dart';
import 'package:tiefprompt/services/settings_service.dart';

part 'settings_provider.g.dart';
part 'settings_provider.freezed.dart';

@freezed
class SettingsState with _$SettingsState {
  factory SettingsState({
    required double scrollSpeed,
    required bool mirroredX,
    required bool mirroredY,
    required double fontSize,
    required double sideMargin,
    required String fontFamily,
    required TextAlign alignment,
    required bool displayReadingIndicatorBoxes,
    required double readingIndicatorBoxesHeight,
    required bool displayVerticalMarginBoxes,
    required double verticalMarginBoxesHeight,
    required double countdownDuration,
    required bool verticalMarginBoxesFadeEnabled,
    required double verticalMarginBoxesFadeLength,
  }) = _SettingsState;
}

@riverpod
class Settings extends _$Settings {
  late final ISettingsService _settingsService;

  @override
  Future<SettingsState> build() async {
    _settingsService = ref.read(settingsServiceProvider);
    return await _settingsService.loadSettings();
  }

  Future<void> applySettingsFromPrompter(PrompterState prompterState) async {
    await _settingsService.applySettingsFromPrompter(prompterState);
    state = AsyncValue.data(await _settingsService.loadSettings());
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

  Future<void> setDisplayReadingIndicatorBoxes(bool value) async {
    await _settingsService.setDisplayReadingIndicatorBoxes(value);
    state = AsyncValue.data(
        state.value!.copyWith(displayReadingIndicatorBoxes: value));
  }

  Future<void> setReadingIndicatorBoxesHeight(double height) async {
    await _settingsService.setReadingIndicatorBoxesHeight(height);
    state = AsyncValue.data(
        state.value!.copyWith(readingIndicatorBoxesHeight: height));
  }

  Future<void> setDisplayVerticalMarginBoxes(bool value) async {
    await _settingsService.setDisplayVerticalMarginBoxes(value);
    state = AsyncValue.data(
        state.value!.copyWith(displayVerticalMarginBoxes: value));
  }

  Future<void> setVerticalMarginBoxesHeight(double height) async {
    await _settingsService.setVerticalMarginBoxesHeight(height);
    state = AsyncValue.data(
        state.value!.copyWith(verticalMarginBoxesHeight: height));
  }

  Future<void> setFontSize(double fontSize) async {
    await _settingsService.setFontSize(fontSize);
    state = AsyncValue.data(state.value!.copyWith(fontSize: fontSize));
  }

  Future<void> setSideMargin(double sideMargin) async {
    await _settingsService.setSideMargin(sideMargin);
    state = AsyncValue.data(state.value!.copyWith(sideMargin: sideMargin));
  }

  Future<void> setFontFamily(String fontFamily) async {
    await _settingsService.setFontFamily(fontFamily);
    state = AsyncValue.data(state.value!.copyWith(fontFamily: fontFamily));
  }

  Future<void> setAlignment(TextAlign alignment) async {
    await _settingsService.setAlignment(alignment);
    state = AsyncValue.data(state.value!.copyWith(alignment: alignment));
  }

  Future<void> setCountdownDuration(double duration) async {
    await _settingsService.setCountdownDuration(duration);
    state = AsyncValue.data(state.value!.copyWith(countdownDuration: duration));
  }

  Future<void> setVerticalMarginBoxesFadeEnabled(bool value) async {
    await _settingsService.setVerticalMarginBoxesFadeEnabled(value);
    state = AsyncValue.data(
        state.value!.copyWith(verticalMarginBoxesFadeEnabled: value));
  }

  Future<void> setVerticalMarginBoxesFadeLength(double length) async {
    await _settingsService.setVerticalMarginBoxesFadeLength(length);
    state = AsyncValue.data(
        state.value!.copyWith(verticalMarginBoxesFadeLength: length));
  }
}
