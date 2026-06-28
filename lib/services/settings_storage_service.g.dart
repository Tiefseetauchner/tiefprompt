// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_storage_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SettingsStorageService)
final settingsStorageServiceProvider = SettingsStorageServiceProvider._();

final class SettingsStorageServiceProvider
    extends $AsyncNotifierProvider<SettingsStorageService, void> {
  SettingsStorageServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsStorageServiceProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[settingsProvider, keybindingsProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          SettingsStorageServiceProvider.$allTransitiveDependencies0,
          SettingsStorageServiceProvider.$allTransitiveDependencies1,
        ],
      );

  static final $allTransitiveDependencies0 = settingsProvider;
  static final $allTransitiveDependencies1 = keybindingsProvider;

  @override
  String debugGetCreateSourceHash() => _$settingsStorageServiceHash();

  @$internal
  @override
  SettingsStorageService create() => SettingsStorageService();
}

String _$settingsStorageServiceHash() =>
    r'b8f0f6602713a0d1620085a41fb689004b92ee6e';

abstract class _$SettingsStorageService extends $AsyncNotifier<void> {
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
