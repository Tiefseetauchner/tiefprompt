import 'package:tiefprompt/models/database.dart';
import 'package:tiefprompt/providers/script_provider.dart';

class ScriptDisplayData {
  final String title;
  final DateTime createdAt;

  ScriptDisplayData({
    required this.title,
    required this.createdAt,
  });
}

class ScriptService {
  final databaseManagers = AppDatabase().managers;

  Future<List<ScriptDisplayData>> getScripts() async =>
      await databaseManagers.scriptModel.asyncMap(mapToDisplay).get();

  Future<ScriptDisplayData> mapToDisplay(ScriptModelData script) async =>
      ScriptDisplayData(
        title: script.title,
        createdAt: script.createdAt ?? DateTime.now(),
      );

  Future<ScriptState> loadScript(int scriptId) async =>
      await databaseManagers.scriptModel
          .filter((s) => s.id(scriptId))
          .asyncMap(mapToState)
          .getSingle();

  Future<ScriptState> mapToState(ScriptModelData script) async =>
      ScriptState(text: script.scriptText);
}
