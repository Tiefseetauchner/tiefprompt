import 'package:easy_localization/easy_localization.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'script_provider.freezed.dart';
part 'script_provider.g.dart';

@freezed
class ScriptState with _$ScriptState {
  factory ScriptState({
    required String text,
    required String title,
  }) = _ScriptState;
}

@riverpod
class Script extends _$Script {
  @override
  ScriptState build() => ScriptState(text: "", title: "empty_title".tr());

  void setText(String text) {
    state = state.copyWith(text: text);
  }

  void setTitle(String title) {
    state = state.copyWith(title: title);
  }
}
