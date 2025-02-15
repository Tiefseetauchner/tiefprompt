import 'package:drift/drift.dart';

class ScriptModel extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 6, max: 32)();
  TextColumn get scriptText => text().named('body')();
  DateTimeColumn get createdAt => dateTime().nullable()();
}
