// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screenshot_manager_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ScreenshotManagerState)
final screenshotManagerStateProvider = ScreenshotManagerStateProvider._();

final class ScreenshotManagerStateProvider
    extends $NotifierProvider<ScreenshotManagerState, ScreenshotManager?> {
  ScreenshotManagerStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'screenshotManagerStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$screenshotManagerStateHash();

  @$internal
  @override
  ScreenshotManagerState create() => ScreenshotManagerState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ScreenshotManager? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ScreenshotManager?>(value),
    );
  }
}

String _$screenshotManagerStateHash() =>
    r'bff905c99a502c2e1da9446e73f9558686f4861d';

abstract class _$ScreenshotManagerState extends $Notifier<ScreenshotManager?> {
  ScreenshotManager? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ScreenshotManager?, ScreenshotManager?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ScreenshotManager?, ScreenshotManager?>,
              ScreenshotManager?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
