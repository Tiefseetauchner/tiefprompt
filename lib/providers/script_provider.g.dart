// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'script_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Script)
final scriptProvider = ScriptProvider._();

final class ScriptProvider extends $NotifierProvider<Script, ScriptState> {
  ScriptProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'scriptProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$scriptHash();

  @$internal
  @override
  Script create() => Script();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ScriptState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ScriptState>(value),
    );
  }
}

String _$scriptHash() => r'cb6d99fce4b51c730adf4e95979085e1cddc51ec';

abstract class _$Script extends $Notifier<ScriptState> {
  ScriptState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ScriptState, ScriptState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ScriptState, ScriptState>,
              ScriptState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
