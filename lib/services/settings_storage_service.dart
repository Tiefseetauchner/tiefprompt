import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tiefprompt/models/database.dart';
import 'package:tiefprompt/providers/database_provider.dart';
import 'package:tiefprompt/providers/keybinding_provider.dart';
import 'package:tiefprompt/providers/settings_provider.dart';

part 'settings_storage_service.g.dart';

class SettingsDisplayData {
  final String title;
  final DateTime createdAt;
  final int id;

  SettingsDisplayData({
    required this.id,
    required this.title,
    required this.createdAt,
  });
}

@Riverpod(dependencies: [Settings, Keybindings, DatabaseManagers])
class SettingsStorageService extends _$SettingsStorageService {
  late final _databaseManagers = ref.read(databaseManagersProvider);

  @override
  Future<void> build() async {}

  Future<int> getSettingsCount() async =>
      await _databaseManagers.settingsPresetModel.count();

  Future<Stream<List<SettingsDisplayData>>> getSettingDisplayData() async =>
      _databaseManagers.settingsPresetModel.asyncMap(_mapToDisplay).watch();

  SettingsDisplayData _mapToDisplay(SettingsPresetModelData settings) =>
      SettingsDisplayData(
        id: settings.id,
        title: settings.name,
        createdAt: settings.createdAt,
      );

  Future<void> loadSettings(int settingsId) async {
    final settings = await getSettings(settingsId);
    await ref.read(settingsProvider.notifier).loadSettings(settings);

    // NOTE: Due to potential for future expansion, the map is hardcoded to 0, and overridden on load
    await ref
        .read(keybindingsProvider.notifier)
        .copyBindingsToCurrent(settings.keybindingsMapId);
  }

  Future<SettingsState> getSettings(int settingsId) async =>
      await _databaseManagers.settingsPresetModel
          .filter((s) => s.id(settingsId))
          .asyncMap(_mapToState)
          .getSingle();

  Future<String> getName(int settingsId) async => await _databaseManagers
      .settingsPresetModel
      .filter((s) => s.id(settingsId))
      .asyncMap((s) => s.name)
      .getSingle();

  SettingsState _mapToState(SettingsPresetModelData settings) {
    return SettingsState(
      scrollSpeed: settings.scrollSpeed,
      mirroredX: settings.mirroredX,
      mirroredY: settings.mirroredY,
      fontSize: settings.fontSize,
      sideMargin: settings.sideMargin,
      fontFamily: settings.fontFamily,
      alignment: _getAlignment(settings.alignment),
      displayReadingIndicatorBoxes: settings.displayReadingIndicatorBoxes,
      readingIndicatorBoxesHeight: settings.readingIndicatorBoxesHeight,
      displayVerticalMarginBoxes: settings.displayVerticalMarginBoxes,
      verticalMarginBoxesHeight: settings.verticalMarginBoxesHeight,
      verticalMarginBoxesFadeEnabled: settings.verticalMarginBoxesFadeEnabled,
      verticalMarginBoxesFadeLength: settings.verticalMarginBoxesFadeLength,
      countdownDuration: settings.countdownDuration,
      themeMode: _getThemeMode(settings.themeMode),
      appPrimaryColor: _getColor(settings.appPrimaryColor),
      prompterBackgroundColor: _getColor(settings.prompterBackgroundColor),
      prompterTextColor: _getColor(settings.prompterTextColor),
      markdownEnabled: settings.markdownEnabled,
      keybindingsMapId: settings.keybindings,
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

  Color _getColor(int color) => Color(color);

  Future<void> save(
    String name,
    SettingsState settings,
    int keybindingMapId,
  ) async {
    await _databaseManagers.settingsPresetModel.create(
      (s) => s(
        name: name,
        scrollSpeed: settings.scrollSpeed,
        mirroredX: settings.mirroredX,
        mirroredY: settings.mirroredY,
        fontSize: settings.fontSize,
        sideMargin: settings.sideMargin,
        fontFamily: settings.fontFamily,
        alignment: settings.alignment.name,
        displayReadingIndicatorBoxes: settings.displayReadingIndicatorBoxes,
        readingIndicatorBoxesHeight: settings.readingIndicatorBoxesHeight,
        displayVerticalMarginBoxes: settings.displayVerticalMarginBoxes,
        verticalMarginBoxesHeight: settings.verticalMarginBoxesHeight,
        verticalMarginBoxesFadeEnabled: settings.verticalMarginBoxesFadeEnabled,
        verticalMarginBoxesFadeLength: settings.verticalMarginBoxesFadeLength,
        countdownDuration: settings.countdownDuration,
        themeMode: settings.themeMode.name,
        appPrimaryColor: settings.appPrimaryColor.toARGB32(),
        prompterBackgroundColor: settings.prompterBackgroundColor.toARGB32(),
        prompterTextColor: settings.prompterTextColor.toARGB32(),
        markdownEnabled: settings.markdownEnabled,
        createdAt: DateTime.now(),
        keybindings: keybindingMapId,
      ),
    );
  }

  Future<void> deleteSettings(int settingsId) async => await _databaseManagers
      .settingsPresetModel
      .filter((s) => s.id(settingsId))
      .delete();
}
