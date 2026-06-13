// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'script_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$scriptServiceHash() => r'f7f03b78befe880341227549425d1e5e7f55cb59';

/// See also [ScriptService].
@ProviderFor(ScriptService)
final scriptServiceProvider =
    AutoDisposeAsyncNotifierProvider<ScriptService, void>.internal(
      ScriptService.new,
      name: r'scriptServiceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$scriptServiceHash,
      dependencies: <ProviderOrFamily>[databaseManagersProvider],
      allTransitiveDependencies: <ProviderOrFamily>{
        databaseManagersProvider,
        ...?databaseManagersProvider.allTransitiveDependencies,
      },
    );

typedef _$ScriptService = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
