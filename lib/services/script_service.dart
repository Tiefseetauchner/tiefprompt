import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tiefprompt/models/database.dart';
import 'package:tiefprompt/providers/script_provider.dart';

part 'script_service.g.dart';

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

@riverpod
class ScriptService extends _$ScriptService {
  final _databaseManagers = AppDatabase().managers;

  @override
  Future<void> build() async {}

  Future<int> getScriptCount() async =>
      await _databaseManagers.scriptModel.count();

  Future<Stream<List<ScriptDisplayData>>> getScripts() async =>
      _databaseManagers.scriptModel.asyncMap(_mapToDisplay).watch();

  Future<ScriptDisplayData> _mapToDisplay(ScriptModelData script) async =>
      ScriptDisplayData(
        id: script.id,
        title: script.title,
        createdAt: script.createdAt,
      );

  Future<String> loadScript(int scriptId) async => await _databaseManagers
      .scriptModel
      .filter((s) => s.id(scriptId))
      .asyncMap(_mapToText)
      .getSingle();

  Future<String> _mapToText(ScriptModelData script) async => script.scriptText;

  Future<void> save(ScriptState script) async =>
      await _databaseManagers.scriptModel.create(
        (s) => s(
          scriptText: script.text,
          title: script.title ?? "Untitled",
          createdAt: DateTime.now(),
        ),
      );

  Future<void> deleteScript(int scriptId) async => await _databaseManagers
      .scriptModel
      .filter((s) => s.id(scriptId))
      .delete();
}
