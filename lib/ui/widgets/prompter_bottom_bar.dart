import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/core/control_buttons.dart';
import 'package:tiefprompt/core/disabled_feature_screen_state.dart';
import 'package:tiefprompt/providers/feature_provider.dart';
import 'package:tiefprompt/providers/prompter_provider.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/providers/theme_provider.dart';
import 'package:tiefprompt/ui/screens/reset_settings_screen.dart';

class _BoolToggle extends Notifier<bool> {
  _BoolToggle(this._initial);
  final bool _initial;
  @override
  bool build() => _initial;
  void toggle() => state = !state;
}

final fontSettingsVisibleProvider = NotifierProvider<_BoolToggle, bool>(
  () => _BoolToggle(false),
);
final displaySettingsVisibleProvider = NotifierProvider<_BoolToggle, bool>(
  () => _BoolToggle(false),
);

class PrompterBottomBar extends ConsumerWidget {
  const PrompterBottomBar({super.key});

  List<Widget> _getWidgetButtons(BuildContext context, WidgetRef ref) {
    return [
      _ButtonGroup(
        leadingWidth: 50,
        children: [
          IconButton(
            icon: Icon(Icons.save),
            tooltip: context.tr("PrompterScreen.IconButton_Save"),
            onPressed: () => ref
                .read(settingsProvider.notifier)
                .applySettingsFromPrompter(ref.read(prompterProvider)),
          ),
        ],
      ),
      _ButtonGroup(
        children: [
          _FeatureGatedIconButton(
            feature: Feature.displaySettings,
            displayText: context.tr(
              "PrompterScreen.IconButton_DisplaySettings",
            ),
            icon: Icon(Icons.display_settings),
            tooltip: context.tr("PrompterScreen.IconButton_DisplaySettings"),
            onPressed: () =>
                ref.read(displaySettingsVisibleProvider.notifier).toggle(),
          ),
        ],
      ),
      _ButtonGroup(
        children: [
          _FeatureGatedIconButton(
            feature: Feature.scrollSpeed,
            displayText: context.tr("PrompterScreen.IconButton_DecreaseSpeed"),
            icon: Icon(Icons.remove),
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
              ref.watch(prompterProvider).isPlaying
                  ? Icons.pause
                  : Icons.play_arrow,
            ),
            tooltip: context.tr("PrompterScreen.IconButton_TogglePlayPause"),
            onPressed: () =>
                ref.read(prompterProvider.notifier).togglePlayPause(),
          ),
          _FeatureGatedIconButton(
            feature: Feature.scrollSpeed,
            displayText: context.tr("PrompterScreen.IconButton_IncreaseSpeed"),
            icon: Icon(Icons.add),
            tooltip: context.tr("PrompterScreen.IconButton_IncreaseSpeed"),
            onPressed: () =>
                ref.read(prompterProvider.notifier).increaseSpeed(.1),
          ),
        ],
      ),
      _ButtonGroup(
        children: [
          _FeatureGatedIconButton(
            feature: Feature.textSettings,
            displayText: context.tr("PrompterScreen.IconButton_TextFormat"),
            icon: Icon(Icons.text_format),
            tooltip: context.tr("PrompterScreen.IconButton_TextFormat"),
            onPressed: () =>
                ref.read(fontSettingsVisibleProvider.notifier).toggle(),
          ),
        ],
      ),
      _ButtonGroup(
        trailingWidth: 50,
        children: [
          IconButton(
            icon: Icon(Icons.settings),
            tooltip: context.tr("PrompterScreen.IconButton_Settings"),
            onPressed: () => context.push("/settings"),
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (:speed, :fontSize) = ref.watch(
      prompterProvider.select(
        (p) => (speed: p.config.scrollSpeed, fontSize: p.config.fontSize),
      ),
    );
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
            child: SafeArea(
              top: false,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: IconTheme.merge(
                      data: IconThemeData(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: _getWidgetButtons(context, ref),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: Column(
                      children: [
                        Text(
                          context.tr(
                            "PrompterScreen.speed",
                            args: [speed.toStringAsFixed(1)],
                          ),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        Text(
                          context.tr(
                            "PrompterScreen.fontsize",
                            args: [fontSize.toStringAsFixed(1)],
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
        ),
        if (fontSettingsVisible) SafeArea(child: _FontSettingsDialog()),
        if (displaySettingsVisible) SafeArea(child: _DisplaySettingsDialog()),
      ],
    );
  }
}

class _ButtonGroup extends StatelessWidget {
  const _ButtonGroup({
    this.leadingWidth = 15,
    this.trailingWidth = 15,
    required this.children,
  });

  final double leadingWidth;
  final double trailingWidth;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        VerticalDivider(width: leadingWidth),
        ...children,
        VerticalDivider(width: trailingWidth),
      ],
    );
  }
}

class _FontSettingsDialog extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (:fontSize, :fontFamily) = ref.watch(
      prompterProvider.select(
        (p) => (fontSize: p.config.fontSize, fontFamily: p.config.fontFamily),
      ),
    );
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
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height - 160,
          ),
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
                            args: [fontSize.toStringAsFixed(1)],
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
                          value: fontFamily,
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
      AsyncLoading() => Scaffold(
        appBar: AppBar(
          title: Text(context.tr("SettingsScreen.KeybindingsSettings.Title")),
        ),
        body: SpinKitRing(
          color:
              ref.read(settingsProvider).value?.appPrimaryColor ?? kBrandTeal,
        ),
      ),
      _ => const ResetSettingsView(),
    };
  }
}

class _DisplaySettingsDialog extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prompterConfig = ref.watch(prompterProvider.select((p) => p.config));
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
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height - 160,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
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
                            isSelected: prompterConfig.mirroredX,
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
                            isSelected: prompterConfig.mirroredY,
                            tooltip: context.tr(
                              "PrompterScreen.SimpleDialog_DisplaySettings.IconButton_FlipY",
                            ),
                            onPressed: () => ref
                                .read(prompterProvider.notifier)
                                .toggleMirroredY(),
                          ),
                          _FeatureGatedIconButton(
                            feature: Feature.markdown,
                            displayText: context.tr(
                              "SettingsScreen.BooleanAppSetting_Markdown",
                            ),
                            icon: Text(
                              "M",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: prompterConfig.markdownEnabled
                                    ? Theme.of(context).colorScheme.primary
                                    : IconTheme.of(context).color,
                              ),
                            ),
                            isSelected: prompterConfig.markdownEnabled,
                            tooltip: context.tr(
                              "PrompterScreen.SimpleDialog_DisplaySettings.IconButton_Markdown",
                            ),
                            onPressed: () => ref
                                .read(prompterProvider.notifier)
                                .toggleMarkdownEnabled(),
                          ),
                          _FeatureGatedIconButton(
                            feature: Feature.currentChapter,
                            displayText: context.tr(
                              "SettingsScreen.BooleanAppSetting_ShowCurrentChapter",
                            ),
                            icon: Text(
                              "C",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: prompterConfig.markdownEnabled
                                    ? (prompterConfig.showCurrentChapter
                                          ? Theme.of(
                                              context,
                                            ).colorScheme.primary
                                          : IconTheme.of(context).color)
                                    : Theme.of(context).disabledColor,
                              ),
                            ),
                            isSelected: prompterConfig.showCurrentChapter,
                            tooltip: context.tr(
                              "PrompterScreen.SimpleDialog_DisplaySettings.IconButton_ShowCurrentChapter",
                            ),
                            onPressed: prompterConfig.markdownEnabled
                                ? () => ref
                                      .read(prompterProvider.notifier)
                                      .toggleCurrentChapterEnabled()
                                : null,
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
                              isSelected:
                                  prompterConfig.displayReadingIndicatorBoxes,
                              tooltip: context.tr(
                                "PrompterScreen.SimpleDialog_DisplaySettings.IconButton_ReadingIndicatorBoxes",
                              ),
                              onPressed: () => ref
                                  .read(prompterProvider.notifier)
                                  .toggleDisplayReadingIndicatorBoxes(),
                            ),
                            Slider(
                              value: prompterConfig.readingIndicatorBoxesHeight,
                              min: 0.0,
                              max: 100.0,
                              divisions: 20,
                              label: prompterConfig.readingIndicatorBoxesHeight
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
                              isSelected:
                                  prompterConfig.displayVerticalMarginBoxes,
                              tooltip: context.tr(
                                "PrompterScreen.SimpleDialog_DisplaySettings.IconButton_VerticalMarginBoxes",
                              ),
                              onPressed: () => ref
                                  .read(prompterProvider.notifier)
                                  .toggleDisplayVerticalMarginBoxes(),
                            ),
                            Slider(
                              value: prompterConfig.verticalMarginBoxesHeight,
                              min: 0.0,
                              max: 100.0,
                              divisions: 20,
                              label: prompterConfig.verticalMarginBoxesHeight
                                  .toStringAsFixed(2),
                              onChanged: (value) => ref
                                  .read(prompterProvider.notifier)
                                  .setVerticalMarginBoxHeight(value),
                            ),
                          ],
                        ),
                      ),
                      if (prompterConfig.displayVerticalMarginBoxes)
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
                                isSelected: prompterConfig
                                    .verticalMarginBoxesFadeEnabled,
                                onPressed: () => ref
                                    .read(prompterProvider.notifier)
                                    .toggleVerticalMarginBoxesFadeEnabled(),
                              ),
                              Slider(
                                value: prompterConfig
                                    .verticalMarginBoxesFadeLength,
                                min: 0.0,
                                max: 100,
                                divisions: 20,
                                label: prompterConfig
                                    .verticalMarginBoxesFadeLength
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
                              value: prompterConfig.sideMargin,
                              min: 0,
                              max: 100,
                              divisions: 100,
                              label: prompterConfig.sideMargin.toStringAsFixed(
                                2,
                              ),
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
                              value: prompterConfig.countdownDuration,
                              min: 0,
                              max: 60,
                              divisions: 60,
                              label: prompterConfig.countdownDuration
                                  .toStringAsFixed(0),
                              onChanged: (value) => ref
                                  .read(prompterProvider.notifier)
                                  .setCountdownDuration(value),
                            ),
                          ],
                        ),
                      ),
                      _FeatureGate(
                        feature: Feature.controlButtons,
                        displayText: context.tr(
                          "SettingsScreen.BooleanAppSetting_ControlButtons",
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () => ref
                                  .read(prompterProvider.notifier)
                                  .toggleShowControlButtons(),
                              isSelected: prompterConfig.showControlButtons,
                              icon: Icon(Icons.apps_outlined),
                              tooltip: context.tr(
                                "SettingsScreen.BooleanAppSetting_ControlButtons",
                              ),
                            ),
                            DropdownButton(
                              value: prompterConfig.controlButtonsPosition,
                              items: ControlButtonsPosition.values
                                  .map(
                                    (v) => DropdownMenuItem(
                                      value: v,
                                      child: Text(
                                        context.tr(
                                          "SettingsScreen.DropdownAppSetting_ControlButtonPosition.${v.name}",
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) => ref
                                  .read(prompterProvider.notifier)
                                  .setControlButtonsPosition(value!),
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
      AsyncLoading() => Scaffold(
        appBar: AppBar(
          title: Text(context.tr("SettingsScreen.KeybindingsSettings.Title")),
        ),
        body: SpinKitRing(
          color:
              ref.read(settingsProvider).value?.appPrimaryColor ?? kBrandTeal,
        ),
      ),
      _ => const ResetSettingsView(),
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
      return _FeatureDisabledInline(displayText: displayText, feature: feature);
    }

    return child;
  }
}

class _FeatureDisabledInline extends ConsumerWidget {
  const _FeatureDisabledInline({
    required this.displayText,
    required this.feature,
  });

  final String displayText;
  final Feature feature;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: Icon(Icons.lock_outline),
      tileColor: Colors.blueGrey.withAlpha(30),
      title: Text(displayText),
      onTap: () => context.push(
        "/disabledfeature",
        extra: DisabledFeatureScreenRouterExtra(feature: feature),
      ),
    );
  }
}

class _FeatureGatedIconButton extends ConsumerWidget {
  const _FeatureGatedIconButton({
    this.isSelected,
    required this.feature,
    required this.displayText,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final Feature feature;
  final String displayText;
  final Widget icon;
  final String tooltip;
  final VoidCallback? onPressed;
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
      onPressed: () => context.push(
        "/disabledfeature",
        extra: DisabledFeatureScreenRouterExtra(feature: feature),
      ),
    );
  }
}
