// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appDatabaseManagerHash() =>
    r'24f0ffb20ce983fbe55e5c7e33e5b44b02c2c8c6';

/// See also [AppDatabaseManager].
@ProviderFor(AppDatabaseManager)
final appDatabaseManagerProvider =
    NotifierProvider<AppDatabaseManager, AppDatabase>.internal(
      AppDatabaseManager.new,
      name: r'appDatabaseManagerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$appDatabaseManagerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AppDatabaseManager = Notifier<AppDatabase>;
String _$databaseManagersHash() => r'8b88c5a18990798273ae7587e9d4090dd7e6e1d8';

/// See also [DatabaseManagers].
@ProviderFor(DatabaseManagers)
final databaseManagersProvider =
    NotifierProvider<DatabaseManagers, $AppDatabaseManager>.internal(
      DatabaseManagers.new,
      name: r'databaseManagersProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$databaseManagersHash,
      dependencies: <ProviderOrFamily>[appDatabaseManagerProvider],
      allTransitiveDependencies: <ProviderOrFamily>{
        appDatabaseManagerProvider,
        ...?appDatabaseManagerProvider.allTransitiveDependencies,
      },
    );

typedef _$DatabaseManagers = Notifier<$AppDatabaseManager>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
