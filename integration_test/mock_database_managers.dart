import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tiefprompt/models/database.dart';
import 'package:tiefprompt/providers/database_provider.dart';

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
