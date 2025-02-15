import 'package:drift/drift.dart';

class ScriptModel extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get scriptText => text()();
  DateTimeColumn get createdAt => dateTime()();
}
