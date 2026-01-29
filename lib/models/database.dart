import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tiefprompt/models/keybinding.dart';
import 'package:tiefprompt/models/script_model.dart';
import 'package:tiefprompt/models/settings_preset_model.dart';
import "database.steps.dart";

part 'database.g.dart';

@DriftDatabase(
  tables: [
    ScriptModel,
    SettingsPresetModel,
    KeybindingMapModel,
    KeybindingMappingModel,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());

  @override
  int get schemaVersion => 2;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'tiefprompt',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onUpgrade: stepByStep(
        from1To2: (m, schema) async {
          await m.createTable(schema.settingsPresetModel);
          await m.createTable(schema.keybindingMapModel);
          await m.createTable(schema.keybindingMappingModel);
        },
      ),
    );
  }
}
