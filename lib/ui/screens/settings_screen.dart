import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/providers/feature_provider.dart';
import 'package:tiefprompt/providers/settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return switch (settings) {
      AsyncData(:final value) => Scaffold(
        appBar: AppBar(title: Text(context.tr("SettingsScreen.title"))),
        body: ListView(
          children: [
            DropdownAppSetting<Locale>(
              feature: Feature.appLanguage,
              value: context.locale,
              displayText: context.tr(
                "SettingsScreen.DropdownAppSetting_DefaultLanguage",
              ),
              onValueChanged: (updatedValue) {
                context.setLocale(updatedValue);
              },
              values: kSupportedLocales,
            ),
            LinkAppSetting(
              displayText: context.tr("SettingsScreen.DisplaySettings"),
              value: "display",
            ),
            LinkAppSetting(
              displayText: context.tr("SettingsScreen.TextSettings"),
              value: "text",
            ),
            DropdownAppSetting<ThemeMode>(
              feature: Feature.appTheme,
              value: value.themeMode,
              displayText: context.tr(
                "SettingsScreen.DropdownAppSetting_Theme",
              ),
              onValueChanged: (updatedValue) {
                ref.read(settingsProvider.notifier).setThemeMode(updatedValue);
              },
              values: ThemeMode.values
                  .map(
                    (mode) => (
                      mode.name[0].toUpperCase() + mode.name.substring(1),
                      mode,
                    ),
                  )
                  .toList(),
            ),
            ColorAppSetting(
              feature: Feature.primaryAppColor,
              value: value.appPrimaryColor,
              displayText: context.tr(
                "SettingsScreen.ColorAppSetting_AppPrimaryColor",
              ),
              onValueChanged: (updatedValue) => ref
                  .read(settingsProvider.notifier)
                  .setAppPrimaryColor(updatedValue),
            ),
            ListTile(
              hoverColor: const Color.fromARGB(255, 255, 175, 169),
              title: Text(context.tr("SettingsScreen.ListTile_Reset")),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(context.tr("SettingsScreen.Reset_Warning")),
                    icon: Icon(
                      Icons.warning_amber_rounded,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () => context.pop(),
                        child: Text(context.tr("SettingsScreen.Abort")),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.error,
                          foregroundColor: Theme.of(
                            context,
                          ).colorScheme.onError,
                        ),
                        onPressed: () {
                          ref.read(settingsProvider.notifier).resetSettings();
                          context.pop();
                        },
                        child: Text(context.tr("SettingsScreen.Confirm")),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      _ => Center(
        child: Column(
          children: [
            Text(
              "An error occurred loading the settings. Do you want to reset them?",
            ),
            ElevatedButton(
              onPressed: () =>
                  ref.read(settingsProvider.notifier).resetSettings(),
              child: Text("Reset Settings"),
            ),
          ],
        ),
      ),
    };
  }
}

class DisplaySettingsScreen extends ConsumerWidget {
  const DisplaySettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return switch (settings) {
      AsyncData(:final value) => Scaffold(
        appBar: AppBar(
          title: Text(context.tr("SettingsScreen.DisplaySettings")),
        ),
        body: ListView(
          children: [
            NumberAppSetting(
              feature: Feature.scrollSpeed,
              value: value.scrollSpeed,
              displayText: context.tr(
                "SettingsScreen.NumberAppSetting_DefaultScrollSpeed",
              ),
              onValueChanged: (updatedValue) => ref
                  .read(settingsProvider.notifier)
                  .setScrollSpeed(updatedValue),
              min: kPrompterMinSpeed,
              max: kPrompterMaxSpeed,
              stepSize: .1,
              unit: context.tr(
                "SettingsScreen.NumberAppSetting_DefaultScrollSpeed_Unit",
              ),
            ),
            BooleanAppSetting(
              feature: Feature.flipX,
              value: value.mirroredX,
              displayText: context.tr(
                "SettingsScreen.BooleanAppSetting_DefaultFlipX",
              ),
              onValueChanged: (updatedValue) => ref
                  .read(settingsProvider.notifier)
                  .setMirroredX(updatedValue),
            ),
            BooleanAppSetting(
              feature: Feature.flipY,
              value: value.mirroredY,
              displayText: context.tr(
                "SettingsScreen.BooleanAppSetting_DefaultFlipY",
              ),
              onValueChanged: (updatedValue) => ref
                  .read(settingsProvider.notifier)
                  .setMirroredY(updatedValue),
            ),
            BooleanAppSetting(
              feature: Feature.readingIndicatorBoxes,
              value: value.displayReadingIndicatorBoxes,
              displayText: context.tr(
                "SettingsScreen.BooleanAppSetting_ReadingIndicatorBoxes",
              ),
              onValueChanged: (updatedValue) => ref
                  .read(settingsProvider.notifier)
                  .setDisplayReadingIndicatorBoxes(updatedValue),
            ),
            NumberAppSetting(
              feature: Feature.readingIndicatorBoxes,
              value: value.readingIndicatorBoxesHeight,
              displayText: context.tr(
                "SettingsScreen.NumberAppSetting_ReadingIndicatorBoxes",
              ),
              onValueChanged: (updatedValue) => ref
                  .read(settingsProvider.notifier)
                  .setReadingIndicatorBoxesHeight(updatedValue),
              min: 0,
              max: 100,
              stepSize: 5,
              unit: context.tr(
                "SettingsScreen.NumberAppSetting_ReadingIndicatorBoxes_Unit",
              ),
            ),
            BooleanAppSetting(
              feature: Feature.verticalMargins,
              value: value.displayVerticalMarginBoxes,
              displayText: context.tr(
                "SettingsScreen.BooleanAppSetting_VerticalMarginBoxes",
              ),
              onValueChanged: (updatedValue) => ref
                  .read(settingsProvider.notifier)
                  .setDisplayVerticalMarginBoxes(updatedValue),
            ),
            NumberAppSetting(
              feature: Feature.verticalMargins,
              value: value.verticalMarginBoxesHeight,
              displayText: context.tr(
                "SettingsScreen.NumberAppSetting_VerticalMarginBoxes",
              ),
              onValueChanged: (updatedValue) => ref
                  .read(settingsProvider.notifier)
                  .setVerticalMarginBoxesHeight(updatedValue),
              min: 0,
              max: 100,
              stepSize: 5,
              unit: context.tr(
                "SettingsScreen.NumberAppSetting_VerticalMarginBoxes_Unit",
              ),
            ),
            BooleanAppSetting(
              feature: Feature.verticalMarginFade,
              value: value.verticalMarginBoxesFadeEnabled,
              displayText: context.tr(
                "SettingsScreen.BooleanAppSetting_VerticalMarginBoxes_FadeEnabled",
              ),
              onValueChanged: (updatedValue) => ref
                  .read(settingsProvider.notifier)
                  .setVerticalMarginBoxesFadeEnabled(updatedValue),
            ),
            NumberAppSetting(
              feature: Feature.verticalMarginFade,
              value: value.verticalMarginBoxesFadeLength,
              displayText: context.tr(
                "SettingsScreen.NumberAppSetting_VerticalMarginBoxes_FadeLength",
              ),
              onValueChanged: (updatedValue) => ref
                  .read(settingsProvider.notifier)
                  .setVerticalMarginBoxesFadeLength(updatedValue),
              min: 0,
              max: 100,
              stepSize: 20,
              unit: context.tr(
                "SettingsScreen.NumberAppSetting_VerticalMarginBoxes_FadeLength_Unit",
              ),
            ),
            NumberAppSetting(
              feature: Feature.sideMargins,
              value: value.sideMargin,
              displayText: context.tr(
                "SettingsScreen.NumberAppSetting_SideMargin",
              ),
              onValueChanged: (updatedValue) => ref
                  .read(settingsProvider.notifier)
                  .setSideMargin(updatedValue),
              min: kPrompterMinSideMargin,
              max: kPrompterMaxSideMargin,
              unit: context.tr(
                "SettingsScreen.NumberAppSetting_SideMargin_Unit",
              ),
            ),
            NumberAppSetting(
              feature: Feature.countdownTimer,
              value: value.countdownDuration,
              displayText: context.tr(
                "SettingsScreen.NumberAppSetting_CountdownTimer",
              ),
              onValueChanged: (updatedValue) => ref
                  .read(settingsProvider.notifier)
                  .setCountdownDuration(updatedValue),
              min: 0,
              max: 60,
              stepSize: 1,
              unit: context.tr(
                "SettingsScreen.NumberAppSetting_CountdownTimer_Unit",
              ),
            ),
            ColorAppSetting(
              feature: Feature.prompterBackgroundColor,
              value: value.prompterBackgroundColor,
              displayText: context.tr(
                "SettingsScreen.ColorAppSetting_PrompterBackgroundColor",
              ),
              onValueChanged: (updatedValue) => ref
                  .read(settingsProvider.notifier)
                  .setPrompterBackgroundColor(updatedValue),
            ),
            ColorAppSetting(
              feature: Feature.prompterTextColor,
              value: value.prompterTextColor,
              displayText: context.tr(
                "SettingsScreen.ColorAppSetting_PrompterTextColor",
              ),
              onValueChanged: (updatedValue) => ref
                  .read(settingsProvider.notifier)
                  .setPrompterTextColor(updatedValue),
            ),
          ],
        ),
      ),
      _ => Center(
        child: Column(
          children: [
            Text(
              "An error occurred loading the settings. Do you want to reset them?",
            ),
            ElevatedButton(
              onPressed: () =>
                  ref.read(settingsProvider.notifier).resetSettings(),
              child: Text("Reset Settings"),
            ),
          ],
        ),
      ),
    };
  }
}

class TextSettingsScreen extends ConsumerWidget {
  const TextSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return switch (settings) {
      AsyncData(:final value) => Scaffold(
        appBar: AppBar(title: Text(context.tr("SettingsScreen.TextSettings"))),
        body: ListView(
          children: [
            NumberAppSetting(
              feature: Feature.fontSize,
              value: value.fontSize,
              displayText: context.tr(
                "SettingsScreen.NumberAppSetting_DefaultFontSize",
              ),
              onValueChanged: (updatedValue) =>
                  ref.read(settingsProvider.notifier).setFontSize(updatedValue),
              min: kPrompterMinFontSize,
              max: kPrompterMaxFontSize,
              unit: context.tr(
                "SettingsScreen.NumberAppSetting_DefaultFontSize_Unit",
              ),
            ),
            DropdownAppSetting<TextAlign>(
              feature: Feature.textAlignment,
              value: value.alignment,
              displayText: context.tr(
                "SettingsScreen.DropdownAppSetting_DefaultTextAlignment",
              ),
              onValueChanged: (updatedValue) => ref
                  .read(settingsProvider.notifier)
                  .setAlignment(updatedValue),
              values: [
                (
                  context.tr(
                    "SettingsScreen.DropdownAppSetting_DefaultTextAlignment_Unit.Left",
                  ),
                  TextAlign.left,
                ),
                (
                  context.tr(
                    "SettingsScreen.DropdownAppSetting_DefaultTextAlignment_Unit.Center",
                  ),
                  TextAlign.center,
                ),
                (
                  context.tr(
                    "SettingsScreen.DropdownAppSetting_DefaultTextAlignment_Unit.Right",
                  ),
                  TextAlign.right,
                ),
                (
                  context.tr(
                    "SettingsScreen.DropdownAppSetting_DefaultTextAlignment_Unit.Justified",
                  ),
                  TextAlign.justify,
                ),
              ],
            ),
            DropdownAppSetting<String>(
              feature: Feature.fontFamily,
              value: value.fontFamily,
              displayText: context.tr(
                "SettingsScreen.DropdownAppSetting_DefaultFontFamily",
              ),
              onValueChanged: (updatedValue) => ref
                  .read(settingsProvider.notifier)
                  .setFontFamily(updatedValue),
              values: kAvailableFonts.map((e) => (e, e)).toList(),
            ),
          ],
        ),
      ),
      _ => Center(
        child: Column(
          children: [
            Text(
              "An error occurred loading the settings. Do you want to reset them?",
            ),
            ElevatedButton(
              onPressed: () =>
                  ref.read(settingsProvider.notifier).resetSettings(),
              child: Text("Reset Settings"),
            ),
          ],
        ),
      ),
    };
  }
}

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

  // TODO: Show buy box when clicked
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      tileColor: Colors.blueGrey.withAlpha(30),
      title: Text(displayText),
      subtitle: Text(context.tr("SettingsScreen.ProFeatureDisabled")),
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

class LinkAppSetting extends ConsumerWidget {
  const LinkAppSetting({
    super.key,
    required this.displayText,
    required this.value,
  });

  final String value;
  final String displayText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(displayText),
      onTap: () => context.push("/settings/$value"),
    );
  }
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
