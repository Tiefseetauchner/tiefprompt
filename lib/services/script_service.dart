import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tiefprompt/models/database.dart';
import 'package:tiefprompt/providers/database_provider.dart';
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

@Riverpod(dependencies: [DatabaseManagers])
class ScriptService extends _$ScriptService {
  late final _databaseManagers = ref.read(databaseManagersProvider);

  @override
  Future<void> build() async {}

  Future<int> getScriptCount() async =>
      await _databaseManagers.scriptModel.count();

  Future<Stream<List<ScriptDisplayData>>> getScripts() async =>
      _databaseManagers.scriptModel
          .filter((f) => f.ephemeral.equals(false))
          .asyncMap(_mapToDisplay)
          .watch();

  Future<ScriptDisplayData> _mapToDisplay(ScriptModelData script) async =>
      ScriptDisplayData(
        id: script.id,
        title: script.title,
        createdAt: script.createdAt,
      );

  Future<ScriptModelData> loadScript(int scriptId) async =>
      await _databaseManagers.scriptModel
          .filter((s) => s.id(scriptId))
          .getSingle();

  Future<int> save(ScriptState script) async {
    if (script.ephemeral || script.id == null) {
      return await _databaseManagers.scriptModel.create(
        (s) => s(
          scriptText: script.text,
          title: script.title ?? "Untitled",
          ephemeral: Value(false),
          scrollPosition: Value(script.scrollPosition),
          createdAt: DateTime.now(),
        ),
      );
    } else {
      return await _databaseManagers.scriptModel
          .filter((f) => f.id.equals(script.id))
          .update(
            (s) => s(
              scriptText: Value(script.text),
              title: Value(script.title ?? "Untitled"),
              scrollPosition: Value(script.scrollPosition),
            ),
          );
    }
  }

  Future<int> saveEphemeral(ScriptState script) async {
    return await _databaseManagers.scriptModel
        .filter((f) => f.id.equals(script.id))
        .update(
          (s) => s(
            scriptText: Value(script.text),
            title: Value(script.title ?? "Untitled"),
            scrollPosition: Value(script.scrollPosition),
          ),
        );
  }

  Future<void> createEphemeral() async {
    await _databaseManagers.scriptModel.create(
      (s) => s(
        scriptText: "",
        title: "Untitled",
        ephemeral: Value(true),
        createdAt: DateTime.now(),
      ),
    );
  }

  Future<void> deleteScript(int scriptId) async => await _databaseManagers
      .scriptModel
      .filter((s) => s.id(scriptId))
      .delete();
}
