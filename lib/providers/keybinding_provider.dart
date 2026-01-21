import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/models/keybinding.dart';

part 'keybinding_provider.g.dart';

@Riverpod(keepAlive: true)
class Keybindings extends _$Keybindings {
  late final SharedPreferences _prefs;
  final String _keybindingKey = "keybindings";

  @override
  Future<KeybindingMap> build() async {
    _prefs = await SharedPreferences.getInstance();
    final keybindingsJson = _prefs.getString(_keybindingKey);

    if (keybindingsJson != null) {
      return KeybindingMap.fromJson(keybindingsJson);
    } else {
      _prefs.setString(_keybindingKey, kDefaultKeybindings.toJson());

      return kDefaultKeybindings;
    }
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

    for (final entry in keybindingMap.keybindings.entries) {
      final bindings = entry.value;
      for (int i = 0; i < bindings.length; i++) {
        final binding = bindings[i];
        if (binding.keyId != keyId) {
          continue;
        }
        if (binding.ctrl != ctrl ||
            binding.shift != shift ||
            binding.alt != alt ||
            binding.meta != meta) {
          continue;
        }
        actions.add(entry.key);
        break;
      }
    }

    return actions;
  }

  Future<void> setBinding(
    KeybindingAction action,
    List<Keybinding> keybindings,
  ) async {
    state = state.whenData((s) {
      final updatedBindings = <KeybindingAction, List<Keybinding>>{};
      for (final entry in s.keybindings.entries) {
        updatedBindings[entry.key] = entry.key == action
            ? List<Keybinding>.from(keybindings)
            : List<Keybinding>.from(entry.value);
      }
      if (!updatedBindings.containsKey(action)) {
        updatedBindings[action] = List<Keybinding>.from(keybindings);
      }

      final updated = KeybindingMap(updatedBindings);
      _prefs.setString(_keybindingKey, updated.toJson());

      return updated;
    });
  }

  Future<void> resetToDefaults() async {
    state = state.whenData((s) {
      _prefs.setString(_keybindingKey, kDefaultKeybindings.toJson());

      return kDefaultKeybindings;
    });
  }
}
