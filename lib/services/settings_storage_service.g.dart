// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_storage_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$settingsStorageServiceHash() =>
    r'f240c4ee753ffb03961d64bfbf237faccebae520';

/// See also [SettingsStorageService].
@ProviderFor(SettingsStorageService)
final settingsStorageServiceProvider =
    AutoDisposeAsyncNotifierProvider<SettingsStorageService, void>.internal(
      SettingsStorageService.new,
      name: r'settingsStorageServiceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$settingsStorageServiceHash,
      dependencies: <ProviderOrFamily>[
        settingsProvider,
        keybindingsProvider,
        databaseManagersProvider,
      ],
      allTransitiveDependencies: <ProviderOrFamily>{
        settingsProvider,
        ...?settingsProvider.allTransitiveDependencies,
        keybindingsProvider,
        ...?keybindingsProvider.allTransitiveDependencies,
        databaseManagersProvider,
        ...?databaseManagersProvider.allTransitiveDependencies,
      },
    );

typedef _$SettingsStorageService = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
