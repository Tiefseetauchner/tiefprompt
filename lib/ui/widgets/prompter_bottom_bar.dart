import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/providers/prompter_provider.dart';
import 'package:tiefprompt/providers/settings_provider.dart';

final fontSettingsVisibleProvider = StateProvider<bool>((ref) => false);
final displaySettingsVisibleProvider = StateProvider<bool>((ref) => false);

class PrompterBottomBar extends ConsumerWidget {
  const PrompterBottomBar({
    super.key,
  });

  List<Widget> _getWidgetButtons(
      BuildContext context, WidgetRef ref, PrompterState prompterState) {
    final fontSettingsVisible = ref.watch(fontSettingsVisibleProvider);
    final displaySettingsVisible = ref.watch(displaySettingsVisibleProvider);

    return [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          VerticalDivider(
            width: 50,
          ),
          IconButton(
            icon: Icon(Icons.save,
                color: Theme.of(context).colorScheme.onSurface),
            tooltip: context.tr("PrompterScreen.IconButton_Save"),
            onPressed: () => ref
                .read(settingsProvider.notifier)
                .applySettingsFromPrompter(prompterState),
          ),
          VerticalDivider(
            width: 15,
          ),
        ],
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          VerticalDivider(
            width: 15,
          ),
          IconButton(
            icon: Icon(Icons.display_settings,
                color: Theme.of(context).colorScheme.onSurface),
            tooltip: context.tr("PrompterScreen.IconButton_DisplaySettings"),
            onPressed: () => ref
                .read(displaySettingsVisibleProvider.notifier)
                .state = !displaySettingsVisible,
          ),
          VerticalDivider(
            width: 15,
          ),
        ],
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          VerticalDivider(
            width: 15,
          ),
          IconButton(
            icon: Icon(Icons.remove,
                color: Theme.of(context).colorScheme.onSurface),
            tooltip: context.tr("PrompterScreen.IconButton_DecreaseSpeed"),
            onPressed: () =>
                ref.read(prompterProvider.notifier).decreaseSpeed(.1),
          ),
          IconButton(
            icon: Icon(prompterState.isPlaying ? Icons.pause : Icons.play_arrow,
                color: Theme.of(context).colorScheme.onSurface),
            tooltip: context.tr("PrompterScreen.IconButton_TogglePlayPause"),
            onPressed: () =>
                ref.read(prompterProvider.notifier).togglePlayPause(),
          ),
          IconButton(
            icon:
                Icon(Icons.add, color: Theme.of(context).colorScheme.onSurface),
            tooltip: context.tr("PrompterScreen.IconButton_IncreaseSpeed"),
            onPressed: () =>
                ref.read(prompterProvider.notifier).increaseSpeed(.1),
          ),
          VerticalDivider(
            width: 15,
          ),
        ],
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          VerticalDivider(
            width: 15,
          ),
          IconButton(
            icon: Icon(Icons.text_format,
                color: Theme.of(context).colorScheme.onSurface),
            tooltip: context.tr("PrompterScreen.IconButton_TextFormat"),
            onPressed: () => ref
                .read(fontSettingsVisibleProvider.notifier)
                .state = !fontSettingsVisible,
          ),
          VerticalDivider(
            width: 15,
          ),
        ],
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          VerticalDivider(
            width: 15,
          ),
          IconButton(
            icon: Icon(Icons.settings,
                color: Theme.of(context).colorScheme.onSurface),
            tooltip: context.tr("PrompterScreen.IconButton_Settings"),
            onPressed: () => context.push("/settings"),
          ),
          VerticalDivider(
            width: 50,
          ),
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
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
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
                        context.tr("PrompterScreen.speed",
                            args: [prompterState.speed.toStringAsFixed(1)]),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface),
                      ),
                      Text(
                        context.tr("PrompterScreen.fontsize",
                            args: [prompterState.fontSize.toStringAsFixed(1)]),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface),
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

    return Theme(
      data: ThemeData.dark(),
      child: SimpleDialog(
        title: Text(context.tr("PrompterScreen.SimpleDialog_TextFormat.title"),
            style: TextStyle(fontSize: 18)),
        alignment: Alignment(1, 0),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      context.tr(
                          "PrompterScreen.SimpleDialog_TextFormat.fontsize",
                          args: [prompter.fontSize.toStringAsFixed(1)]),
                    ),
                    IconButton(
                      icon: Icon(Icons.text_increase),
                      tooltip: context.tr(
                          "PrompterScreen.SimpleDialog_TextFormat.IconButton_TextIncrease"),
                      onPressed: () => ref
                          .read(prompterProvider.notifier)
                          .increaseFontSize(20),
                    ),
                    IconButton(
                      icon: Icon(Icons.text_decrease),
                      tooltip: context.tr(
                          "PrompterScreen.SimpleDialog_TextFormat.IconButton_TextDecrease"),
                      onPressed: () => ref
                          .read(prompterProvider.notifier)
                          .decreaseFontSize(20),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.format_align_left),
                      tooltip: context.tr(
                          "PrompterScreen.SimpleDialog_TextFormat.IconButton_Left"),
                      onPressed: () => ref
                          .read(prompterProvider.notifier)
                          .setAlignment(TextAlign.left),
                    ),
                    IconButton(
                      icon: Icon(Icons.format_align_center),
                      tooltip: context.tr(
                          "PrompterScreen.SimpleDialog_TextFormat.IconButton_Center"),
                      onPressed: () => ref
                          .read(prompterProvider.notifier)
                          .setAlignment(TextAlign.center),
                    ),
                    IconButton(
                      icon: Icon(Icons.format_align_right),
                      tooltip: context.tr(
                          "PrompterScreen.SimpleDialog_TextFormat.IconButton_Right"),
                      onPressed: () => ref
                          .read(prompterProvider.notifier)
                          .setAlignment(TextAlign.right),
                    ),
                    IconButton(
                      icon: Icon(Icons.format_align_justify),
                      tooltip: context.tr(
                          "PrompterScreen.SimpleDialog_TextFormat.IconButton_Justified"),
                      onPressed: () => ref
                          .read(prompterProvider.notifier)
                          .setAlignment(TextAlign.justify),
                    ),
                  ],
                ),
                Row(
                  children: [
                    DropdownButton(
                      value: prompter.fontFamily,
                      items: kAvailableFonts
                          .map((font) => DropdownMenuItem(
                                value: font,
                                child: Text(font),
                              ))
                          .toList(),
                      onChanged: (value) => ref
                          .read(prompterProvider.notifier)
                          .setFontFamily(value ?? 'Roboto'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DisplaySettingsDialog extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prompter = ref.watch(prompterProvider);

    return Theme(
      data: ThemeData.dark(),
      child: SimpleDialog(
        title: Text(
            context.tr("PrompterScreen.SimpleDialog_DisplaySettings.title"),
            style: TextStyle(fontSize: 18)),
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
                        IconButton(
                          icon: Icon(Icons.flip),
                          isSelected: prompter.mirroredX,
                          tooltip: context.tr(
                              "PrompterScreen.SimpleDialog_DisplaySettings.IconButton_FlipX"),
                          onPressed: () => ref
                              .read(prompterProvider.notifier)
                              .toggleMirroredX(),
                        ),
                        IconButton(
                          isSelected: prompter.mirroredY,
                          icon: RotatedBox(
                              quarterTurns: 1, child: Icon(Icons.flip)),
                          tooltip: context.tr(
                              "PrompterScreen.SimpleDialog_DisplaySettings.IconButton_FlipY"),
                          onPressed: () => ref
                              .read(prompterProvider.notifier)
                              .toggleMirroredY(),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.indeterminate_check_box_outlined),
                          isSelected: prompter.displayReadingIndicatorBoxes,
                          tooltip: context.tr(
                              "PrompterScreen.SimpleDialog_DisplaySettings.IconButton_ReadingIndicatorBoxes"),
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
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.margin),
                          isSelected: prompter.displayVerticalMarginBoxes,
                          tooltip: context.tr(
                              "PrompterScreen.SimpleDialog_DisplaySettings.IconButton_VerticalMarginBoxes"),
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
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.gradient),
                          tooltip: context.tr(
                              "PrompterScreen.SimpleDialog_DisplaySettings.IconButton_FadeEnabled"),
                          isSelected: prompter.verticalMarginBoxesFadeEnabled,
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
                    Row(
                      children: [
                        Text(
                          context.tr(
                              "PrompterScreen.SimpleDialog_DisplaySettings.Slider_SideMargin"),
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
                    Row(
                      children: [
                        Text(
                          context.tr(
                              "PrompterScreen.SimpleDialog_DisplaySettings.Slider_Countdown"),
                        ),
                        Slider(
                          value: prompter.countdownDuration,
                          min: 0,
                          max: 60,
                          divisions: 60,
                          label: prompter.countdownDuration.toStringAsFixed(0),
                          onChanged: (value) => ref
                              .read(prompterProvider.notifier)
                              .setCountdownDuration(value),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
