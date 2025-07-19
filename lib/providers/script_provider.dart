import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'script_provider.freezed.dart';
part 'script_provider.g.dart';

@freezed
abstract class ScriptState with _$ScriptState {
  factory ScriptState({required String text, required String? title}) =
      _ScriptState;
}

@riverpod
class Script extends _$Script {
  @override
  ScriptState build() => ScriptState(text: "", title: null);

  void setText(String text) {
    state = state.copyWith(text: text);
  }

  void setTitle(String title) {
    state = state.copyWith(title: title);
  }
}
