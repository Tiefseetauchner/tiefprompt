import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/providers/settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return switch (settings) {
      AsyncData(:final value) => Scaffold(
          appBar: AppBar(title: Text("Settings")),
          body: ListView(
            children: [
              NumberAppSetting(
                value: value.scrollSpeed,
                displayText: "Default Scroll Speed",
                onValueChanged: (updatedValue) => ref
                    .read(settingsProvider.notifier)
                    .setScrollSpeed(updatedValue),
                min: kPrompterMinSpeed,
                max: kPrompterMaxSpeed,
                stepSize: .1,
                unit: "lines/sec",
              ),
              NumberAppSetting(
                value: value.fontSize,
                displayText: "Default Font Size",
                onValueChanged: (updatedValue) => ref
                    .read(settingsProvider.notifier)
                    .setFontSize(updatedValue),
                min: kPrompterMinFontSize,
                max: kPrompterMaxFontSize,
                unit: "px",
              ),
              DropdownAppSetting<TextAlign>(
                  value: value.alignment,
                  displayText: "Text Alignment",
                  onValueChanged: (updatedValue) => ref
                      .read(settingsProvider.notifier)
                      .setAlignment(updatedValue),
                  values: [
                    ("Left", TextAlign.left),
                    ("Center", TextAlign.center),
                    ("Right", TextAlign.right),
                    ("Justified", TextAlign.justify),
                  ]),
              DropdownAppSetting<String>(
                  value: value.fontFamily,
                  displayText: "Font Family",
                  onValueChanged: (updatedValue) => ref
                      .read(settingsProvider.notifier)
                      .setFontFamily(updatedValue),
                  values: kAvailableFonts.map((e) => (e, e)).toList()),
              BooleanAppSetting(
                  value: value.mirroredX,
                  displayText: "Default Flip X",
                  onValueChanged: (updatedValue) => ref
                      .read(settingsProvider.notifier)
                      .setMirroredX(updatedValue)),
              BooleanAppSetting(
                  value: value.mirroredY,
                  displayText: "Default Flip Y",
                  onValueChanged: (updatedValue) => ref
                      .read(settingsProvider.notifier)
                      .setMirroredY(updatedValue)),
              BooleanAppSetting(
                  value: value.displayReadingIndicatorBoxes,
                  displayText: "Display Reading Indicator Boxes",
                  onValueChanged: (updatedValue) => ref
                      .read(settingsProvider.notifier)
                      .setDisplayReadingIndicatorBoxes(updatedValue)),
              NumberAppSetting(
                value: value.readingIndicatorBoxesHeight,
                displayText: "Height of Reading Indicator Boxes",
                onValueChanged: (updatedValue) => ref
                    .read(settingsProvider.notifier)
                    .setReadingIndicatorBoxesHeight(updatedValue),
                min: 0,
                max: 100,
                stepSize: 5,
                unit: "%",
              ),
              NumberAppSetting(
                  value: value.sideMargin,
                  displayText: "Side Margin",
                  onValueChanged: (updatedValue) => ref
                      .read(settingsProvider.notifier)
                      .setSideMargin(updatedValue),
                  min: kPrompterMinSideMargin,
                  max: kPrompterMaxSideMargin,
                  unit: "%"),
              NumberAppSetting(
                  value: value.countdownDuration,
                  displayText: "Countdown Timer",
                  onValueChanged: (updatedValue) => ref
                      .read(settingsProvider.notifier)
                      .setCountdownDuration(updatedValue),
                  min: 0,
                  max: 60,
                  stepSize: 1,
                  unit: "sec"),
              ListTile(
                title: Text("Reset settings"),
                onTap: () {
                  ref.read(settingsProvider.notifier).resetSettings();
                },
              )
            ],
          ),
        ),
      _ => Center(
          child: Column(children: [
            Text(
                "An error occurred loading the settings. Do you want to reset them?"),
            ElevatedButton(
                onPressed: () =>
                    ref.read(settingsProvider.notifier).resetSettings(),
                child: Text("Reset Settings"))
          ]),
        )
    };
  }
}

class DropdownAppSetting<T> extends StatelessWidget {
  final T value;
  final String displayText;
  final Function(T) onValueChanged;
  final List<(String, T)> values;

  const DropdownAppSetting({
    super.key,
    required this.value,
    required this.displayText,
    required this.onValueChanged,
    required this.values,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(displayText),
      trailing: DropdownButton<T>(
        value: value,
        items: values.map((value) {
          return DropdownMenuItem<T>(
            value: value.$2,
            child: Text(value.$1),
          );
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

class BooleanAppSetting extends StatelessWidget {
  const BooleanAppSetting({
    super.key,
    required this.value,
    required this.displayText,
    required this.onValueChanged,
  });

  final bool value;
  final String displayText;
  final Function(bool) onValueChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(displayText),
      trailing: Switch(value: value, onChanged: onValueChanged),
      onTap: () => onValueChanged(!value),
    );
  }
}

class NumberAppSetting extends StatefulWidget {
  const NumberAppSetting({
    super.key,
    required this.value,
    required this.displayText,
    required this.onValueChanged,
    required this.min,
    required this.max,
    this.stepSize,
    this.unit,
  });

  final double value;
  final String displayText;
  final Function(double) onValueChanged;
  final double min;
  final double max;
  final double? stepSize;
  final String? unit;

  @override
  State<NumberAppSetting> createState() => _NumberAppSettingState();
}

class _NumberAppSettingState extends State<NumberAppSetting> {
  double selectedValue = 0;

  @override
  void initState() {
    selectedValue = widget.value;

    super.initState();
  }

  void _showDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
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
                  style: TextStyle(fontSize: 12)),
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
                child: Text("Save"),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$'))
          ],
          onSubmitted: onTextChanged,
          decoration: const InputDecoration(labelText: 'Enter Value'),
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
