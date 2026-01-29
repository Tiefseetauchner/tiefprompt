import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/models/keybinding.dart';
import 'package:tiefprompt/providers/database_provider.dart';
import 'package:tiefprompt/providers/settings_provider.dart';

part 'keybinding_provider.g.dart';

@Riverpod(keepAlive: true, dependencies: [Settings, DatabaseManagers])
class Keybindings extends _$Keybindings {
  late final _databaseManagers = ref.read(databaseManagersProvider);

  @override
  Future<KeybindingMap> build() async {
    if (await _databaseManagers.keybindingMapModel
            .filter((b) => b.id.equals(0))
            .count() ==
        0) {
      await _initializeDefaultKeybindings();
    }

    return await getCurrentKeybindings();
  }

  Future<KeybindingMap> getCurrentKeybindings() async {
    // NOTE: Due to potential for future expansion, this is hardcoded to 0
    final keybindingsMapId = 0;

    return getKeybindings(keybindingsMapId);
  }

  Future<KeybindingMap> getKeybindings(int keybindingsMapId) async {
    return KeybindingMap.fromBindings(
      await _databaseManagers.keybindingMappingModel
          .filter((b) => b.mapId.id.equals(keybindingsMapId))
          .get(),
    );
  }

  Future<void> _initializeDefaultKeybindings() async {
    // NOTE: Due to potential for future expansion, this is hardcoded to 0
    final keybindingsMapId = 0;

    await _setCurrentKeybindings(kDefaultKeybindings, keybindingsMapId);
  }

  Future<void> copyBindingsToCurrent(int keybindingMapId) async {
    // NOTE: Due to potential for future expansion, this is hardcoded to 0
    final currentMapId = 0;

    final newBindings = await getKeybindings(keybindingMapId);
    await _setCurrentKeybindings(newBindings, currentMapId);
  }

  Future<void> _setCurrentKeybindings(
    KeybindingMap bindingMap,
    int bindingMapId,
  ) async {
    await _databaseManagers.keybindingMapModel
        .filter((o) => o.id.equals(bindingMapId))
        .delete();
    await _databaseManagers.keybindingMappingModel
        .filter((o) => o.mapId.id.equals(bindingMapId))
        .delete();

    await _databaseManagers.keybindingMapModel.create((o) => o(id: Value(0)));

    await _databaseManagers.keybindingMappingModel.bulkCreate(
      (o) => [
        for (final binding in bindingMap.keybindings)
          o(
            mapId: bindingMapId,
            actionName: binding.$1.name,
            keyId: binding.$2.keyId,
            ctrl: binding.$2.ctrl,
            shift: binding.$2.shift,
            alt: binding.$2.alt,
            meta: binding.$2.meta,
          ),
      ],
    );
  }

  Future<List<KeybindingAction>> actionForEvent(KeyEvent event) async {
    final keybindingMap = state.valueOrNull ?? await future;
    final keyId = event.logicalKey.keyId;
    final hardwareKeyboard = HardwareKeyboard.instance;
    final ctrl = hardwareKeyboard.isControlPressed;
    final shift = hardwareKeyboard.isShiftPressed;
    final alt = hardwareKeyboard.isAltPressed;
    final meta = hardwareKeyboard.isMetaPressed;
    final actions = <KeybindingAction>[];

    for (final entry in keybindingMap.keybindings) {
      final binding = entry.$2;
      if (binding.keyId != keyId) {
        continue;
      }
      if (binding.ctrl != ctrl ||
          binding.shift != shift ||
          binding.alt != alt ||
          binding.meta != meta) {
        continue;
      }
      actions.add(entry.$1);
      break;
    }

    return actions;
  }

  Future<void> removeBinding(
    KeybindingAction action,
    Keybinding keybinding,
  ) async {
    final keybindingsMapId = (await ref.read(
      settingsProvider.future,
    )).keybindingsMapId;

    state = state.whenData(
      (s) => KeybindingMap(
        s.keybindings..removeWhere((b) => b.$1 == action && b.$2 == keybinding),
      ),
    );

    await _databaseManagers.keybindingMappingModel
        .filter((f) => f.mapId.id.equals(keybindingsMapId))
        .filter((f) => f.actionName.equals(action.name))
        .filter((f) => f.keyId.equals(keybinding.keyId))
        .filter((f) => f.ctrl.equals(keybinding.ctrl))
        .filter((f) => f.shift.equals(keybinding.shift))
        .filter((f) => f.alt.equals(keybinding.alt))
        .filter((f) => f.meta.equals(keybinding.meta))
        .delete();
  }

  Future<void> addBinding(
    KeybindingAction action,
    Keybinding keybinding,
  ) async {
    final keybindingsMapId = (await ref.read(
      settingsProvider.future,
    )).keybindingsMapId;

    state = state.whenData(
      (s) => KeybindingMap(s.keybindings..add((action, keybinding))),
    );

    await _databaseManagers.keybindingMappingModel.create(
      (o) => o(
        mapId: keybindingsMapId,
        actionName: action.name,
        keyId: keybinding.keyId,
        ctrl: keybinding.ctrl,
        shift: keybinding.shift,
        alt: keybinding.alt,
        meta: keybinding.meta,
      ),
    );
  }

  Future<void> resetToDefaults() async {
    await _initializeDefaultKeybindings();

    state = AsyncData(kDefaultKeybindings);

    ref.read(settingsProvider.notifier).setKeybindings(0);
  }

  Future<int> createKeybindingsMap(KeybindingMap bindings) async {
    final keybindingMapId = await _databaseManagers.keybindingMapModel.create(
      (o) => o(),
    );

    await _databaseManagers.keybindingMappingModel.bulkCreate(
      (o) => [
        for (final binding in bindings.keybindings)
          o(
            mapId: keybindingMapId,
            actionName: binding.$1.name,
            keyId: binding.$2.keyId,
            ctrl: binding.$2.ctrl,
            shift: binding.$2.shift,
            alt: binding.$2.alt,
            meta: binding.$2.meta,
          ),
      ],
    );

    return keybindingMapId;
  }
}
