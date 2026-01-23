import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/providers/feature_provider.dart';
import 'package:tiefprompt/providers/prompter_provider.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/providers/theme_provider.dart';

final fontSettingsVisibleProvider = StateProvider<bool>((ref) => false);
final displaySettingsVisibleProvider = StateProvider<bool>((ref) => false);

class PrompterBottomBar extends ConsumerWidget {
  const PrompterBottomBar({super.key});

  List<Widget> _getWidgetButtons(
    BuildContext context,
    WidgetRef ref,
    PrompterState prompterState,
  ) {
    final fontSettingsVisible = ref.watch(fontSettingsVisibleProvider);
    final displaySettingsVisible = ref.watch(displaySettingsVisibleProvider);

    return [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          VerticalDivider(width: 50),
          IconButton(
            icon: Icon(
              Icons.save,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            tooltip: context.tr("PrompterScreen.IconButton_Save"),
            onPressed: () => ref
                .read(settingsProvider.notifier)
                .applySettingsFromPrompter(prompterState),
          ),
          VerticalDivider(width: 15),
        ],
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          VerticalDivider(width: 15),
          _FeatureGatedIconButton(
            feature: Feature.displaySettings,
            displayText: context.tr(
              "PrompterScreen.IconButton_DisplaySettings",
            ),
            icon: Icon(
              Icons.display_settings,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            tooltip: context.tr("PrompterScreen.IconButton_DisplaySettings"),
            onPressed: () =>
                ref.read(displaySettingsVisibleProvider.notifier).state =
                    !displaySettingsVisible,
          ),
          VerticalDivider(width: 15),
        ],
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          VerticalDivider(width: 15),
          _FeatureGatedIconButton(
            feature: Feature.scrollSpeed,
            displayText: context.tr("PrompterScreen.IconButton_DecreaseSpeed"),
            icon: Icon(
              Icons.remove,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            tooltip: context.tr("PrompterScreen.IconButton_DecreaseSpeed"),
            onPressed: () =>
                ref.read(prompterProvider.notifier).decreaseSpeed(.1),
          ),
          _FeatureGatedIconButton(
            feature: Feature.playPause,
            displayText: context.tr(
              "PrompterScreen.IconButton_TogglePlayPause",
            ),
            icon: Icon(
              prompterState.isPlaying ? Icons.pause : Icons.play_arrow,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            tooltip: context.tr("PrompterScreen.IconButton_TogglePlayPause"),
            onPressed: () =>
                ref.read(prompterProvider.notifier).togglePlayPause(),
          ),
          _FeatureGatedIconButton(
            feature: Feature.scrollSpeed,
            displayText: context.tr("PrompterScreen.IconButton_IncreaseSpeed"),
            icon: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            tooltip: context.tr("PrompterScreen.IconButton_IncreaseSpeed"),
            onPressed: () =>
                ref.read(prompterProvider.notifier).increaseSpeed(.1),
          ),
          VerticalDivider(width: 15),
        ],
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          VerticalDivider(width: 15),
          _FeatureGatedIconButton(
            feature: Feature.textSettings,
            displayText: context.tr("PrompterScreen.IconButton_TextFormat"),
            icon: Icon(
              Icons.text_format,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            tooltip: context.tr("PrompterScreen.IconButton_TextFormat"),
            onPressed: () =>
                ref.read(fontSettingsVisibleProvider.notifier).state =
                    !fontSettingsVisible,
          ),
          VerticalDivider(width: 15),
        ],
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          VerticalDivider(width: 15),
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            tooltip: context.tr("PrompterScreen.IconButton_Settings"),
            onPressed: () => context.push("/settings"),
          ),
          VerticalDivider(width: 50),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prompterState = ref.watch(prompterProvider);
    final fontSettingsVisible = ref.watch(fontSettingsVisibleProvider);
    final displaySettingsVisible = ref.watch(displaySettingsVisibleProvider);

    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurface.withAlpha(120),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 16.0,
            ),
            child: Stack(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _getWidgetButtons(context, ref, prompterState),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Column(
                    children: [
                      Text(
                        context.tr(
                          "PrompterScreen.speed",
                          args: [prompterState.speed.toStringAsFixed(1)],
                        ),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        context.tr(
                          "PrompterScreen.fontsize",
                          args: [prompterState.fontSize.toStringAsFixed(1)],
                        ),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (fontSettingsVisible) _FontSettingsDialog(),
        if (displaySettingsVisible) _DisplaySettingsDialog(),
      ],
    );
  }
}

class _FontSettingsDialog extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prompter = ref.watch(prompterProvider);
    final themes = ref.watch(themesProvider);

    return switch (themes) {
      AsyncData(:final value) => Theme(
        data: value.darkTheme,
        child: SimpleDialog(
          title: Text(
            context.tr("PrompterScreen.SimpleDialog_TextFormat.title"),
            style: TextStyle(fontSize: 18),
          ),
          alignment: Alignment(1, 0),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _FeatureGate(
                    feature: Feature.fontSize,
                    displayText: context.tr(
                      "SettingsScreen.NumberAppSetting_DefaultFontSize",
                    ),
                    child: Row(
                      children: [
                        Text(
                          context.tr(
                            "PrompterScreen.SimpleDialog_TextFormat.fontsize",
                            args: [prompter.fontSize.toStringAsFixed(1)],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.text_increase),
                          tooltip: context.tr(
                            "PrompterScreen.SimpleDialog_TextFormat.IconButton_TextIncrease",
                          ),
                          onPressed: () => ref
                              .read(prompterProvider.notifier)
                              .increaseFontSize(2),
                        ),
                        IconButton(
                          icon: Icon(Icons.text_decrease),
                          tooltip: context.tr(
                            "PrompterScreen.SimpleDialog_TextFormat.IconButton_TextDecrease",
                          ),
                          onPressed: () => ref
                              .read(prompterProvider.notifier)
                              .decreaseFontSize(2),
                        ),
                      ],
                    ),
                  ),
                  _FeatureGate(
                    feature: Feature.textAlignment,
                    displayText: context.tr(
                      "SettingsScreen.DropdownAppSetting_DefaultTextAlignment",
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.format_align_left),
                          tooltip: context.tr(
                            "PrompterScreen.SimpleDialog_TextFormat.IconButton_Left",
                          ),
                          onPressed: () => ref
                              .read(prompterProvider.notifier)
                              .setAlignment(TextAlign.left),
                        ),
                        IconButton(
                          icon: Icon(Icons.format_align_center),
                          tooltip: context.tr(
                            "PrompterScreen.SimpleDialog_TextFormat.IconButton_Center",
                          ),
                          onPressed: () => ref
                              .read(prompterProvider.notifier)
                              .setAlignment(TextAlign.center),
                        ),
                        IconButton(
                          icon: Icon(Icons.format_align_right),
                          tooltip: context.tr(
                            "PrompterScreen.SimpleDialog_TextFormat.IconButton_Right",
                          ),
                          onPressed: () => ref
                              .read(prompterProvider.notifier)
                              .setAlignment(TextAlign.right),
                        ),
                        IconButton(
                          icon: Icon(Icons.format_align_justify),
                          tooltip: context.tr(
                            "PrompterScreen.SimpleDialog_TextFormat.IconButton_Justified",
                          ),
                          onPressed: () => ref
                              .read(prompterProvider.notifier)
                              .setAlignment(TextAlign.justify),
                        ),
                      ],
                    ),
                  ),
                  _FeatureGate(
                    feature: Feature.fontFamily,
                    displayText: context.tr(
                      "SettingsScreen.DropdownAppSetting_DefaultFontFamily",
                    ),
                    child: Row(
                      children: [
                        DropdownButton(
                          value: prompter.fontFamily,
                          items: kAvailableFonts
                              .map(
                                (font) => DropdownMenuItem(
                                  value: font,
                                  child: Text(font),
                                ),
                              )
                              .toList(),
                          onChanged: (value) => ref
                              .read(prompterProvider.notifier)
                              .setFontFamily(value ?? 'Roboto'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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

class _DisplaySettingsDialog extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prompter = ref.watch(prompterProvider);
    final themes = ref.watch(themesProvider);

    return switch (themes) {
      AsyncData(:final value) => Theme(
        data: value.darkTheme,
        child: SimpleDialog(
          title: Text(
            context.tr("PrompterScreen.SimpleDialog_DisplaySettings.title"),
            style: TextStyle(fontSize: 18),
          ),
          alignment: Alignment(-1, 0),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 250,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          _FeatureGatedIconButton(
                            feature: Feature.flipX,
                            displayText: context.tr(
                              "SettingsScreen.BooleanAppSetting_DefaultFlipX",
                            ),
                            icon: Icon(Icons.flip),
                            isSelected: prompter.mirroredX,
                            tooltip: context.tr(
                              "PrompterScreen.SimpleDialog_DisplaySettings.IconButton_FlipX",
                            ),
                            onPressed: () => ref
                                .read(prompterProvider.notifier)
                                .toggleMirroredX(),
                          ),
                          _FeatureGatedIconButton(
                            feature: Feature.flipY,
                            displayText: context.tr(
                              "SettingsScreen.BooleanAppSetting_DefaultFlipY",
                            ),
                            icon: RotatedBox(
                              quarterTurns: 1,
                              child: Icon(Icons.flip),
                            ),
                            isSelected: prompter.mirroredY,
                            tooltip: context.tr(
                              "PrompterScreen.SimpleDialog_DisplaySettings.IconButton_FlipY",
                            ),
                            onPressed: () => ref
                                .read(prompterProvider.notifier)
                                .toggleMirroredY(),
                          ),
                        ],
                      ),
                      _FeatureGate(
                        feature: Feature.readingIndicatorBoxes,
                        displayText: context.tr(
                          "SettingsScreen.BooleanAppSetting_ReadingIndicatorBoxes",
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.indeterminate_check_box_outlined,
                              ),
                              isSelected: prompter.displayReadingIndicatorBoxes,
                              tooltip: context.tr(
                                "PrompterScreen.SimpleDialog_DisplaySettings.IconButton_ReadingIndicatorBoxes",
                              ),
                              onPressed: () => ref
                                  .read(prompterProvider.notifier)
                                  .toggleDisplayReadingIndicatorBoxes(),
                            ),
                            Slider(
                              value: prompter.readingIndicatorBoxesHeight,
                              min: 0.0,
                              max: 100.0,
                              divisions: 20,
                              label: prompter.readingIndicatorBoxesHeight
                                  .toStringAsFixed(2),
                              onChanged: (value) => ref
                                  .read(prompterProvider.notifier)
                                  .setReadingIndicatorBoxHeight(value),
                            ),
                          ],
                        ),
                      ),
                      _FeatureGate(
                        feature: Feature.verticalMargins,
                        displayText: context.tr(
                          "SettingsScreen.BooleanAppSetting_VerticalMarginBoxes",
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.margin),
                              isSelected: prompter.displayVerticalMarginBoxes,
                              tooltip: context.tr(
                                "PrompterScreen.SimpleDialog_DisplaySettings.IconButton_VerticalMarginBoxes",
                              ),
                              onPressed: () => ref
                                  .read(prompterProvider.notifier)
                                  .toggleDisplayVerticalMarginBoxes(),
                            ),
                            Slider(
                              value: prompter.verticalMarginBoxesHeight,
                              min: 0.0,
                              max: 100.0,
                              divisions: 20,
                              label: prompter.verticalMarginBoxesHeight
                                  .toStringAsFixed(2),
                              onChanged: (value) => ref
                                  .read(prompterProvider.notifier)
                                  .setVerticalMarginBoxHeight(value),
                            ),
                          ],
                        ),
                      ),
                      if (prompter.displayVerticalMarginBoxes)
                        _FeatureGate(
                          feature: Feature.verticalMarginFade,
                          displayText: context.tr(
                            "SettingsScreen.BooleanAppSetting_VerticalMarginBoxes_FadeEnabled",
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.gradient),
                                tooltip: context.tr(
                                  "PrompterScreen.SimpleDialog_DisplaySettings.IconButton_FadeEnabled",
                                ),
                                isSelected:
                                    prompter.verticalMarginBoxesFadeEnabled,
                                onPressed: () => ref
                                    .read(prompterProvider.notifier)
                                    .toggleVerticalMarginBoxesFadeEnabled(),
                              ),
                              Slider(
                                value: prompter.verticalMarginBoxesFadeLength,
                                min: 0.0,
                                max: 100,
                                divisions: 20,
                                label: prompter.verticalMarginBoxesFadeLength
                                    .toStringAsFixed(2),
                                onChanged: (value) => ref
                                    .read(prompterProvider.notifier)
                                    .setVerticalMarginBoxesFadeLength(value),
                              ),
                            ],
                          ),
                        ),
                      _FeatureGate(
                        feature: Feature.sideMargins,
                        displayText: context.tr(
                          "SettingsScreen.NumberAppSetting_SideMargin",
                        ),
                        child: Row(
                          children: [
                            Text(
                              context.tr(
                                "PrompterScreen.SimpleDialog_DisplaySettings.Slider_SideMargin",
                              ),
                            ),
                            Slider(
                              value: prompter.sideMargin,
                              min: 0,
                              max: 100,
                              divisions: 100,
                              label: prompter.sideMargin.toStringAsFixed(2),
                              onChanged: (value) => ref
                                  .read(prompterProvider.notifier)
                                  .setSideMargin(value),
                            ),
                          ],
                        ),
                      ),
                      _FeatureGate(
                        feature: Feature.countdownTimer,
                        displayText: context.tr(
                          "SettingsScreen.NumberAppSetting_CountdownTimer",
                        ),
                        child: Row(
                          children: [
                            Text(
                              context.tr(
                                "PrompterScreen.SimpleDialog_DisplaySettings.Slider_Countdown",
                              ),
                            ),
                            Slider(
                              value: prompter.countdownDuration,
                              min: 0,
                              max: 60,
                              divisions: 60,
                              label: prompter.countdownDuration.toStringAsFixed(
                                0,
                              ),
                              onChanged: (value) => ref
                                  .read(prompterProvider.notifier)
                                  .setCountdownDuration(value),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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

class _FeatureGate extends ConsumerWidget {
  const _FeatureGate({
    required this.feature,
    required this.displayText,
    required this.child,
  });

  final Feature feature;
  final String displayText;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEnabled = ref.watch(
      featuresProvider.select((s) => s.features.contains(feature)),
    );

    if (!isEnabled) {
      return _FeatureDisabledInline(displayText: displayText);
    }

    return child;
  }
}

class _FeatureDisabledInline extends ConsumerWidget {
  const _FeatureDisabledInline({required this.displayText});

  final String displayText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: Icon(Icons.lock_outline),
      tileColor: Colors.blueGrey.withAlpha(30),
      title: Text(displayText),
      subtitle: Text(context.tr("ProFeatureDisabled")),
      onTap: () => ref.read(featuresProvider.notifier).buyPro(),
    );
  }
}

class _FeatureGatedIconButton extends ConsumerWidget {
  const _FeatureGatedIconButton({
    required this.feature,
    required this.displayText,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.isSelected,
  });

  final Feature feature;
  final String displayText;
  final Widget icon;
  final String tooltip;
  final VoidCallback onPressed;
  final bool? isSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEnabled = ref.watch(
      featuresProvider.select((s) => s.features.contains(feature)),
    );

    if (isEnabled) {
      return IconButton(
        icon: icon,
        isSelected: isSelected,
        tooltip: tooltip,
        onPressed: onPressed,
      );
    }

    return IconButton(
      icon: Icon(Icons.lock_outline),
      tooltip: "$displayText: ${context.tr("ProFeatureDisabled")}",
      onPressed: () => ref.read(featuresProvider.notifier).buyPro(),
    );
  }
}
