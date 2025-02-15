import 'package:tiefprompt/providers/script_provider.dart';
import 'package:tiefprompt/services/database_service.dart';

class ScriptService {
  Future<ScriptState> loadScript() async {
    await DatabaseService.init();

    final scriptText = "";

    return ScriptState(
      text: scriptText,
    );
  }
}
