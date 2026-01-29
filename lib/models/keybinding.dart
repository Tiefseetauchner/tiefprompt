import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:tiefprompt/models/database.dart';

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

class Keybinding {
  final int keyId;
  final bool ctrl;
  final bool shift;
  final bool alt;
  final bool meta;

  int get specificity =>
      (ctrl ? 1 : 0) + (shift ? 1 : 0) + (alt ? 1 : 0) + (meta ? 1 : 0);

  Keybinding(
    this.keyId, {
    this.ctrl = false,
    this.shift = false,
    this.alt = false,
    this.meta = false,
  });
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

class KeybindingMap {
  final List<(KeybindingAction, Keybinding)> keybindings;

  const KeybindingMap(this.keybindings);

  factory KeybindingMap.fromBindings(
    List<KeybindingMappingModelData> bindings,
  ) {
    return KeybindingMap(
      bindings
          .map(
            (b) => (
              _actionByName[b.actionName]!,
              Keybinding(
                b.keyId,
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

  factory KeybindingMap.fromJson(List<dynamic> jsonList) {
    final bindings = <(KeybindingAction, Keybinding)>[];

    for (final entry in jsonList) {
      final KeybindingAction? action = _actionByName[entry.actionName];
      if (action == null) {
        continue;
      }

      bindings.add((
        action,
        Keybinding(
          entry.keyId,
          ctrl: entry.ctrl,
          shift: entry.shift,
          alt: entry.alt,
          meta: entry.meta,
        ),
      ));
    }

    return KeybindingMap(bindings);
  }

  String toJson() => jsonEncode(toJsonMap());

  dynamic toJsonMap() => [
    for (final entry in keybindings)
      {
        'actionName': entry.$1.name,
        'keyId': entry.$2.keyId,
        'ctrl': entry.$2.ctrl,
        'shift': entry.$2.shift,
        'alt': entry.$2.alt,
        'meta': entry.$2.meta,
      },
  ];
}
