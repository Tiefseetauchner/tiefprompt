// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'script_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ScriptService)
final scriptServiceProvider = ScriptServiceProvider._();

final class ScriptServiceProvider
    extends $AsyncNotifierProvider<ScriptService, void> {
  ScriptServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'scriptServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$scriptServiceHash();

  @$internal
  @override
  ScriptService create() => ScriptService();
}

String _$scriptServiceHash() => r'4ced05b027a635e3b45f9424c2131236f6b64abf';

abstract class _$ScriptService extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
