import 'package:tiefprompt/models/database.dart';
import 'package:tiefprompt/providers/script_provider.dart';

abstract class IScriptService {
  Future<int> getScriptCount();
  Future<Stream<List<ScriptDisplayData>>> getScripts();
  Future<String> loadScript(int scriptId);
  Future<void> save(ScriptState script);
  Future<void> deleteScript(int scriptId);
}

class ScriptDisplayData {
  final String title;
  final DateTime createdAt;
  final int id;

  ScriptDisplayData({
    required this.id,
    required this.title,
    required this.createdAt,
  });
}

class ScriptService implements IScriptService {
  final _databaseManagers = AppDatabase().managers;

  @override
  Future<int> getScriptCount() async =>
      await _databaseManagers.scriptModel.count();

  @override
  Future<Stream<List<ScriptDisplayData>>> getScripts() async =>
      _databaseManagers.scriptModel.asyncMap(_mapToDisplay).watch();

  Future<ScriptDisplayData> _mapToDisplay(ScriptModelData script) async =>
      ScriptDisplayData(
        id: script.id,
        title: script.title,
        createdAt: script.createdAt,
      );

  @override
  Future<String> loadScript(int scriptId) async =>
      await _databaseManagers.scriptModel
          .filter((s) => s.id(scriptId))
          .asyncMap(_mapToText)
          .getSingle();

  Future<String> _mapToText(ScriptModelData script) async => script.scriptText;

  @override
  Future<void> save(ScriptState script) async =>
      await _databaseManagers.scriptModel.create((s) => s(
          scriptText: script.text,
          title: script.title,
          createdAt: DateTime.now()));

  @override
  Future<void> deleteScript(int scriptId) async =>
      await _databaseManagers.scriptModel
          .filter((s) => s.id(scriptId))
          .delete();
}
