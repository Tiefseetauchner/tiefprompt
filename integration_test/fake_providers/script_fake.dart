import 'package:tiefprompt/providers/script_provider.dart';

class ScriptFake extends Script {
  final String name;
  final String content;
  final double? scrollPosition;

  ScriptFake({required this.name, required this.content, this.scrollPosition});

  @override
  ScriptState build() => ScriptState(
    id: null,
    text: content,
    title: name,
    isSaved: true,
    scrollPosition: scrollPosition,
    ephemeral: false,
  );
}
