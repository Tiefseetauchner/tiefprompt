import 'package:drift/drift.dart' hide JsonKey;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tiefprompt/models/keybinding.drift.dart';

part 'keybinding.freezed.dart';
part 'keybinding.g.dart';

enum KeybindingAction {
  playPause,
  scrollUpSmall,
  scrollDownSmall,
  scrollUp,
  scrollDown,
  pageUp,
  pageDown,
  jumpStart,
  jumpEnd,
  toggleControls,
  speedUp,
  speedDown,
  fontSizeUp,
  fontSizeDown,
  openSettings,
  saveSettingsFromPrompter,
}

final Map<String, KeybindingAction> _actionByName = {
  for (final action in KeybindingAction.values) action.name: action,
};

@freezed
abstract class Keybinding with _$Keybinding {
  const Keybinding._();

  factory Keybinding({
    required int keyId,
    @Default(false) bool ctrl,
    @Default(false) bool shift,
    @Default(false) bool alt,
    @Default(false) bool meta,
  }) = _Keybinding;

  factory Keybinding.fromJson(Map<String, dynamic> json) =>
      _$KeybindingFromJson(json);

  int get specificity =>
      (ctrl ? 1 : 0) + (shift ? 1 : 0) + (alt ? 1 : 0) + (meta ? 1 : 0);
}

class KeybindingMappingModel extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get mapId => integer().references(
    KeybindingMapModel,
    #id,
    onDelete: KeyAction.cascade,
  )();

  IntColumn get keyId => integer()();
  BoolColumn get ctrl => boolean()();
  BoolColumn get shift => boolean()();
  BoolColumn get alt => boolean()();
  BoolColumn get meta => boolean()();
  TextColumn get actionName => text().check(
    actionName.isIn(KeybindingAction.values.map((e) => e.name)),
  )();
}

class KeybindingMapModel extends Table {
  IntColumn get id => integer().autoIncrement()();
}

@freezed
abstract class KeybindingMap with _$KeybindingMap {
  factory KeybindingMap({
    required List<(KeybindingAction, Keybinding)> keybindings,
  }) = _KeybindingMap;

  factory KeybindingMap.fromBindings(
    List<KeybindingMappingModelData> bindings,
  ) {
    return KeybindingMap(
      keybindings: bindings
          .map(
            (b) => (
              _actionByName[b.actionName]!,
              Keybinding(
                keyId: b.keyId,
                ctrl: b.ctrl,
                shift: b.shift,
                alt: b.alt,
                meta: b.meta,
              ),
            ),
          )
          .toList(),
    );
  }

  factory KeybindingMap.fromJson(Map<String, dynamic> json) =>
      _$KeybindingMapFromJson(json);
}
