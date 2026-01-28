import 'package:drift/drift.dart';
import 'package:tiefprompt/models/keybinding.dart';

class SettingsPresetModel extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  DateTimeColumn get createdAt => dateTime()();

  RealColumn get scrollSpeed => real()();
  BoolColumn get mirroredX => boolean()();
  BoolColumn get mirroredY => boolean()();
  RealColumn get fontSize => real()();
  RealColumn get sideMargin => real()();
  TextColumn get fontFamily => text()();
  TextColumn get alignment => text()();
  BoolColumn get displayReadingIndicatorBoxes => boolean()();
  RealColumn get readingIndicatorBoxesHeight => real()();
  BoolColumn get displayVerticalMarginBoxes => boolean()();
  RealColumn get verticalMarginBoxesHeight => real()();
  BoolColumn get verticalMarginBoxesFadeEnabled => boolean()();
  RealColumn get verticalMarginBoxesFadeLength => real()();
  RealColumn get countdownDuration => real()();
  TextColumn get themeMode => text()();
  IntColumn get appPrimaryColor => integer()();
  IntColumn get prompterBackgroundColor => integer()();
  IntColumn get prompterTextColor => integer()();
  BoolColumn get markdownEnabled => boolean()();

  IntColumn get keybindings => integer().references(
    KeybindingMapModel,
    #id,
    onDelete: KeyAction.cascade,
  )();
}
