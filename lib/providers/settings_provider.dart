import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiefprompt/providers/prompter_provider.dart';

part 'settings_provider.freezed.dart';
part 'settings_provider.g.dart';

@freezed
abstract class SettingsState with _$SettingsState {
  factory SettingsState({
    @Default(1.0) double scrollSpeed,
    @Default(false) bool mirroredX,
    @Default(false) bool mirroredY,
    @Default(42.0) double fontSize,
    @Default(0.0) double sideMargin,
    @Default('Roboto') String fontFamily,
    @Default(TextAlign.left) TextAlign alignment,
    @Default(false) bool displayReadingIndicatorBoxes,
    @Default(60.0) double readingIndicatorBoxesHeight,
    @Default(false) bool displayVerticalMarginBoxes,
    @Default(35.0) double verticalMarginBoxesHeight,
    @Default(false) bool verticalMarginBoxesFadeEnabled,
    @Default(50.0) double verticalMarginBoxesFadeLength,
    @Default(0.0) double countdownDuration,
    @Default(ThemeMode.system) ThemeMode themeMode,
  }) = _SettingsState;
}

abstract class ISettings {
  Future<bool> resetSettings();

  Future<void> setScrollSpeed(double speed);
  Future<void> setMirroredX(bool value);
  Future<void> setMirroredY(bool value);
  Future<void> setFontSize(double fontSize);
  Future<void> setSideMargin(double sideMargin);
  Future<void> setFontFamily(String fontFamily);
  Future<void> setAlignment(TextAlign alignment);
  Future<void> setDisplayReadingIndicatorBoxes(bool value);
  Future<void> setReadingIndicatorBoxesHeight(double height);
  Future<void> setDisplayVerticalMarginBoxes(bool value);
  Future<void> setVerticalMarginBoxesHeight(double height);
  Future<void> setCountdownDuration(double duration);
  Future<void> setVerticalMarginBoxesFadeEnabled(bool value);
  Future<void> setVerticalMarginBoxesFadeLength(double length);
  Future<void> setThemeMode(ThemeMode themeMode);

  Future<void> applySettingsFromPrompter(PrompterState prompterState);
}

@Riverpod(dependencies: [])
class Settings extends _$Settings implements ISettings {
  static const _speedKey = 'scroll_speed';
  static const _mirroredXKey = 'mirror_text_x';
  static const _mirroredYKey = 'mirror_text_y';
  static const _fontSizeKey = 'font_size';
  static const _sideMarginKey = 'side_margin';
  static const _fontFamilyKey = 'font_family';
  static const _alignmentKey = 'alignment';
  static const _displayReadingIndicatorBoxesKey =
      'display_reading_indicator_boxes';
  static const _readingIndicatorBoxesHeightKey =
      'reading_indicator_boxes_height';
  static const _displayVerticalMarginBoxesKey = 'display_vertical_margin_boxes';
  static const _verticalMarginBoxesHeightKey = 'vertical_margin_boxes_height';
  static const _countdownDurationKey = 'countdown_duration';
  static const _verticalMarginBoxesFadeEnabledKey = 'fade_enabled';
  static const _verticalMarginBoxesFadeLengthKey = 'fade_length';
  static const _themeModeKey = 'theme_mode';

  late final SharedPreferences _prefs;

  @override
  Future<SettingsState> build() async {
    _prefs = await SharedPreferences.getInstance();
    return SettingsState().copyWith(
      scrollSpeed: _prefs.getDouble(_speedKey) ?? 1.0,
      mirroredX: _prefs.getBool(_mirroredXKey) ?? false,
      mirroredY: _prefs.getBool(_mirroredYKey) ?? false,
      fontSize: _prefs.getDouble(_fontSizeKey) ?? 42.0,
      sideMargin: _prefs.getDouble(_sideMarginKey) ?? 0.0,
      fontFamily: _prefs.getString(_fontFamilyKey) ?? 'Roboto',
      alignment: _getAlignment(_prefs.getString(_alignmentKey)),
      displayReadingIndicatorBoxes:
          _prefs.getBool(_displayReadingIndicatorBoxesKey) ?? false,
      readingIndicatorBoxesHeight:
          _prefs.getDouble(_readingIndicatorBoxesHeightKey) ?? 60.0,
      displayVerticalMarginBoxes:
          _prefs.getBool(_displayVerticalMarginBoxesKey) ?? false,
      verticalMarginBoxesHeight:
          _prefs.getDouble(_verticalMarginBoxesHeightKey) ?? 35.0,
      verticalMarginBoxesFadeEnabled:
          _prefs.getBool(_verticalMarginBoxesFadeEnabledKey) ?? false,
      verticalMarginBoxesFadeLength:
          _prefs.getDouble(_verticalMarginBoxesFadeLengthKey) ?? 50.0,
      countdownDuration: _prefs.getDouble(_countdownDurationKey) ?? 0.0,
      themeMode: _getThemeMode(_prefs.getString(_themeModeKey)),
    );
  }

  TextAlign _getAlignment(String? alignment) {
    return TextAlign.values
            .where((element) => element.name == alignment)
            .singleOrNull ??
        TextAlign.left;
  }

  ThemeMode _getThemeMode(String? themeMode) {
    return ThemeMode.values
            .where((element) => element.name == themeMode)
            .singleOrNull ??
        ThemeMode.system;
  }

  @override
  Future<bool> resetSettings() async {
    return await _prefs.clear();
  }

  @override
  Future<void> setScrollSpeed(double speed) async {
    await _prefs.setDouble(_speedKey, speed);

    state = state.whenData((s) => s.copyWith(scrollSpeed: speed));
  }

  @override
  Future<void> setMirroredX(bool value) async {
    await _prefs.setBool(_mirroredXKey, value);

    state = state.whenData((s) => s.copyWith(mirroredX: value));
  }

  @override
  Future<void> setMirroredY(bool value) async {
    await _prefs.setBool(_mirroredYKey, value);

    state = state.whenData((s) => s.copyWith(mirroredY: value));
  }

  @override
  Future<void> setDisplayReadingIndicatorBoxes(bool value) async {
    await _prefs.setBool(_displayReadingIndicatorBoxesKey, value);

    state = state.whenData(
      (s) => s.copyWith(displayReadingIndicatorBoxes: value),
    );
  }

  @override
  Future<void> setReadingIndicatorBoxesHeight(double height) async {
    await _prefs.setDouble(_readingIndicatorBoxesHeightKey, height);

    state = state.whenData(
      (s) => s.copyWith(readingIndicatorBoxesHeight: height),
    );
  }

  @override
  Future<void> setDisplayVerticalMarginBoxes(bool value) async {
    await _prefs.setBool(_displayVerticalMarginBoxesKey, value);

    state = state.whenData(
      (s) => s.copyWith(displayVerticalMarginBoxes: value),
    );
  }

  @override
  Future<void> setVerticalMarginBoxesHeight(double height) async {
    await _prefs.setDouble(_verticalMarginBoxesHeightKey, height);

    state = state.whenData(
      (s) => s.copyWith(verticalMarginBoxesHeight: height),
    );
  }

  @override
  Future<void> setVerticalMarginBoxesFadeEnabled(bool value) async {
    await _prefs.setBool(_verticalMarginBoxesFadeEnabledKey, value);

    state = state.whenData(
      (s) => s.copyWith(verticalMarginBoxesFadeEnabled: value),
    );
  }

  @override
  Future<void> setVerticalMarginBoxesFadeLength(double length) async {
    await _prefs.setDouble(_verticalMarginBoxesFadeLengthKey, length);

    state = state.whenData(
      (s) => s.copyWith(verticalMarginBoxesFadeLength: length),
    );
  }

  @override
  Future<void> setSideMargin(double sideMargin) async {
    await _prefs.setDouble(_sideMarginKey, sideMargin);

    state = state.whenData((s) => s.copyWith(sideMargin: sideMargin));
  }

  @override
  Future<void> setFontFamily(String fontFamily) async {
    await _prefs.setString(_fontFamilyKey, fontFamily);

    state = state.whenData((s) => s.copyWith(fontFamily: fontFamily));
  }

  @override
  Future<void> setFontSize(double fontSize) async {
    await _prefs.setDouble(_fontSizeKey, fontSize);

    state = state.whenData((s) => s.copyWith(fontSize: fontSize));
  }

  @override
  Future<void> setAlignment(TextAlign alignment) async {
    await _prefs.setString(_alignmentKey, alignment.toString());

    state = state.whenData((s) => s.copyWith(alignment: alignment));
  }

  @override
  Future<void> setCountdownDuration(double duration) async {
    await _prefs.setDouble(_countdownDurationKey, duration);

    state = state.whenData((s) => s.copyWith(countdownDuration: duration));
  }

  @override
  Future<void> setThemeMode(ThemeMode themeMode) async {
    await _prefs.setString(_themeModeKey, themeMode.name);

    state = state.whenData((s) => s.copyWith(themeMode: themeMode));
  }

  @override
  Future<void> applySettingsFromPrompter(PrompterState prompterState) async {
    await setScrollSpeed(prompterState.speed);
    await setMirroredX(prompterState.mirroredX);
    await setMirroredY(prompterState.mirroredY);
    await setFontSize(prompterState.fontSize);
    await setSideMargin(prompterState.sideMargin);
    await setFontFamily(prompterState.fontFamily);
    await setAlignment(prompterState.alignment);
    await setDisplayReadingIndicatorBoxes(
      prompterState.displayReadingIndicatorBoxes,
    );
    await setReadingIndicatorBoxesHeight(
      prompterState.readingIndicatorBoxesHeight,
    );
    await setDisplayVerticalMarginBoxes(
      prompterState.displayVerticalMarginBoxes,
    );
    await setVerticalMarginBoxesHeight(prompterState.verticalMarginBoxesHeight);
    await setCountdownDuration(prompterState.countdownDuration);
    await setVerticalMarginBoxesFadeEnabled(
      prompterState.verticalMarginBoxesFadeEnabled,
    );
    await setVerticalMarginBoxesFadeLength(
      prompterState.verticalMarginBoxesFadeLength,
    );
  }
}
