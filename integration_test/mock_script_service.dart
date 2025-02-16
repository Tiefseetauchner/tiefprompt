import 'package:tiefprompt/providers/script_provider.dart';
import 'package:tiefprompt/services/script_service.dart';

class MockScriptService implements IScriptService {
  const MockScriptService();

  @override
  Future<void> deleteScript(int scriptId) {
    throw UnimplementedError();
  }

  @override
  Future<int> getScriptCount() {
    return Future.value(5);
  }

  @override
  Future<Stream<List<ScriptDisplayData>>> getScripts() {
    return Future.value(Stream<List<ScriptDisplayData>>.value([
      ScriptDisplayData(
          id: 0,
          title: "Lumix DC S1 Script",
          createdAt: DateTime(2025, 01, 07, 16, 10)), // 16:10
      ScriptDisplayData(
          id: 1,
          title: "Blender Animation Basics",
          createdAt: DateTime(2024, 11, 22, 14, 30)), // 14:30
      ScriptDisplayData(
          id: 2,
          title: "Minecraft Render Workflow",
          createdAt: DateTime(2024, 09, 15, 9, 15)), // 09:15
      ScriptDisplayData(
          id: 3,
          title: "Teleprompter App UX Notes",
          createdAt: DateTime(2024, 06, 30, 19, 45)), // 19:45
      ScriptDisplayData(
          id: 4,
          title: "Lighting Setup Guide",
          createdAt: DateTime(2024, 03, 05, 7, 50)), // 07:50
    ]));
  }

  @override
  Future<String> loadScript(int scriptId) {
    throw UnimplementedError();
  }

  @override
  Future<void> save(ScriptState script) {
    throw UnimplementedError();
  }
}
