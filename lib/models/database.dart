import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/core/json_converters.dart';
import 'package:tiefprompt/models/keybinding.dart';
import 'package:tiefprompt/models/app_state.dart';
import 'package:tiefprompt/models/script_model.dart';
import 'package:tiefprompt/models/settings_preset_model.dart';
import 'package:tiefprompt/providers/prompter_config.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import "database.steps.dart";
import 'database.drift.dart';
import 'app_state.drift.dart';
import 'script_model.drift.dart';

@DriftDatabase(
  tables: [
    ScriptModel,
    SettingsPresetModel,
    KeybindingMapModel,
    KeybindingMappingModel,
    AppStateModel,
  ],
)
class AppDatabase extends $AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());

  @override
  int get schemaVersion => 6;

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
            title: kNewScriptName,
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
          await m.database.into(schema.appStateModel).insert(
            RawValuesInsertable({
              schema.appStateModel.helpRequestShown.name: Variable(false),
            }),
          );
        },
        from3To4: (m, schema) async {
          await m.addColumn(schema.scriptModel, schema.scriptModel.ephemeral);
          await m.addColumn(
            schema.scriptModel,
            schema.scriptModel.scrollPosition,
          );

          await m.database
              .into(schema.scriptModel)
              .insert(
                RawValuesInsertable({
                  schema.scriptModel.title.name: Variable(kNewScriptName),
                  schema.scriptModel.scriptText.name: Variable(''),
                  schema.scriptModel.createdAt.name: Variable(DateTime.now()),
                  schema.scriptModel.ephemeral.name: Variable(true),
                }),
              );
        },
        from4To5: (m, schema) async {
          await _flipCreatedAtToText(m, 'settings_preset_model');

          await m.alterTable(
            TableMigration(
              schema.settingsPresetModel,
              newColumns: [
                schema.settingsPresetModel.showControlButtons,
                schema.settingsPresetModel.controlButtonsPosition,
              ],
              columnTransformer: {
                schema.settingsPresetModel.showControlButtons: const Constant(
                  false,
                ),
                schema.settingsPresetModel.controlButtonsPosition:
                    const Constant('left'),
              },
            ),
          );
        },
        from5To6: (m, schema) async {
          for (final table in const ['script_model', 'settings_preset_model']) {
            await _flipCreatedAtToText(m, table);
          }

          await m.alterTable(TableMigration(schema.scriptModel));

          final oldRows = await m.database
              .customSelect('SELECT * FROM settings_preset_model')
              .get();

          final backfill = <(int, String)>[];
          for (final row in oldRows) {
            final settings = SettingsState(
              themeMode: const ThemeModeConverter().fromJson(
                row.read<String>('theme_mode'),
              ),
              appPrimaryColor: const ColorConverter().fromJson(
                row.read<int>('app_primary_color'),
              ),
              prompterBackgroundColor: const ColorConverter().fromJson(
                row.read<int>('prompter_background_color'),
              ),
              prompterTextColor: const ColorConverter().fromJson(
                row.read<int>('prompter_text_color'),
              ),
              config: PrompterConfiguration(
                scrollSpeed: row.read<double>('scroll_speed'),
                mirroredX: row.read<bool>('mirrored_x'),
                mirroredY: row.read<bool>('mirrored_y'),
                fontSize: row.read<double>('font_size'),
                sideMargin: row.read<double>('side_margin'),
                fontFamily: row.read<String>('font_family'),
                alignment: const TextAlignConverter().fromJson(
                  row.read<String>('alignment'),
                ),
                displayReadingIndicatorBoxes: row.read<bool>(
                  'display_reading_indicator_boxes',
                ),
                readingIndicatorBoxesHeight: row.read<double>(
                  'reading_indicator_boxes_height',
                ),
                displayVerticalMarginBoxes: row.read<bool>(
                  'display_vertical_margin_boxes',
                ),
                verticalMarginBoxesHeight: row.read<double>(
                  'vertical_margin_boxes_height',
                ),
                verticalMarginBoxesFadeEnabled: row.read<bool>(
                  'vertical_margin_boxes_fade_enabled',
                ),
                verticalMarginBoxesFadeLength: row.read<double>(
                  'vertical_margin_boxes_fade_length',
                ),
                countdownDuration: row.read<double>('countdown_duration'),
                markdownEnabled: row.read<bool>('markdown_enabled'),
                showControlButtons: row.read<bool>('show_control_buttons'),
                controlButtonsPosition: const ControlButtonsPositionConverter()
                    .fromJson(row.read<String>('control_buttons_position')),
              ),
            );

            backfill.add((
              row.read<int>('id'),
              jsonEncode(settings.toJson()),
            ));
          }

          await m.alterTable(
            TableMigration(
              schema.settingsPresetModel,
              newColumns: [schema.settingsPresetModel.data],
              columnTransformer: {
                schema.settingsPresetModel.data: const Constant<String>('{}'),
              },
            ),
          );

          for (final (id, data) in backfill) {
            await (m.database.update(schema.settingsPresetModel)
                  ..where((_) => schema.settingsPresetModel.id.equals(id)))
                .write(
                  RawValuesInsertable({
                    schema.settingsPresetModel.data.name: Variable(data),
                  }),
                );
          }
        },
      ),
    );
  }
}

Future<void> _flipCreatedAtToText(Migrator m, String table) async {
  await m.database.customStatement(
    "UPDATE $table SET created_at = "
    "strftime('%Y-%m-%dT%H:%M:%S.000Z', created_at, 'unixepoch') "
    "WHERE typeof(created_at) = 'integer'",
  );
}
