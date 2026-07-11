// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screenshots_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Screenshots)
final screenshotsProvider = ScreenshotsProvider._();

final class ScreenshotsProvider
    extends $NotifierProvider<Screenshots, List<(String, List<int>)>> {
  ScreenshotsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'screenshotsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$screenshotsHash();

  @$internal
  @override
  Screenshots create() => Screenshots();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<(String, List<int>)> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<(String, List<int>)>>(value),
    );
  }
}

String _$screenshotsHash() => r'7cd57d987ee7dd7dcca4770084f5643cfdb846e7';

abstract class _$Screenshots extends $Notifier<List<(String, List<int>)>> {
  List<(String, List<int>)> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<List<(String, List<int>)>, List<(String, List<int>)>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<(String, List<int>)>, List<(String, List<int>)>>,
              List<(String, List<int>)>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
