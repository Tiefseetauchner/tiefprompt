import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tiefprompt/models/settings_preset_model.drift.dart';
import 'package:tiefprompt/providers/database_provider.dart';
import 'package:tiefprompt/providers/keybinding_provider.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/providers/talker_provider.dart';

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

@Riverpod(dependencies: [Settings, Keybindings])
class SettingsStorageService extends _$SettingsStorageService {
  late final _databaseManagers = ref.read(databaseManagersProvider);

  @override
  Future<void> build() async {}

  Future<int> getSettingsCount() async =>
      await _databaseManagers.settingsPresetModel.count();

  Stream<List<SettingsDisplayData>> getSettingDisplayData() =>
      _databaseManagers.settingsPresetModel.asyncMap(_mapToDisplay).watch();

  SettingsDisplayData _mapToDisplay(SettingsPresetModelData settings) =>
      SettingsDisplayData(
        id: settings.id,
        title: settings.name,
        createdAt: settings.createdAt,
      );

  Future<void> loadSettings(int settingsId) async {
    ref.read(talkerProvider).info('Settings preset loading: id=$settingsId');
    final settings = await getSettings(settingsId);
    await ref.read(settingsProvider.notifier).loadSettings(settings);
    await ref
        .read(keybindingsProvider.notifier)
        .copyBindingsToCurrent(settings.keybindingsMapId);
    ref.read(talkerProvider).info('Settings preset loaded: id=$settingsId');
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
    return SettingsState.fromJson(
      jsonDecode(settings.data),
    ).copyWith(keybindingsMapId: settings.keybindings);
  }

  Future<void> save(
    String name,
    SettingsState settings,
    int keybindingMapId,
  ) async {
    ref.read(talkerProvider).info('Settings preset saved: "$name"');
    await _databaseManagers.settingsPresetModel.create(
      (s) => s(
        name: name,
        createdAt: DateTime.now(),
        data: jsonEncode(settings.toJson()),
        keybindings: keybindingMapId,
      ),
    );
  }

  Future<void> deleteSettings(int settingsId) async {
    ref.read(talkerProvider).info('Settings preset deleted: id=$settingsId');
    await _databaseManagers.settingsPresetModel
        .filter((s) => s.id(settingsId))
        .delete();
  }
}
