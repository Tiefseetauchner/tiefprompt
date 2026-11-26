import 'dart:async';

import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/core/control_buttons.dart';
import 'package:tiefprompt/core/debouncer.dart';
import 'package:tiefprompt/core/prompter_orientation.dart';
import 'package:tiefprompt/models/keybinding.dart';
import 'package:tiefprompt/providers/all_chapter_provider.dart';
import 'package:tiefprompt/providers/commands_provider.dart';
import 'package:tiefprompt/providers/feature_provider.dart';
import 'package:tiefprompt/providers/keybinding_provider.dart';
import 'package:tiefprompt/providers/prompter_provider.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/services/script_service.dart';
import 'package:tiefprompt/ui/widgets/audio_level_display.dart';
import 'package:tiefprompt/ui/widgets/countdown_timer.dart';
import 'package:tiefprompt/ui/widgets/current_chapter_banner.dart';
import 'package:tiefprompt/ui/widgets/elapsed_time_display.dart';
import 'package:tiefprompt/ui/widgets/prompter_bottom_bar.dart';
import 'package:tiefprompt/ui/widgets/prompter_control_buttons_overlay.dart';
import 'package:tiefprompt/ui/widgets/prompter_top_bar.dart';
import 'package:tiefprompt/ui/widgets/vertical_margin.dart';
import 'package:tiefprompt/ui/widgets/scrollable_text.dart';
import 'package:tiefprompt/providers/script_provider.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class _ControlsVisible extends Notifier<bool> {
  @override
  bool build() => true;
  void toggle() => state = !state;
}

final controlsVisibleProvider = NotifierProvider<_ControlsVisible, bool>(
  _ControlsVisible.new,
);

class PrompterScreen extends ConsumerStatefulWidget {
  const PrompterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PrompterScreenState();
}

class _PrompterScreenState extends ConsumerState<PrompterScreen> {
  final _focusNode = FocusNode();
  late final ScrollableTextController _scrollableTextController;
  late final Debouncer _scrollableTextControllerSaveDebouncer;
  late final StreamSubscription<CommandEvent>
  _commandProviderStreamSubscription;

  @override
  void initState() {
    super.initState();
    _scrollableTextController = ScrollableTextController();
    _scrollableTextControllerSaveDebouncer = PeriodicRunDebouncer(
      delay: Duration(seconds: 1),
      periodicDelay: Duration(seconds: 5),
    );
    WakelockPlus.enable();

    ref.read(settingsProvider).whenData((data) {
      SystemChrome.setPreferredOrientations(
        data.config.prompterOrientation.deviceOrientation,
      );
    });

    ref.invalidate(allChapterProvider);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

    _commandProviderStreamSubscription = ref
        .read(commandProvider.notifier)
        .stream
        .listen((event) {
          _executeCommand(event);
        });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollableTextController.scrollController.hasClients) {
        final storedScrollOffset = ref.read(scriptProvider).scrollPosition;
        _scrollableTextController.jumpTo(
          storedScrollOffset ?? MediaQuery.of(context).size.height / 2,
        );
      }
    });

    ref.read(settingsProvider).whenData((data) {
      ref.read(prompterProvider.notifier).applySettings(data);
    });

    _scrollableTextController.scrollController.addListener(_saveOnScroll);
  }

  @override
  Widget build(BuildContext context) {
    final script = ref.watch(scriptProvider);

    ref.listen(settingsProvider, (previous, next) async {
      next.whenData((data) {
        SystemChrome.setPreferredOrientations(
          data.config.prompterOrientation.deviceOrientation,
        );
        ref.read(prompterProvider.notifier).applySettings(data);
      });
    });

    final (:prompterConfig, :displayCountdown) = ref.watch(
      prompterProvider.select(
        (p) => (prompterConfig: p.config, displayCountdown: p.displayCountdown),
      ),
    );

    return KeyboardListener(
      onKeyEvent: (keyEvent) {
        if (keyEvent is KeyDownEvent) {
          _runEventAction(
            ref.read(keybindingsProvider.notifier).actionForEvent(keyEvent),
          );
        }
      },
      focusNode: _focusNode,
      autofocus: true,
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            GestureDetector(
              onTap: () {
                ref.read(controlsVisibleProvider.notifier).toggle();
              },
              child: SafeArea(
                minimum: const EdgeInsets.all(16.0),
                child: ScrollableText(
                  controller: _scrollableTextController,
                  text: script.text,
                  style: TextStyle(
                    fontSize: prompterConfig.fontSize,
                    fontFamily: prompterConfig.fontFamily,
                    color: Theme.of(context).colorScheme.onSurface,
                    height: prompterConfig.lineHeightEnabled
                        ? prompterConfig.lineHeight
                        : null,
                  ),
                  sideMargin:
                      (MediaQuery.of(context).size.width / 2) *
                      (prompterConfig.sideMargin / 100),
                ),
              ),
            ),
            if (prompterConfig.displayVerticalMarginBoxes)
              VerticalMargin(
                heightRatio: prompterConfig.verticalMarginBoxesHeight,
                color: Theme.of(context).canvasColor,
                fade: prompterConfig.verticalMarginBoxesFadeEnabled,
                // NOTE: fadeLength should be normalized to [0, 1]
                fadeLength: prompterConfig.verticalMarginBoxesFadeLength / 100,
              ),
            if (prompterConfig.displayReadingIndicatorBoxes)
              VerticalMargin(
                heightRatio: prompterConfig.readingIndicatorBoxesHeight,
                color: Theme.of(context).colorScheme.onSurface.withAlpha(60),
              ),
            CurrentChapterBanner(
              offset: ref.watch(controlsVisibleProvider)
                  ? EdgeInsets.fromLTRB(0, 64, 0, 0)
                  : EdgeInsets.all(0),
              scrollableTextController: _scrollableTextController,
            ),
            if ((!ref.watch(controlsVisibleProvider) ||
                    (prompterConfig.controlButtonsPosition ==
                            ControlButtonsPosition.left ||
                        prompterConfig.controlButtonsPosition ==
                            ControlButtonsPosition.right)) &&
                prompterConfig.showControlButtons)
              PrompterControlButtonsOverlay(),
            if (ref.watch(controlsVisibleProvider)) PrompterTopBar(),
            if (ref.watch(controlsVisibleProvider)) PrompterBottomBar(),
            if (prompterConfig.voiceActivationEnabled)
              Positioned(
                top: 12,
                right: 12,
                child: AudioLevelDisplay(config: prompterConfig),
              ),
            if (prompterConfig.showElapsedTime)
              Positioned(top: 96, right: 12, child: ElapsedTimeDisplay()),
            if (displayCountdown && prompterConfig.countdownDuration > 0)
              CountdownTimer(
                duration: prompterConfig.countdownDuration.toInt(),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([]);
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    WakelockPlus.disable();
    _focusNode.dispose();
    _scrollableTextController.dispose();
    _scrollableTextControllerSaveDebouncer.dispose();
    _commandProviderStreamSubscription.cancel();

    super.dispose();
  }

  Future<void> _runEventAction(
    Future<List<CommandAction>> actionForEvent,
  ) async {
    if (!context.mounted) {
      throw StateError("Context not available.");
    }

    for (final action in await actionForEvent) {
      ref
          .read(commandProvider.notifier)
          .sendCommandToPrompter(
            CommandEvent(action, CommandSource.keybinding),
          );
    }
  }

  void _executeCommand(CommandEvent event) {
    switch (event.action) {
      case CommandAction.playPause:
        _executeCommandCallback(
          event.source,
          () => ref.read(prompterProvider.notifier).togglePlayPause(),
          feature: Feature.playPause,
        );
        break;
      case CommandAction.scrollUp:
        _executeCommandCallback(
          event.source,
          () => _scrollableTextController.jumpRelative(-kPrompterJumpDistance),
        );
        break;
      case CommandAction.scrollDown:
        _executeCommandCallback(
          event.source,
          () => _scrollableTextController.jumpRelative(kPrompterJumpDistance),
        );
        break;
      case CommandAction.scrollUpSmall:
        _executeCommandCallback(
          event.source,
          () => _scrollableTextController.jumpRelative(-25),
        );
        break;
      case CommandAction.scrollDownSmall:
        _executeCommandCallback(
          event.source,
          () => _scrollableTextController.jumpRelative(25),
        );
        break;
      case CommandAction.pageUp:
        _executeCommandCallback(
          event.source,
          () => _scrollableTextController.jumpRelative(
            -MediaQuery.of(context).size.height,
          ),
        );
        break;
      case CommandAction.pageDown:
        _executeCommandCallback(
          event.source,
          () => _scrollableTextController.jumpRelative(
            MediaQuery.of(context).size.height,
          ),
        );
        break;
      case CommandAction.jumpStart:
        _executeCommandCallback(
          event.source,
          () => _scrollableTextController.jumpTo(0),
        );
        break;
      case CommandAction.jumpEnd:
        _executeCommandCallback(
          event.source,
          () => _scrollableTextController.jumpTo(
            _scrollableTextController.scrollController.position.maxScrollExtent,
          ),
        );
        break;
      case CommandAction.toggleControls:
        _executeCommandCallback(
          event.source,
          () => ref.read(controlsVisibleProvider.notifier).toggle(),
        );
        break;
      case CommandAction.fontSizeUp:
        _executeCommandCallback(
          event.source,
          () => ref.read(prompterProvider.notifier).increaseFontSize(1),
          feature: Feature.fontSize,
        );
        break;
      case CommandAction.fontSizeDown:
        _executeCommandCallback(
          event.source,
          () => ref.read(prompterProvider.notifier).decreaseFontSize(1),
          feature: Feature.fontSize,
        );
        break;
      case CommandAction.speedUp:
        _executeCommandCallback(
          event.source,
          () => ref.read(prompterProvider.notifier).increaseSpeed(.1),
        );
        break;
      case CommandAction.speedDown:
        _executeCommandCallback(
          event.source,
          () => ref.read(prompterProvider.notifier).decreaseSpeed(.1),
        );
        break;
      case CommandAction.openSettings:
        _executeCommandCallback(event.source, () => context.push('/settings'));
        break;
      case CommandAction.saveSettingsFromPrompter:
        _executeCommandCallback(
          event.source,
          () => ref
              .read(settingsProvider.notifier)
              .applySettingsFromPrompter(ref.read(prompterProvider)),
        );
        break;
      case CommandAction.jumpChapterUp:
        _executeCommandCallback(event.source, () {
          final currentOffset =
              _scrollableTextController.scrollController.offset;
          final chapters = ref.read(allChapterProvider);
          final targetChapter =
              chapters.where((c) => c.offset < currentOffset).lastOrNull ??
              chapters.firstOrNull;
          if (targetChapter != null) {
            _scrollableTextController.jumpTo(targetChapter.offset);
          }
        });
        break;
      case CommandAction.jumpChapterDown:
        _executeCommandCallback(event.source, () {
          final currentOffset =
              _scrollableTextController.scrollController.offset;
          final chapters = ref.read(allChapterProvider);
          final targetChapter =
              chapters.where((c) => c.offset > currentOffset).firstOrNull ??
              chapters.lastOrNull;
          if (targetChapter != null) {
            _scrollableTextController.jumpTo(targetChapter.offset);
          }
        });
        break;
    }
  }

  void _executeCommandCallback(
    CommandSource source,
    Function() action, {
    Feature? feature,
  }) {
    final sourceFeature = switch (source) {
      CommandSource.keybinding => Feature.keybindings,
      CommandSource.controlButton => Feature.controlButtons,
      CommandSource.remote => Feature.remoteControl,
    };

    final isEnabled = ref.read(
      featuresProvider.select(
        (s) =>
            (feature == null || s.features.contains(feature)) &&
            s.features.contains(sourceFeature),
      ),
    );

    if (isEnabled) {
      action();
    }
  }

  void _saveOnScroll() {
    _scrollableTextControllerSaveDebouncer.run(_saveScrollPosition);
  }

  void _saveScrollPosition() {
    final scriptId = ref.read(scriptProvider).id;
    final scrollOffset = _scrollableTextController.scrollController.offset;

    ref.read(scriptProvider.notifier).setScrollPosition(scrollOffset);
    if (scriptId != null) {
      ref
          .read(scriptServiceProvider.notifier)
          .updateScrollPosition(scriptId, scrollOffset);
    }
  }
}
