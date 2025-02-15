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

  Future<List<ScriptDisplayData>> getScripts() async {
    return await databaseManagers.scriptModel.asyncMap(map).get();
  }

  Future<ScriptDisplayData> map(ScriptModelData script) async {
    return ScriptDisplayData(
      title: script.title,
      createdAt: script.createdAt ?? DateTime.now(),
    );
  }

  Future<ScriptState> loadScript(int scriptId) async {
    final script = await databaseManagers.scriptModel
        .filter((s) => s.id(scriptId))
        .getSingle();

    return ScriptState(
      text: script.scriptText,
    );
  }
}
