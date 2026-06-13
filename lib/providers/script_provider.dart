import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tiefprompt/models/database.dart';

part 'script_provider.freezed.dart';
part 'script_provider.g.dart';

@freezed
abstract class ScriptState with _$ScriptState {
  factory ScriptState({
    required int? id,
    required String text,
    required String? title,
    required bool isSaved,
    required double? scrollPosition,
    required bool ephemeral,
  }) = _ScriptState;
}

@riverpod
class Script extends _$Script {
  @override
  ScriptState build() => ScriptState(
    id: null,
    text: "",
    title: null,
    isSaved: true,
    scrollPosition: null,
    ephemeral: false,
  );

  void setId(int id) => state = state.copyWith(id: id);

  void setText(String text) => state = state.copyWith(text: text);

  void setTitle(String title) => state = state.copyWith(title: title);

  void setIsSaved(bool value) => state = state.copyWith(isSaved: value);

  void setEphemeral(bool ephemeral) =>
      state = state.copyWith(ephemeral: ephemeral);

  void setScrollPosition(double? value) =>
      state = state.copyWith(scrollPosition: value);

  void loadScript(ScriptModelData script) {
    setId(script.id);
    setScrollPosition(script.scrollPosition);
    setText(script.scriptText);
    setTitle(script.title);
    setEphemeral(script.ephemeral);
  }
}
