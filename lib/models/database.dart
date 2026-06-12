import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tiefprompt/models/keybinding.dart';
import 'package:tiefprompt/models/app_state.dart';
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
    AppStateModel,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());

  @override
  int get schemaVersion => 4;

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
      onCreate: (m) async {
        await m.createAll();
        await into(
          appStateModel,
        ).insert(AppStateModelCompanion.insert(helpRequestShown: false));
        await into(scriptModel).insert(
          ScriptModelCompanion.insert(
            title: "Unnamed Script",
            scriptText: "",
            createdAt: DateTime.now(),
            ephemeral: Value(true),
          ),
        );
      },
      onUpgrade: stepByStep(
        from1To2: (m, schema) async {
          await m.createTable(schema.settingsPresetModel);
          await m.createTable(schema.keybindingMapModel);
          await m.createTable(schema.keybindingMappingModel);
        },
        from2To3: (m, schema) async {
          await m.createTable(schema.appStateModel);
          await m.database.customInsert(
            'INSERT INTO help_request_model (help_request_shown) VALUES (?)',
            variables: [Variable.withBool(false)],
          );
        },
        from3To4: (m, schema) async {
          await m.addColumn(schema.scriptModel, schema.scriptModel.ephemeral);
          await m.addColumn(
            schema.scriptModel,
            schema.scriptModel.scrollPosition,
          );

          await into(scriptModel).insert(
            ScriptModelCompanion.insert(
              title: "Unnamed Script",
              scriptText: "",
              createdAt: DateTime.now(),
              ephemeral: Value(true),
            ),
          );
        },
      ),
    );
  }
}
