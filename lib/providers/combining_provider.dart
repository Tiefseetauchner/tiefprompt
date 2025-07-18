import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'combining_provider.freezed.dart';
part 'combining_provider.g.dart';

@freezed
abstract class CombinedState with _$CombinedState {
  factory CombinedState(List<Object> states) = _CombinedState;
}

@riverpod
class CombinedAsyncData extends _$CombinedAsyncData {
  @override
  AsyncValue<CombinedState> build(List<AsyncValue<Object>> states) {
    if (states.any((state) => state.isLoading)) return AsyncValue.loading();

    if (states.any((state) => state.hasError)) {
      return AsyncValue.error(
        states.firstWhere((state) => state.hasError).error!,
        StackTrace.current,
      );
    }

    if (states.any((state) => !state.hasValue)) {
      return AsyncValue.error(
        "An unknown and unknowable error may have just occurred, confusing me greatly.",
        StackTrace.current,
      );
    }

    return AsyncData(
      CombinedState(states.map((state) => state.requireValue).toList()),
    );
  }
}
