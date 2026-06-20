import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tiefprompt/models/database.dart';
import 'package:tiefprompt/models/database.drift.dart';

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

@Riverpod(keepAlive: true)
$AppDatabaseManager databaseManagers(Ref ref) {
  return ref.watch(appDatabaseManagerProvider).managers;
}
