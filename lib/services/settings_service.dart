import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiefprompt/providers/prompter_provider.dart';
import 'package:tiefprompt/providers/settings_provider.dart';

abstract class ISettingsService {
  Future<SettingsState> loadSettings();
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

  Future<void> applySettingsFromPrompter(PrompterState prompterState);
}

class SettingsService implements ISettingsService {
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

  @override
  Future<SettingsState> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    return SettingsState(
      scrollSpeed: prefs.getDouble(_speedKey) ?? 1.0,
      mirroredX: prefs.getBool(_mirroredXKey) ?? false,
      mirroredY: prefs.getBool(_mirroredYKey) ?? false,
      fontSize: prefs.getDouble(_fontSizeKey) ?? 42.0,
      sideMargin: prefs.getDouble(_sideMarginKey) ?? 0.0,
      fontFamily: prefs.getString(_fontFamilyKey) ?? 'Roboto',
      alignment: _getAlignment(
        prefs.getString(_alignmentKey) ?? 'left',
      ),
      displayReadingIndicatorBoxes: prefs.getBool(
            _displayReadingIndicatorBoxesKey,
          ) ??
          false,
      readingIndicatorBoxesHeight: prefs.getDouble(
            _readingIndicatorBoxesHeightKey,
          ) ??
          25,
      displayVerticalMarginBoxes: prefs.getBool(
            _displayVerticalMarginBoxesKey,
          ) ??
          false,
      verticalMarginBoxesHeight: prefs.getDouble(
            _verticalMarginBoxesHeightKey,
          ) ??
          25,
      countdownDuration: prefs.getDouble(
            _countdownDurationKey,
          ) ??
          5,
      verticalMarginBoxesFadeEnabled:
          prefs.getBool(_verticalMarginBoxesFadeEnabledKey) ?? false,
      verticalMarginBoxesFadeLength:
          prefs.getDouble(_verticalMarginBoxesFadeLengthKey) ?? 0.0,
    );
  }

  TextAlign _getAlignment(String alignment) {
    switch (alignment) {
      case 'TextAlign.left':
        return TextAlign.left;
      case 'TextAlign.center':
        return TextAlign.center;
      case 'TextAlign.right':
        return TextAlign.right;
      case 'TextAlign.justify':
        return TextAlign.justify;
      default:
        return TextAlign.left;
    }
  }

  @override
  Future<bool> resetSettings() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }

  @override
  Future<void> setScrollSpeed(double speed) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_speedKey, speed);
  }

  @override
  Future<void> setMirroredX(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_mirroredXKey, value);
  }

  @override
  Future<void> setMirroredY(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_mirroredYKey, value);
  }

  @override
  Future<void> setDisplayReadingIndicatorBoxes(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_displayReadingIndicatorBoxesKey, value);
  }

  @override
  Future<void> setReadingIndicatorBoxesHeight(double height) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_readingIndicatorBoxesHeightKey, height);
  }

  @override
  Future<void> setDisplayVerticalMarginBoxes(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_displayVerticalMarginBoxesKey, value);
  }

  @override
  Future<void> setVerticalMarginBoxesHeight(double height) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_verticalMarginBoxesHeightKey, height);
  }

  @override
  Future<void> setFontSize(double fontSize) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_fontSizeKey, fontSize);
  }

  @override
  Future<void> setSideMargin(double sideMargin) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_sideMarginKey, sideMargin);
  }

  @override
  Future<void> setFontFamily(String fontFamily) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_fontFamilyKey, fontFamily);
  }

  @override
  Future<void> setAlignment(TextAlign alignment) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_alignmentKey, alignment.toString());
  }

  @override
  Future<void> setCountdownDuration(double duration) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_countdownDurationKey, duration);
  }

  @override
  Future<void> setVerticalMarginBoxesFadeEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_verticalMarginBoxesFadeEnabledKey, value);
  }

  @override
  Future<void> setVerticalMarginBoxesFadeLength(double length) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_verticalMarginBoxesFadeLengthKey, length);
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
        prompterState.displayReadingIndicatorBoxes);
    await setReadingIndicatorBoxesHeight(
        prompterState.readingIndicatorBoxesHeight);
    await setDisplayVerticalMarginBoxes(
        prompterState.displayVerticalMarginBoxes);
    await setVerticalMarginBoxesHeight(prompterState.verticalMarginBoxesHeight);
    await setCountdownDuration(prompterState.countdownDuration);
    await setVerticalMarginBoxesFadeEnabled(
        prompterState.verticalMarginBoxesFadeEnabled);
    await setVerticalMarginBoxesFadeLength(
        prompterState.verticalMarginBoxesFadeLength);
  }
}
