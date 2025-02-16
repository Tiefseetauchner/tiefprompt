import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiefprompt/providers/prompter_provider.dart';
import 'package:tiefprompt/providers/settings_provider.dart';

class SettingsService {
  static const _speedKey = 'scroll_speed';
  static const _mirroredXKey = 'mirror_text_x';
  static const _mirroredYKey = 'mirror_text_y';
  static const _fontSizeKey = 'font_size';
  static const _sideMarginKey = 'side_margin';
  static const _fontFamilyKey = 'font_family';
  static const _alignmentKey = 'alignment';

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

  Future<void> setFontFamily(String fontFamily) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_fontFamilyKey, fontFamily);
  }

  Future<void> setAlignment(TextAlign alignment) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_alignmentKey, alignment.toString());
  }

  Future<void> applySettingsFromPrompter(PrompterState prompterState) async {
    await setScrollSpeed(prompterState.speed);
    await setMirroredX(prompterState.mirroredX);
    await setMirroredY(prompterState.mirroredY);
    await setFontSize(prompterState.fontSize);
    await setSideMargin(prompterState.sideMargin);
    await setFontFamily(prompterState.fontFamily);
    await setAlignment(prompterState.alignment);
  }
}
