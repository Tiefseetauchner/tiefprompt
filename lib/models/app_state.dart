import 'package:drift/drift.dart';

class AppStateModel extends Table {
  BoolColumn get helpRequestShown => boolean()();
  TextColumn get lastSeenVersion => text().nullable()();
}
