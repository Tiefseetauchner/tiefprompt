import 'package:drift/drift.dart';

class ScriptModel extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get scriptText => text()();
  DateTimeColumn get createdAt => dateTime()();
  BoolColumn get ephemeral => boolean().withDefault(Constant(false))();
  RealColumn get scrollPosition => real().withDefault(Constant(0))();
}
