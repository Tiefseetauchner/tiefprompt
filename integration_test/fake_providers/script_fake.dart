import 'package:tiefprompt/providers/script_provider.dart';

class ScriptFake extends Script {
  final String name;
  final String content;

  ScriptFake(this.name, this.content);

  @override
  ScriptState build() => ScriptState(
    id: null,
    text: content,
    title: name,
    isSaved: true,
    scrollPosition: null,
    ephemeral: false,
  );
}
