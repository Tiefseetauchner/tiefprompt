// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Features)
final featuresProvider = FeaturesProvider._();

final class FeaturesProvider extends $NotifierProvider<Features, AppFeatures> {
  FeaturesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'featuresProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$featuresHash();

  @$internal
  @override
  Features create() => Features();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppFeatures value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppFeatures>(value),
    );
  }
}

String _$featuresHash() => r'73c684069f0a0bd232bab41b41649f1a1f59da30';

abstract class _$Features extends $Notifier<AppFeatures> {
  AppFeatures build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AppFeatures, AppFeatures>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppFeatures, AppFeatures>,
              AppFeatures,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
