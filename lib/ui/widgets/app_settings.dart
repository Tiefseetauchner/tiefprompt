import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/models/keybinding.dart';
import 'package:tiefprompt/providers/feature_provider.dart';
import 'package:tiefprompt/providers/keybinding_provider.dart';

abstract class AppSetting extends ConsumerWidget {
  final Feature feature;
  final String displayText;

  const AppSetting({
    super.key,
    required this.feature,
    required this.displayText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!_isEnabled(ref)) {
      return FeatureDisabledAppSetting(displayText: displayText);
    }

    return buildSetting(context, ref);
  }

  bool _isEnabled(WidgetRef ref) {
    return ref.watch(
      featuresProvider.select((s) => s.features.contains(feature)),
    );
  }

  Widget buildSetting(BuildContext context, WidgetRef ref);
}

abstract class StatefulAppSetting extends ConsumerStatefulWidget {
  final Feature feature;
  final String displayText;

  const StatefulAppSetting({
    super.key,
    required this.feature,
    required this.displayText,
  });
}

abstract class StatefulAppSettingState<T extends StatefulAppSetting>
    extends ConsumerState<T> {
  @override
  Widget build(BuildContext context) {
    if (!_isEnabled()) {
      return FeatureDisabledAppSetting(displayText: widget.displayText);
    }

    return buildSetting(context);
  }

  bool _isEnabled() {
    return ref.watch(
      featuresProvider.select((s) => s.features.contains(widget.feature)),
    );
  }

  Widget buildSetting(BuildContext context);
}

class FeatureDisabledAppSetting extends ConsumerWidget {
  final String displayText;

  const FeatureDisabledAppSetting({super.key, required this.displayText});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      tileColor: Colors.blueGrey.withAlpha(30),
      title: Text(displayText),
      subtitle: Text(context.tr("ProFeatureDisabled")),
      onTap: () => {ref.read(featuresProvider.notifier).buyPro()},
    );
  }
}

class DropdownAppSetting<T> extends AppSetting {
  final T value;
  final Function(T) onValueChanged;
  final List<(String, T)> values;

  const DropdownAppSetting({
    super.key,
    required super.feature,
    required super.displayText,
    required this.value,
    required this.onValueChanged,
    required this.values,
  });

  @override
  Widget buildSetting(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(displayText),
      trailing: DropdownButton<T>(
        value: value,
        items: values.map((value) {
          return DropdownMenuItem<T>(value: value.$2, child: Text(value.$1));
        }).toList(),
        onChanged: (newValue) {
          if (newValue != null) {
            onValueChanged(newValue);
          }
        },
      ),
    );
  }
}

class BooleanAppSetting extends AppSetting {
  final bool value;
  final Function(bool) onValueChanged;

  const BooleanAppSetting({
    super.key,
    required super.feature,
    required super.displayText,
    required this.value,
    required this.onValueChanged,
  });

  @override
  Widget buildSetting(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(displayText),
      trailing: Switch(value: value, onChanged: onValueChanged),
      onTap: () => onValueChanged(!value),
    );
  }
}

class LinkAppSetting extends AppSetting {
  const LinkAppSetting({
    super.key,
    required super.displayText,
    required super.feature,
    required this.value,
  });

  final String value;

  @override
  Widget buildSetting(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(displayText),
      onTap: () => context.push("/settings/$value"),
    );
  }
}

class KeybindingAppSetting extends StatefulAppSetting {
  const KeybindingAppSetting({
    super.key,
    required super.feature,
    required super.displayText,
    required this.bindings,
    required this.bindingAction,
  });

  final List<Keybinding> bindings;
  final KeybindingAction bindingAction;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _KeybindingAppSettingState();
}

class _KeybindingAppSettingState
    extends StatefulAppSettingState<KeybindingAppSetting> {
  @override
  Widget buildSetting(BuildContext context) {
    return ListTile(
      title: Text(widget.displayText),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [_getBindingsDisplay(), Icon(Icons.chevron_right)],
      ),
      onTap: () => _showDialog(context),
    );
  }

  void _showDialog(BuildContext context) {
    final List<Keybinding> dialogBindings = List<Keybinding>.from(
      widget.bindings,
    );

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(
            context.tr("SettingsScreen.KeybindingsSettings.ChangeBindings"),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              children: [
                ...dialogBindings.map(
                  (b) => ListTile(
                    title: Text(_getBindingDisplay(b)),
                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          dialogBindings.remove(b);
                        });
                        ref
                            .read(keybindingsProvider.notifier)
                            .setBinding(
                              widget.bindingAction,
                              List<Keybinding>.from(dialogBindings),
                            );
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    context.tr("SettingsScreen.KeybindingsSettings.AddBinding"),
                  ),
                  onTap: () async {
                    final newBinding = await _captureBinding(context);
                    if (newBinding == null) {
                      return;
                    }
                    if (dialogBindings.any(
                      (existing) => _isSameBinding(existing, newBinding),
                    )) {
                      return;
                    }
                    setState(() {
                      dialogBindings.add(newBinding);
                    });
                    ref
                        .read(keybindingsProvider.notifier)
                        .setBinding(
                          widget.bindingAction,
                          List<Keybinding>.from(dialogBindings),
                        );
                  },
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(context.tr("SettingsScreen.ElevatedButton_Save")),
            ),
          ],
        ),
      ),
    );
  }

  Future<Keybinding?> _captureBinding(BuildContext context) async {
    final focusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (focusNode.canRequestFocus) {
        focusNode.requestFocus();
      }
    });

    final binding = await showDialog<Keybinding>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          context.tr("SettingsScreen.KeybindingsSettings.CaptureBindingTitle"),
        ),
        content: KeyboardListener(
          focusNode: focusNode,
          autofocus: true,
          onKeyEvent: (keyEvent) {
            if (keyEvent is! KeyDownEvent) {
              return;
            }
            final key = keyEvent.logicalKey;
            if (_isModifierKey(key)) {
              return;
            }

            final hardwareKeyboard = HardwareKeyboard.instance;
            final newBinding = Keybinding(
              key.keyId,
              ctrl: hardwareKeyboard.isControlPressed,
              shift: hardwareKeyboard.isShiftPressed,
              alt: hardwareKeyboard.isAltPressed,
              meta: hardwareKeyboard.isMetaPressed,
            );
            Navigator.of(context).pop(newBinding);
          },
          child: Text(
            context.tr("SettingsScreen.KeybindingsSettings.CaptureBindingHint"),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(context.tr("SettingsScreen.Abort")),
          ),
        ],
      ),
    );

    focusNode.dispose();
    return binding;
  }

  bool _isModifierKey(LogicalKeyboardKey key) {
    return key == LogicalKeyboardKey.controlLeft ||
        key == LogicalKeyboardKey.controlRight ||
        key == LogicalKeyboardKey.shiftLeft ||
        key == LogicalKeyboardKey.shiftRight ||
        key == LogicalKeyboardKey.altLeft ||
        key == LogicalKeyboardKey.altRight ||
        key == LogicalKeyboardKey.altGraph ||
        key == LogicalKeyboardKey.metaLeft ||
        key == LogicalKeyboardKey.metaRight;
  }

  bool _isSameBinding(Keybinding a, Keybinding b) {
    return a.keyId == b.keyId &&
        a.ctrl == b.ctrl &&
        a.shift == b.shift &&
        a.alt == b.alt &&
        a.meta == b.meta;
  }

  Widget _getBindingsDisplay() {
    if (widget.bindings.isEmpty) {
      return Text("No Binding", style: TextStyle(fontStyle: FontStyle.italic));
    }

    if (widget.bindings.length == 1) {
      return Text(_getBindingDisplay(widget.bindings.first));
    }

    return Text("${_getBindingDisplay(widget.bindings.first)}, ...");
  }

  String _getBindingDisplay(Keybinding b) =>
      "${b.ctrl ? "Ctrl + " : ""}${b.alt ? "Alt + " : ""}${b.shift ? "Shift + " : ""}${b.meta ? "Meta + " : ""}${LogicalKeyboardKey(b.keyId).keyLabel == " " ? "Space" : LogicalKeyboardKey(b.keyId).keyLabel}";
}

class NumberAppSetting extends StatefulAppSetting {
  const NumberAppSetting({
    super.key,
    required super.feature,
    required super.displayText,
    required this.value,
    required this.onValueChanged,
    required this.min,
    required this.max,
    this.stepSize,
    this.unit,
  });

  final double value;
  final Function(double) onValueChanged;
  final double min;
  final double max;
  final double? stepSize;
  final String? unit;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NumberAppSettingState();
}

class _NumberAppSettingState extends StatefulAppSettingState<NumberAppSetting> {
  double selectedValue = 0;

  @override
  void initState() {
    selectedValue = widget.value;

    super.initState();
  }

  void _showDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              16.0,
              16.0,
              16.0,
              MediaQuery.of(context).viewInsets.bottom + 16.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.displayText, style: TextStyle(fontSize: 18)),
                Text(
                  widget.value.toStringAsFixed(1) +
                      (widget.unit == null ? "" : " ${widget.unit!}"),
                  style: TextStyle(fontSize: 12),
                ),
                DecimalPicker(
                  min: widget.min,
                  max: widget.max,
                  stepSize: widget.stepSize,
                  initialValue: widget.value,
                  onChanged: (value) => setState(() => selectedValue = value),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.onValueChanged(selectedValue);
                    Navigator.pop(context);
                  },
                  child: Text(
                    context.tr(
                      "SettingsScreen.NumberAppSetting.ElevatedButton_Save",
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSetting(BuildContext context) {
    return ListTile(
      title: Text(widget.displayText),
      trailing: Icon(Icons.chevron_right),
      subtitle: Text("${widget.value.toStringAsFixed(1)} ${widget.unit}"),
      onTap: () {
        _showDialog(context);
      },
    );
  }
}

class DecimalPicker extends StatefulWidget {
  final double min;
  final double max;
  final double? stepSize;
  final double initialValue;
  final ValueChanged<double> onChanged;

  const DecimalPicker({
    required this.min,
    required this.max,
    this.stepSize,
    required this.initialValue,
    required this.onChanged,
    super.key,
  });

  @override
  State<DecimalPicker> createState() => _DecimalPickerState();
}

class _DecimalPickerState extends State<DecimalPicker> {
  late double value;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
    controller = TextEditingController(text: value.toStringAsFixed(1));
  }

  void updateValue(double newValue) {
    setState(() {
      value = newValue;
      controller.text = value.toStringAsFixed(1);
    });
    widget.onChanged(value);
  }

  void onTextChanged(String text) {
    final parsed = double.tryParse(text);
    if (parsed != null) {
      final snapped = widget.stepSize == null
          ? parsed
          : (parsed / widget.stepSize!).round() * widget.stepSize!;
      final newValue = snapped.clamp(widget.min, widget.max);
      updateValue(newValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
          ],
          onSubmitted: onTextChanged,
          decoration: InputDecoration(
            labelText: context.tr("SettingsScreen.NumberAppSetting.Value"),
          ),
        ),
        Slider(
          value: value,
          min: widget.min,
          max: widget.max,
          divisions: widget.stepSize == null
              ? null
              : ((widget.max - widget.min) / widget.stepSize!).round(),
          onChanged: updateValue,
        ),
      ],
    );
  }
}

class ColorAppSetting extends StatefulAppSetting {
  const ColorAppSetting({
    super.key,
    required super.feature,
    required super.displayText,
    required this.value,
    required this.onValueChanged,
  });

  final Color value;
  final Function(Color) onValueChanged;

  @override
  ConsumerState<StatefulAppSetting> createState() => _ColorAppSettingState();
}

class _ColorAppSettingState extends StatefulAppSettingState<ColorAppSetting> {
  Color selectedValue = Colors.black;

  @override
  void initState() {
    selectedValue = widget.value;

    super.initState();
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(widget.displayText, style: TextStyle(fontSize: 18)),
        content: ColorPicker(
          enableAlpha: false,
          hexInputBar: true,
          pickerColor: selectedValue,
          onColorChanged: (c) => selectedValue = c,
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              widget.onValueChanged(selectedValue);
              Navigator.pop(context);
            },
            child: Text(
              context.tr("SettingsScreen.NumberAppSetting.ElevatedButton_Save"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildSetting(BuildContext context) {
    return ListTile(
      title: Text(widget.displayText),
      trailing: Icon(Icons.chevron_right),
      onTap: () {
        _showDialog(context);
      },
    );
  }
}

class DialogAppSetting<TValue> extends AppSetting {
  final Widget? dialogContent;
  final TValue value;
  final Function()? callback;
  final Future<void> Function(BuildContext context, WidgetRef ref)? onTap;

  const DialogAppSetting({
    super.key,
    required super.feature,
    required super.displayText,
    this.dialogContent,
    required this.value,
    this.callback,
    this.onTap,
  });

  @override
  Widget buildSetting(BuildContext context, WidgetRef ref) {
    assert(
      onTap != null || dialogContent != null,
      'DialogAppSetting requires onTap or dialogContent.',
    );
    return _DialogCloseListener(
      onTap: () => onTap == null ? _showDialog(context) : onTap!(context, ref),
      callback: callback,
      child: ListTile(title: Text(displayText)),
    );
  }

  Future<void> _showDialog(BuildContext context) async {
    if (dialogContent == null) {
      return;
    }
    await showDialog(context: context, builder: (_) => dialogContent!);
  }
}

class _DialogCloseListener extends StatelessWidget {
  final Widget child;
  final Future<void> Function()? onTap;
  final VoidCallback? callback;

  const _DialogCloseListener({required this.child, this.onTap, this.callback});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap == null
          ? null
          : () async {
              await onTap!();
              callback?.call();
            },
      child: child,
    );
  }
}
