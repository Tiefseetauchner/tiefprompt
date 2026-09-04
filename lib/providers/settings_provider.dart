import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tief_weave/markdown.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/core/control_buttons.dart';
import 'package:tiefprompt/core/json_converters.dart';
import 'package:tiefprompt/providers/prompter_config.dart';
import 'package:tiefprompt/providers/prompter_provider.dart';

part 'settings_provider.freezed.dart';
part 'settings_provider.g.dart';

@freezed
abstract class SettingsState with _$SettingsState {
  const SettingsState._();

  factory SettingsState({
    @ThemeModeConverter() @Default(ThemeMode.system) ThemeMode themeMode,
    @ColorConverter() @Default(kBrandTeal) Color appPrimaryColor,
    @ColorConverter() @Default(Colors.black) Color prompterBackgroundColor,
    @ColorConverter() @Default(Colors.white) Color prompterTextColor,
    @Default(0) int keybindingsMapId,
    @Default(PrompterConfiguration()) PrompterConfiguration config,
  }) = _SettingsState;

  factory SettingsState.fromJson(Map<String, dynamic> json) =>
      _$SettingsStateFromJson(json);
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
  Future<void> setAppPrimaryColor(Color color);
  Future<void> setPrompterBackgroundColor(Color color);
  Future<void> setPrompterTextColor(Color color);
  Future<void> setMarkdownEnabled(bool enabled);
  Future<void> setShowControlButtons(bool enabled);
  Future<void> setControlButtonsPosition(ControlButtonsPosition position);
  Future<void> setKeybindings(int mapId);
  Future<void> setShowCurrentChapter(bool value);
  Future<void> setTextDirectionMode(TextDirectionMode textDirectionMode);

  Future<void> loadSettings(SettingsState newState);

  Future<void> applySettingsFromPrompter(PrompterState prompterState);
}

@Riverpod(keepAlive: true, dependencies: [])
class Settings extends _$Settings implements ISettings {
  static const _jsonKey = 'settings_json';

  late final SharedPreferences _prefs;

  @override
  Future<SettingsState> build() async {
    _prefs = await SharedPreferences.getInstance();

    final raw = _prefs.getString(_jsonKey);
    if (raw != null) {
      return SettingsState.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    }

    return await _migrateLegacyPrefs() ?? SettingsState();
  }

  Future<void> _persist(SettingsState settings) async {
    await _prefs.setString(_jsonKey, jsonEncode(settings.toJson()));
  }

  Future<void> _mutate(SettingsState Function(SettingsState) update) async {
    final current = state.value;
    if (current == null) return;
    final next = update(current);
    state = AsyncData(next);
    await _persist(next);
  }

  Future<void> _mutateConfig(
    PrompterConfiguration Function(PrompterConfiguration) update,
  ) => _mutate((s) => s.copyWith(config: update(s.config)));

  @override
  Future<bool> resetSettings() async {
    state = AsyncData(SettingsState());
    return await _prefs.clear();
  }

  @override
  Future<void> setScrollSpeed(double speed) =>
      _mutateConfig((c) => c.copyWith(scrollSpeed: speed));

  @override
  Future<void> setMirroredX(bool value) =>
      _mutateConfig((c) => c.copyWith(mirroredX: value));

  @override
  Future<void> setMirroredY(bool value) =>
      _mutateConfig((c) => c.copyWith(mirroredY: value));

  @override
  Future<void> setFontSize(double fontSize) =>
      _mutateConfig((c) => c.copyWith(fontSize: fontSize));

  @override
  Future<void> setSideMargin(double sideMargin) =>
      _mutateConfig((c) => c.copyWith(sideMargin: sideMargin));

  @override
  Future<void> setFontFamily(String fontFamily) =>
      _mutateConfig((c) => c.copyWith(fontFamily: fontFamily));

  @override
  Future<void> setAlignment(TextAlign alignment) =>
      _mutateConfig((c) => c.copyWith(alignment: alignment));

  @override
  Future<void> setDisplayReadingIndicatorBoxes(bool value) =>
      _mutateConfig((c) => c.copyWith(displayReadingIndicatorBoxes: value));

  @override
  Future<void> setReadingIndicatorBoxesHeight(double height) =>
      _mutateConfig((c) => c.copyWith(readingIndicatorBoxesHeight: height));

  @override
  Future<void> setDisplayVerticalMarginBoxes(bool value) =>
      _mutateConfig((c) => c.copyWith(displayVerticalMarginBoxes: value));

  @override
  Future<void> setVerticalMarginBoxesHeight(double height) =>
      _mutateConfig((c) => c.copyWith(verticalMarginBoxesHeight: height));

  @override
  Future<void> setVerticalMarginBoxesFadeEnabled(bool value) =>
      _mutateConfig((c) => c.copyWith(verticalMarginBoxesFadeEnabled: value));

  @override
  Future<void> setVerticalMarginBoxesFadeLength(double length) =>
      _mutateConfig((c) => c.copyWith(verticalMarginBoxesFadeLength: length));

  @override
  Future<void> setCountdownDuration(double duration) =>
      _mutateConfig((c) => c.copyWith(countdownDuration: duration));

  @override
  Future<void> setMarkdownEnabled(bool enabled) =>
      _mutateConfig((c) => c.copyWith(markdownEnabled: enabled));

  @override
  Future<void> setShowControlButtons(bool enabled) =>
      _mutateConfig((c) => c.copyWith(showControlButtons: enabled));

  @override
  Future<void> setControlButtonsPosition(ControlButtonsPosition position) =>
      _mutateConfig((c) => c.copyWith(controlButtonsPosition: position));

  @override
  Future<void> setShowCurrentChapter(bool value) =>
      _mutateConfig((c) => c.copyWith(showCurrentChapter: value));

  @override
  Future<void> setTextDirectionMode(TextDirectionMode textDirectionMode) =>
      _mutateConfig((c) => c.copyWith(textDirectionMode: textDirectionMode));

  @override
  Future<void> setThemeMode(ThemeMode themeMode) =>
      _mutate((s) => s.copyWith(themeMode: themeMode));

  @override
  Future<void> setAppPrimaryColor(Color color) =>
      _mutate((s) => s.copyWith(appPrimaryColor: color));

  @override
  Future<void> setPrompterBackgroundColor(Color color) =>
      _mutate((s) => s.copyWith(prompterBackgroundColor: color));

  @override
  Future<void> setPrompterTextColor(Color color) =>
      _mutate((s) => s.copyWith(prompterTextColor: color));

  @override
  Future<void> setKeybindings(int mapId) =>
      _mutate((s) => s.copyWith(keybindingsMapId: mapId));

  @override
  Future<void> loadSettings(SettingsState newState) async {
    final normalized = newState.copyWith(keybindingsMapId: 0);
    state = AsyncData(normalized);
    await _persist(normalized);
  }

  @override
  Future<void> applySettingsFromPrompter(PrompterState prompterState) =>
      _mutate((s) => s.copyWith(config: prompterState.config));

  Future<SettingsState?> _migrateLegacyPrefs() async {
    const legacyKeys = [
      'scroll_speed',
      'mirror_text_x',
      'mirror_text_y',
      'font_size',
      'side_margin',
      'font_family',
      'alignment',
      'display_reading_indicator_boxes',
      'reading_indicator_boxes_height',
      'display_vertical_margin_boxes',
      'vertical_margin_boxes_height',
      'countdown_duration',
      'fade_enabled',
      'fade_length',
      'theme_mode',
      'app_primary_color',
      'prompter_background_color',
      'prompter_text_color',
      'markdown_enabled',
      'show_control_buttons',
      'control_buttons_position',
      'keybindings_map_id',
      'show_current_chapter',
    ];

    if (!legacyKeys.any(_prefs.containsKey)) return null;

    final migrated = SettingsState(
      config: PrompterConfiguration(
        scrollSpeed: _prefs.getDouble('scroll_speed') ?? 1.0,
        mirroredX: _prefs.getBool('mirror_text_x') ?? false,
        mirroredY: _prefs.getBool('mirror_text_y') ?? false,
        fontSize: _prefs.getDouble('font_size') ?? 42.0,
        sideMargin: _prefs.getDouble('side_margin') ?? 0.0,
        fontFamily: _prefs.getString('font_family') ?? 'Roboto',
        alignment: const TextAlignConverter().fromJson(
          _prefs.getString('alignment') ?? '',
        ),
        displayReadingIndicatorBoxes:
            _prefs.getBool('display_reading_indicator_boxes') ?? false,
        readingIndicatorBoxesHeight:
            _prefs.getDouble('reading_indicator_boxes_height') ?? 60.0,
        displayVerticalMarginBoxes:
            _prefs.getBool('display_vertical_margin_boxes') ?? false,
        verticalMarginBoxesHeight:
            _prefs.getDouble('vertical_margin_boxes_height') ?? 35.0,
        verticalMarginBoxesFadeEnabled: _prefs.getBool('fade_enabled') ?? false,
        verticalMarginBoxesFadeLength: _prefs.getDouble('fade_length') ?? 50.0,
        countdownDuration: _prefs.getDouble('countdown_duration') ?? 0.0,
        markdownEnabled: _prefs.getBool('markdown_enabled') ?? false,
        showControlButtons: _prefs.getBool('show_control_buttons') ?? false,
        controlButtonsPosition: const ControlButtonsPositionConverter()
            .fromJson(_prefs.getString('control_buttons_position') ?? ''),
        showCurrentChapter: _prefs.getBool('show_current_chapter') ?? false,
      ),
      themeMode: const ThemeModeConverter().fromJson(
        _prefs.getString('theme_mode') ?? '',
      ),
      appPrimaryColor: Color(
        _prefs.getInt('app_primary_color') ?? kBrandTeal.toARGB32(),
      ),
      prompterBackgroundColor: Color(
        _prefs.getInt('prompter_background_color') ?? Colors.black.toARGB32(),
      ),
      prompterTextColor: Color(
        _prefs.getInt('prompter_text_color') ?? Colors.white.toARGB32(),
      ),
    );

    await _persist(migrated);
    for (final key in legacyKeys) {
      await _prefs.remove(key);
    }

    return migrated;
  }
}
