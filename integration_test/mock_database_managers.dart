import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/models/app_state.drift.dart';
import 'package:tiefprompt/models/database.dart';
import 'package:tiefprompt/models/keybinding.drift.dart';
import 'package:tiefprompt/models/script_model.drift.dart';
import 'package:tiefprompt/models/settings_preset_model.drift.dart';
import 'package:tiefprompt/providers/database_provider.dart';
import 'package:tiefprompt/providers/settings_provider.dart';

import 'constants.dart';

Future<AppDatabase> createSeededDatabase() async {
  final db = AppDatabase(NativeDatabase.memory());
  final packageInfo = await PackageInfo.fromPlatform();

  await (db.update(db.appStateModel)).write(
    AppStateModelCompanion(
      helpRequestShown: const Value(true),
      lastSeenVersion: Value(packageInfo.version),
    ),
  );

  await db.batch((batch) {
    batch.insertAll(db.scriptModel, [
      ScriptModelCompanion.insert(
        title: "Lumix DC S1 Script",
        scriptText:
            "Welcome to the Lumix DC S1 review.\n"
            "Today we'll cover the key features of this full-frame mirrorless camera, "
            "including its dual native ISO, weather sealing, and impressive video capabilities.",
        createdAt: DateTime(2025, 01, 07, 16, 10),
        ephemeral: Value(true),
      ),
      ScriptModelCompanion.insert(
        title: "Blender Animation Basics",
        scriptText:
            "In this tutorial, we'll explore the fundamentals of animation in Blender.\n"
            "We'll start with keyframes, move on to the graph editor, and finish with "
            "a short walk cycle using the NLA editor.",
        createdAt: DateTime(2024, 11, 22, 14, 30),
      ),
      ScriptModelCompanion.insert(
        title: "Minecraft Render Workflow",
        scriptText:
            "Let me walk you through my Minecraft cinematic render workflow.\n"
            "I use Chunker to export the world, import it into Blender with the Mineways plugin, "
            "and then set up HDRI lighting for a realistic look.",
        createdAt: DateTime(2024, 09, 15, 9, 15),
      ),
      ScriptModelCompanion.insert(
        title: "Teleprompter App UX Notes",
        scriptText:
            "These are my notes on improving the teleprompter app UX.\n"
            "Key areas: smoother scroll speed adjustment, better font size preview, "
            "and a quick-access panel for the most used settings.",
        createdAt: DateTime(2024, 06, 30, 19, 45),
      ),
      ScriptModelCompanion.insert(
        title: "Lighting Setup Guide",
        scriptText:
            "This guide covers my standard three-point lighting setup for talking-head videos.\n"
            "Key light on the left, fill light on the right at half intensity, "
            "and a rim light behind to separate me from the background.",
        createdAt: DateTime(2024, 03, 05, 7, 50),
      ),
      ScriptModelCompanion.insert(
        title: kMarketingScriptName,
        scriptText: kMarketingScriptContent,
        createdAt: DateTime(2026, 07, 12, 14, 20),
      ),
    ]);
  });

  await db
      .into(db.keybindingMapModel)
      .insert(KeybindingMapModelCompanion.insert(id: const Value(0)));

  await db.batch((batch) {
    batch.insertAll(
      db.keybindingMappingModel,
      kDefaultKeybindings.keybindings
          .map(
            (binding) => KeybindingMappingModelCompanion.insert(
              mapId: 0,
              actionName: binding.$1.name,
              keyId: binding.$2.keyId,
              ctrl: binding.$2.ctrl,
              shift: binding.$2.shift,
              alt: binding.$2.alt,
              meta: binding.$2.meta,
            ),
          )
          .toList(),
    );
  });

  await db.batch((batch) {
    batch.insertAll(db.settingsPresetModel, [
      SettingsPresetModelCompanion.insert(
        name: "Interview Setup",
        createdAt: DateTime(2025, 02, 18, 10, 5),
        data: jsonEncode(SettingsState().toJson()),
        keybindings: 0,
      ),
      SettingsPresetModelCompanion.insert(
        name: "Fast Scroll",
        createdAt: DateTime(2025, 01, 30, 21, 40),
        data: jsonEncode(SettingsState().toJson()),
        keybindings: 0,
      ),
      SettingsPresetModelCompanion.insert(
        name: "Conference Talk",
        createdAt: DateTime(2024, 12, 11, 8, 20),
        data: jsonEncode(SettingsState().toJson()),
        keybindings: 0,
      ),
      SettingsPresetModelCompanion.insert(
        name: "Johannes Camera",
        createdAt: DateTime(2024, 10, 27, 17, 15),
        data: jsonEncode(SettingsState().toJson()),
        keybindings: 0,
      ),
      SettingsPresetModelCompanion.insert(
        name: "Johannes Lecture",
        createdAt: DateTime(2024, 9, 5, 14, 0),
        data: jsonEncode(SettingsState().toJson()),
        keybindings: 0,
      ),
      SettingsPresetModelCompanion.insert(
        name: "Peter",
        createdAt: DateTime(2024, 8, 14, 13, 50),
        data: jsonEncode(SettingsState().toJson()),
        keybindings: 0,
      ),
      SettingsPresetModelCompanion.insert(
        name: "Lena",
        createdAt: DateTime(2024, 5, 2, 19, 5),
        data: jsonEncode(SettingsState().toJson()),
        keybindings: 0,
      ),
      SettingsPresetModelCompanion.insert(
        name: "Nachtmodus",
        createdAt: DateTime(2024, 2, 19, 22, 30),
        data: jsonEncode(SettingsState(themeMode: ThemeMode.dark).toJson()),
        keybindings: 0,
      ),
    ]);
  });

  return db;
}

class MockAppDatabaseManager extends AppDatabaseManager {
  final AppDatabase _db;

  MockAppDatabaseManager(this._db);

  @override
  AppDatabase build() {
    return _db;
  }
}
