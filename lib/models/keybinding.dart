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

  // factory KeybindingMap.fromJson(String json) {
  //   final Map<String, dynamic> decoded =
  //       jsonDecode(json) as Map<String, dynamic>;
  //   final Map<KeybindingAction, List<Keybinding>> bindings =
  //       <KeybindingAction, List<Keybinding>>{};

  //   for (final MapEntry<String, dynamic> entry in decoded.entries) {
  //     final KeybindingAction? action = _actionByName[entry.key];
  //     if (action == null) {
  //       continue;
  //     }

  //     final List<dynamic> rawBindings = entry.value as List<dynamic>;
  //     bindings[action] = List<Keybinding>.generate(rawBindings.length, (int i) {
  //       final Map<String, dynamic> raw = rawBindings[i] as Map<String, dynamic>;
  //       final int keyId = raw['keyId'] as int;

  //       return Keybinding(
  //         keyId,
  //         ctrl: raw['ctrl'] as bool,
  //         shift: raw['shift'] as bool,
  //         alt: raw['alt'] as bool,
  //         meta: raw['meta'] as bool,
  //       );
  //     });
  //   }

  //   return KeybindingMap(bindings);
  // }

  // String toJson() {
  //   final Map<String, dynamic> encoded = <String, dynamic>{};
  //   for (final MapEntry<KeybindingAction, List<Keybinding>> entry
  //       in keybindings.entries) {
  //     encoded[entry.key.name] = List<Map<String, dynamic>>.generate(
  //       entry.value.length,
  //       (int i) {
  //         final Keybinding binding = entry.value[i];
  //         return <String, dynamic>{
  //           'keyId': binding.keyId,
  //           'ctrl': binding.ctrl,
  //           'shift': binding.shift,
  //           'alt': binding.alt,
  //           'meta': binding.meta,
  //         };
  //       },
  //     );
  //   }
  //   return jsonEncode(encoded);
  // }
}
