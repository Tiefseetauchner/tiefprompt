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
      return kDefaultKeybindings;
    }
  }

  Future<List<KeybindingAction>> actionForEvent(KeyEvent event) async {
    final keybindingMap = state.valueOrNull ?? await future;
    final keyId = event.physicalKey.usbHidUsage;
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
      s.keybindings[action] = keybindings;

      _prefs.setString(_keybindingKey, s.toJson());

      return s;
    });
  }

  Future<void> resetToDefaults() async {
    state = state.whenData((_) => kDefaultKeybindings);
  }
}
