import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
                      .setScrollSpeed(updatedValue)),
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
            ],
          ),
        ),
      AsyncError(:final error) => Center(
          child: Text(error.toString()),
        ),
      _ => Center(
          child: Text("An Error occured"),
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
    );
  }
}

class NumberAppSetting extends StatelessWidget {
  const NumberAppSetting({
    super.key,
    required this.value,
    required this.displayText,
    required this.onValueChanged,
  });

  final int value;
  final String displayText;
  final Function(int) onValueChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(displayText),
      trailing: SizedBox(
        width: MediaQuery.of(context).textScaler.scale(60),
        child: TextField(
          controller: TextEditingController(text: value.toString()),
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          onChanged: (value) {
            final valueInt = int.tryParse(value);

            if (valueInt != null) {
              onValueChanged(valueInt);
            }
          },
        ),
      ),
    );
  }
}
