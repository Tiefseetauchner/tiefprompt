// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'combining_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CombinedAsyncData)
final combinedAsyncDataProvider = CombinedAsyncDataFamily._();

final class CombinedAsyncDataProvider
    extends $NotifierProvider<CombinedAsyncData, AsyncValue<CombinedState>> {
  CombinedAsyncDataProvider._({
    required CombinedAsyncDataFamily super.from,
    required List<AsyncValue<Object>> super.argument,
  }) : super(
         retry: null,
         name: r'combinedAsyncDataProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$combinedAsyncDataHash();

  @override
  String toString() {
    return r'combinedAsyncDataProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CombinedAsyncData create() => CombinedAsyncData();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<CombinedState> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<CombinedState>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CombinedAsyncDataProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$combinedAsyncDataHash() => r'7a5108dde816da771e7af7304118c9aaf4f2d6a9';

final class CombinedAsyncDataFamily extends $Family
    with
        $ClassFamilyOverride<
          CombinedAsyncData,
          AsyncValue<CombinedState>,
          AsyncValue<CombinedState>,
          AsyncValue<CombinedState>,
          List<AsyncValue<Object>>
        > {
  CombinedAsyncDataFamily._()
    : super(
        retry: null,
        name: r'combinedAsyncDataProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CombinedAsyncDataProvider call(List<AsyncValue<Object>> states) =>
      CombinedAsyncDataProvider._(argument: states, from: this);

  @override
  String toString() => r'combinedAsyncDataProvider';
}

abstract class _$CombinedAsyncData
    extends $Notifier<AsyncValue<CombinedState>> {
  late final _$args = ref.$arg as List<AsyncValue<Object>>;
  List<AsyncValue<Object>> get states => _$args;

  AsyncValue<CombinedState> build(List<AsyncValue<Object>> states);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<CombinedState>, AsyncValue<CombinedState>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CombinedState>, AsyncValue<CombinedState>>,
              AsyncValue<CombinedState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
