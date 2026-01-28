import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tiefprompt/models/database.dart';

part 'database_provider.g.dart';

@Riverpod(keepAlive: true)
class AppDatabaseManager extends _$AppDatabaseManager {
  @override
  AppDatabase build() {
    final db = AppDatabase();
    ref.onDispose(db.close);
    return db;
  }
}

@Riverpod(keepAlive: true, dependencies: [AppDatabaseManager])
class DatabaseManagers extends _$DatabaseManagers {
  @override
  $AppDatabaseManager build() {
    return ref.watch(appDatabaseManagerProvider).managers;
  }
}
