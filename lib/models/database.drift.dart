// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:tiefprompt/models/script_model.drift.dart' as i1;
import 'package:tiefprompt/models/keybinding.drift.dart' as i2;
import 'package:tiefprompt/models/settings_preset_model.drift.dart' as i3;
import 'package:tiefprompt/models/app_state.drift.dart' as i4;

abstract class $AppDatabase extends i0.GeneratedDatabase {
  $AppDatabase(i0.QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final i1.$ScriptModelTable scriptModel = i1.$ScriptModelTable(this);
  late final i2.$KeybindingMapModelTable keybindingMapModel = i2
      .$KeybindingMapModelTable(this);
  late final i3.$SettingsPresetModelTable settingsPresetModel = i3
      .$SettingsPresetModelTable(this);
  late final i2.$KeybindingMappingModelTable keybindingMappingModel = i2
      .$KeybindingMappingModelTable(this);
  late final i4.$AppStateModelTable appStateModel = i4.$AppStateModelTable(
    this,
  );
  @override
  Iterable<i0.TableInfo<i0.Table, Object?>> get allTables =>
      allSchemaEntities.whereType<i0.TableInfo<i0.Table, Object?>>();
  @override
  List<i0.DatabaseSchemaEntity> get allSchemaEntities => [
    scriptModel,
    keybindingMapModel,
    settingsPresetModel,
    keybindingMappingModel,
    appStateModel,
  ];
  @override
  i0.StreamQueryUpdateRules get streamUpdateRules =>
      const i0.StreamQueryUpdateRules([
        i0.WritePropagation(
          on: i0.TableUpdateQuery.onTableName(
            'keybinding_map_model',
            limitUpdateKind: i0.UpdateKind.delete,
          ),
          result: [
            i0.TableUpdate('settings_preset_model', kind: i0.UpdateKind.delete),
          ],
        ),
        i0.WritePropagation(
          on: i0.TableUpdateQuery.onTableName(
            'keybinding_map_model',
            limitUpdateKind: i0.UpdateKind.delete,
          ),
          result: [
            i0.TableUpdate(
              'keybinding_mapping_model',
              kind: i0.UpdateKind.delete,
            ),
          ],
        ),
      ]);
  @override
  i0.DriftDatabaseOptions get options =>
      const i0.DriftDatabaseOptions(storeDateTimeAsText: true);
}

class $AppDatabaseManager {
  final $AppDatabase _db;
  $AppDatabaseManager(this._db);
  i1.$$ScriptModelTableTableManager get scriptModel =>
      i1.$$ScriptModelTableTableManager(_db, _db.scriptModel);
  i2.$$KeybindingMapModelTableTableManager get keybindingMapModel =>
      i2.$$KeybindingMapModelTableTableManager(_db, _db.keybindingMapModel);
  i3.$$SettingsPresetModelTableTableManager get settingsPresetModel =>
      i3.$$SettingsPresetModelTableTableManager(_db, _db.settingsPresetModel);
  i2.$$KeybindingMappingModelTableTableManager get keybindingMappingModel =>
      i2.$$KeybindingMappingModelTableTableManager(
        _db,
        _db.keybindingMappingModel,
      );
  i4.$$AppStateModelTableTableManager get appStateModel =>
      i4.$$AppStateModelTableTableManager(_db, _db.appStateModel);
}
