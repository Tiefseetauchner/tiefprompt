import 'package:drift/drift.dart';
import 'package:tiefprompt/models/keybinding.dart';

class SettingsPresetModel extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  DateTimeColumn get createdAt => dateTime()();

  TextColumn get data => text()();

  IntColumn get keybindings => integer().references(
    KeybindingMapModel,
    #id,
    onDelete: KeyAction.cascade,
  )();
}
