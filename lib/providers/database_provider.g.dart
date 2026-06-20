// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AppDatabaseManager)
final appDatabaseManagerProvider = AppDatabaseManagerProvider._();

final class AppDatabaseManagerProvider
    extends $NotifierProvider<AppDatabaseManager, AppDatabase> {
  AppDatabaseManagerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseManagerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseManagerHash();

  @$internal
  @override
  AppDatabaseManager create() => AppDatabaseManager();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$appDatabaseManagerHash() =>
    r'24f0ffb20ce983fbe55e5c7e33e5b44b02c2c8c6';

abstract class _$AppDatabaseManager extends $Notifier<AppDatabase> {
  AppDatabase build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AppDatabase, AppDatabase>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppDatabase, AppDatabase>,
              AppDatabase,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(databaseManagers)
final databaseManagersProvider = DatabaseManagersProvider._();

final class DatabaseManagersProvider
    extends
        $FunctionalProvider<
          $AppDatabaseManager,
          $AppDatabaseManager,
          $AppDatabaseManager
        >
    with $Provider<$AppDatabaseManager> {
  DatabaseManagersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'databaseManagersProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$databaseManagersHash();

  @$internal
  @override
  $ProviderElement<$AppDatabaseManager> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  $AppDatabaseManager create(Ref ref) {
    return databaseManagers(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue($AppDatabaseManager value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<$AppDatabaseManager>(value),
    );
  }
}

String _$databaseManagersHash() => r'50a59805832f60b38af5ee45daceea58d9fcb6e5';
