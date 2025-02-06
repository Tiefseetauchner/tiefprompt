import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'script_provider.freezed.dart';
part 'script_provider.g.dart';

@freezed
class ScriptState with _$ScriptState {
  factory ScriptState({
    required String text,
  }) = _ScriptState;
}

@riverpod
class Script extends _$Script {
  @override
  ScriptState build() => ScriptState(text: "");

  void setText(String text) {
    state = state.copyWith(text: text);
  }
}
