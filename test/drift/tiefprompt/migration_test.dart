// dart format width=80
// ignore_for_file: unused_local_variable, unused_import
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:drift_dev/api/migrations_native.dart';
import 'package:flutter/material.dart';
import 'package:tiefprompt/core/control_buttons.dart';
import 'package:tiefprompt/models/database.dart';
import 'package:tiefprompt/providers/prompter_config.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'generated/schema.dart';

import 'generated/schema_v2.dart' as v2;
import 'generated/schema_v3.dart' as v3;
import 'generated/schema_v4.dart' as v4;
import 'generated/schema_v5.dart' as v5;
import 'generated/schema_v6.dart' as v6;

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late SchemaVerifier verifier;

  setUpAll(() {
    verifier = SchemaVerifier(GeneratedHelper());
  });

  group('schema migrations (v5+, after the datetime storage flip)', () {
    final versions = GeneratedHelper.versions.where((v) => v >= 5).toList();
    for (final (i, fromVersion) in versions.indexed) {
      group('from $fromVersion', () {
        for (final toVersion in versions.skip(i + 1)) {
          test('to $toVersion', () async {
            final schema = await verifier.schemaAt(fromVersion);
            final db = AppDatabase(schema.newConnection());
            await verifier.migrateAndValidate(db, toVersion);
            await db.close();
          });
        }
      });
    }
  });

  test('v2 -> v6 seeds the app state row', () async {
    await verifier.testWithDataIntegrity(
      oldVersion: 2,
      newVersion: 6,
      createOld: v2.DatabaseAtV2.new,
      createNew: v6.DatabaseAtV6.new,
      openTestedDatabase: AppDatabase.new,
      createItems: (batch, oldDb) {},
      validateItems: (newDb) async {
        final appState = await newDb.select(newDb.appStateModel).get();
        expect(appState, hasLength(1));
        expect(appState.single.helpRequestShown, 0);
      },
    );
  });

  test('v3 -> v6 preserves scripts and defaults the new columns', () async {
    await verifier.testWithDataIntegrity(
      oldVersion: 3,
      newVersion: 6,
      createOld: v3.DatabaseAtV3.new,
      createNew: v6.DatabaseAtV6.new,
      openTestedDatabase: AppDatabase.new,
      createItems: (batch, oldDb) {
        batch.insert(
          oldDb.scriptModel,
          v3.ScriptModelCompanion.insert(
            title: 'Seeded Script',
            scriptText: 'hello',
            createdAt: DateTime(2024, 1, 2),
          ),
        );
      },
      validateItems: (newDb) async {
        final scripts = await newDb.select(newDb.scriptModel).get();
        final seeded = scripts.firstWhere((s) => s.title == 'Seeded Script');
        expect(seeded.scriptText, 'hello');
        expect(seeded.ephemeral, 0);
        expect(seeded.scrollPosition, null);
      },
    );
  });

  test('v4 -> v6 backfills the control-button columns into the json', () async {
    await verifier.testWithDataIntegrity(
      oldVersion: 4,
      newVersion: 6,
      createOld: v4.DatabaseAtV4.new,
      createNew: v6.DatabaseAtV6.new,
      openTestedDatabase: AppDatabase.new,
      createItems: (batch, oldDb) {
        batch.insert(
          oldDb.keybindingMapModel,
          const v4.KeybindingMapModelCompanion(id: Value(1)),
        );
        batch.insert(
          oldDb.settingsPresetModel,
          v4.SettingsPresetModelCompanion(
            name: const Value('Old Preset'),
            createdAt: Value(DateTime(2024, 1, 2)),
            scrollSpeed: const Value(1.5),
            mirroredX: const Value(false),
            mirroredY: const Value(false),
            fontSize: const Value(40.0),
            sideMargin: const Value(0.0),
            fontFamily: const Value('Roboto'),
            alignment: const Value('left'),
            displayReadingIndicatorBoxes: const Value(false),
            readingIndicatorBoxesHeight: const Value(60.0),
            displayVerticalMarginBoxes: const Value(false),
            verticalMarginBoxesHeight: const Value(35.0),
            verticalMarginBoxesFadeEnabled: const Value(false),
            verticalMarginBoxesFadeLength: const Value(50.0),
            countdownDuration: const Value(0.0),
            themeMode: const Value('system'),
            appPrimaryColor: const Value(0xFF1FB6B6),
            prompterBackgroundColor: const Value(0xFF000000),
            prompterTextColor: const Value(0xFFFFFFFF),
            markdownEnabled: const Value(true),
            keybindings: const Value(1),
          ),
        );
      },
      validateItems: (newDb) async {
        final rows = await newDb.select(newDb.settingsPresetModel).get();
        expect(rows, hasLength(1));
        final settings = SettingsState.fromJson(jsonDecode(rows.single.data));
        expect(settings.config.markdownEnabled, isTrue);
        expect(settings.config.showControlButtons, isFalse);
        expect(
          settings.config.controlButtonsPosition,
          ControlButtonsPosition.left,
        );
      },
    );
  });

  test('v5 -> v6 packs every preset column into the json blob', () async {
    await verifier.testWithDataIntegrity(
      oldVersion: 5,
      newVersion: 6,
      createOld: v5.DatabaseAtV5.new,
      createNew: v6.DatabaseAtV6.new,
      openTestedDatabase: AppDatabase.new,
      createItems: (batch, oldDb) {
        batch.insert(
          oldDb.keybindingMapModel,
          const v5.KeybindingMapModelCompanion(id: Value(7)),
        );
        batch.insert(
          oldDb.settingsPresetModel,
          v5.SettingsPresetModelCompanion(
            name: const Value('Full Preset'),
            createdAt: const Value('2024-01-02T03:04:05.000'),
            scrollSpeed: const Value(2.5),
            mirroredX: const Value(1),
            mirroredY: const Value(0),
            fontSize: const Value(50.0),
            sideMargin: const Value(10.0),
            fontFamily: const Value('RobotoMono'),
            alignment: const Value('center'),
            displayReadingIndicatorBoxes: const Value(1),
            readingIndicatorBoxesHeight: const Value(70.0),
            displayVerticalMarginBoxes: const Value(0),
            verticalMarginBoxesHeight: const Value(30.0),
            verticalMarginBoxesFadeEnabled: const Value(1),
            verticalMarginBoxesFadeLength: const Value(40.0),
            countdownDuration: const Value(3.0),
            themeMode: const Value('dark'),
            appPrimaryColor: const Value(0xFF112233),
            prompterBackgroundColor: const Value(0xFF010203),
            prompterTextColor: const Value(0xFF0A0B0C),
            markdownEnabled: const Value(1),
            showControlButtons: const Value(1),
            controlButtonsPosition: const Value('right'),
            keybindings: const Value(7),
          ),
        );
      },
      validateItems: (newDb) async {
        final rows = await newDb.select(newDb.settingsPresetModel).get();
        expect(rows, hasLength(1));
        final row = rows.single;
        expect(row.keybindings, 7);

        final settings = SettingsState.fromJson(jsonDecode(row.data));
        expect(settings.config.scrollSpeed, 2.5);
        expect(settings.config.mirroredX, isTrue);
        expect(settings.config.mirroredY, isFalse);
        expect(settings.config.fontSize, 50.0);
        expect(settings.config.sideMargin, 10.0);
        expect(settings.config.fontFamily, 'RobotoMono');
        expect(settings.config.alignment, TextAlign.center);
        expect(settings.config.displayReadingIndicatorBoxes, isTrue);
        expect(settings.config.readingIndicatorBoxesHeight, 70.0);
        expect(settings.config.displayVerticalMarginBoxes, isFalse);
        expect(settings.config.verticalMarginBoxesHeight, 30.0);
        expect(settings.config.verticalMarginBoxesFadeEnabled, isTrue);
        expect(settings.config.verticalMarginBoxesFadeLength, 40.0);
        expect(settings.config.countdownDuration, 3.0);
        expect(settings.config.markdownEnabled, isTrue);
        expect(settings.config.showControlButtons, isTrue);
        expect(
          settings.config.controlButtonsPosition,
          ControlButtonsPosition.right,
        );
        expect(settings.config.showCurrentChapter, isFalse);
        expect(settings.themeMode, ThemeMode.dark);
        expect(settings.appPrimaryColor, const Color(0xFF112233));
        expect(settings.prompterBackgroundColor, const Color(0xFF010203));
        expect(settings.prompterTextColor, const Color(0xFF0A0B0C));
      },
    );
  });
}
