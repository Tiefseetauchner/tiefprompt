// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'in_app_purchase_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(InAppPurchaseData)
final inAppPurchaseDataProvider = InAppPurchaseDataProvider._();

final class InAppPurchaseDataProvider
    extends $NotifierProvider<InAppPurchaseData, InAppPurchaseDataState> {
  InAppPurchaseDataProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'inAppPurchaseDataProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$inAppPurchaseDataHash();

  @$internal
  @override
  InAppPurchaseData create() => InAppPurchaseData();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InAppPurchaseDataState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InAppPurchaseDataState>(value),
    );
  }
}

String _$inAppPurchaseDataHash() => r'6901e4779db5aa2a8298a287f0474b5e9f219712';

abstract class _$InAppPurchaseData extends $Notifier<InAppPurchaseDataState> {
  InAppPurchaseDataState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<InAppPurchaseDataState, InAppPurchaseDataState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<InAppPurchaseDataState, InAppPurchaseDataState>,
              InAppPurchaseDataState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
