import 'package:flutter/material.dart';
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
                value: value.scrollSpeed + 0.0,
                displayText: "Default Scroll Speed",
                onValueChanged: (updatedValue) => ref
                    .read(settingsProvider.notifier)
                    .setScrollSpeed(updatedValue.floor()),
                min: kPrompterMinSpeed + 0.0,
                max: kPrompterMaxSpeed + 0.0,
                stepSize: 1,
              ),
              NumberAppSetting(
                value: value.fontSize,
                displayText: "Default Font Size",
                onValueChanged: (updatedValue) => ref
                    .read(settingsProvider.notifier)
                    .setFontSize(updatedValue),
                min: kPrompterMinFontSize,
                max: kPrompterMaxFontSize,
              ),
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
              NumberAppSetting(
                value: value.sideMargin,
                displayText: "Side Margin",
                onValueChanged: (updatedValue) => ref
                    .read(settingsProvider.notifier)
                    .setSideMargin(updatedValue),
                min: kPrompterMinSideMargin,
                max: kPrompterMaxSideMargin,
              ),
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

class NumberAppSetting extends StatelessWidget {
  const NumberAppSetting({
    super.key,
    required this.value,
    required this.displayText,
    required this.onValueChanged,
    required this.min,
    required this.max,
    this.stepSize,
  });

  final double value;
  final String displayText;
  final Function(double) onValueChanged;
  final double min;
  final double max;
  final double? stepSize;

  void _showDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        double tempValue = value.clamp(min, max);
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(displayText, style: TextStyle(fontSize: 18)),
                  Text(tempValue.toStringAsFixed(1),
                      style: TextStyle(fontSize: 12)),
                  Slider(
                    value: tempValue,
                    min: min,
                    max: max,
                    divisions: stepSize == null
                        ? null
                        : ((max - min) / stepSize!).floor(),
                    label: tempValue.toStringAsFixed(1),
                    onChanged: (value) {
                      setSheetState(() {
                        tempValue = value;
                      });
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      onValueChanged(tempValue);
                      Navigator.pop(context);
                    },
                    child: Text("Save"),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(displayText),
      trailing: Icon(Icons.chevron_right),
      subtitle: Text(value.toStringAsFixed(1)),
      onTap: () {
        _showDialog(context);
      },
    );
  }
}
