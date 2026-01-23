import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/models/keybinding.dart';
import 'package:tiefprompt/providers/feature_provider.dart';
import 'package:tiefprompt/providers/keybinding_provider.dart';
import 'package:tiefprompt/providers/prompter_provider.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/ui/widgets/countdown_timer.dart';
import 'package:tiefprompt/ui/widgets/prompter_bottom_bar.dart';
import 'package:tiefprompt/ui/widgets/prompter_top_bar.dart';
import 'package:tiefprompt/ui/widgets/vertical_margin.dart';
import 'package:tiefprompt/ui/widgets/scrollable_text.dart';
import 'package:tiefprompt/providers/script_provider.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

final controlsVisibleProvider = StateProvider<bool>((ref) => true);

class PrompterScreen extends ConsumerStatefulWidget {
  const PrompterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PrompterScreenState();
}

class _PrompterScreenState extends ConsumerState<PrompterScreen> {
  final _focusNode = FocusNode();
  late final ScrollableTextController _scrollableTextController;

  @override
  void initState() {
    super.initState();
    _scrollableTextController = ScrollableTextController();
    WakelockPlus.enable();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollableTextController.scrollController.hasClients) {
        _scrollableTextController.jumpTo(
          MediaQuery.of(context).size.height / 2,
        );
      }
    });

    ref.read(settingsProvider).whenData((data) {
      ref.read(prompterProvider.notifier).applySettings(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    final script = ref.watch(scriptProvider);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

    ref.listen(settingsProvider, (previous, next) async {
      next.whenData((data) {
        ref.read(prompterProvider.notifier).applySettings(data);
      });
    });

    final prompter = ref.watch(prompterProvider);

    if (prompter.isPlaying) {
      WakelockPlus.enable();
    } else {
      WakelockPlus.disable();
    }

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
                ref.read(controlsVisibleProvider.notifier).state = !ref.watch(
                  controlsVisibleProvider,
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ScrollableText(
                  controller: _scrollableTextController,
                  text: script.text,
                  style: TextStyle(
                    fontSize: prompter.fontSize,
                    fontFamily: prompter.fontFamily,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  sideMargin:
                      (MediaQuery.of(context).size.width / 2) *
                      (prompter.sideMargin / 100),
                ),
              ),
            ),
            if (prompter.displayVerticalMarginBoxes)
              VerticalMargin(
                heightRatio: prompter.verticalMarginBoxesHeight,
                color: Theme.of(context).canvasColor,
                fade: prompter.verticalMarginBoxesFadeEnabled,
                // NOTE: fadeLength should be normalized to [0, 1]
                fadeLength: prompter.verticalMarginBoxesFadeLength / 100,
              ),
            if (prompter.displayReadingIndicatorBoxes)
              VerticalMargin(
                heightRatio: prompter.readingIndicatorBoxesHeight,
                color: Theme.of(context).colorScheme.onSurface.withAlpha(60),
              ),
            if (ref.watch(controlsVisibleProvider)) PrompterTopBar(),
            if (ref.watch(controlsVisibleProvider)) PrompterBottomBar(),
            if (prompter.displayCountdown && prompter.countdownDuration > 0)
              CountdownTimer(duration: prompter.countdownDuration.toInt()),
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
    super.dispose();
  }

  Future<void> _runEventAction(
    Future<List<KeybindingAction>> actionForEvent,
  ) async {
    if (!context.mounted) {
      throw StateError("Context not available.");
    }

    for (final action in await actionForEvent) {
      switch (action) {
        case KeybindingAction.playPause:
          _gatedKeybinding(
            Feature.playPause,
            () => ref.read(prompterProvider.notifier).togglePlayPause(),
          );
          break;
        case KeybindingAction.scrollUp:
          _gatedKeybinding(
            Feature.keybindings,
            () => _scrollableTextController.jumpRelative(-75),
          );
          break;
        case KeybindingAction.scrollDown:
          _gatedKeybinding(
            Feature.keybindings,
            () => _scrollableTextController.jumpRelative(75),
          );
          break;
        case KeybindingAction.scrollUpSmall:
          _gatedKeybinding(
            Feature.keybindings,
            () => _scrollableTextController.jumpRelative(-25),
          );
          break;
        case KeybindingAction.scrollDownSmall:
          _gatedKeybinding(
            Feature.keybindings,
            () => _scrollableTextController.jumpRelative(25),
          );
          break;
        case KeybindingAction.pageUp:
          _gatedKeybinding(
            Feature.keybindings,
            () => _scrollableTextController.jumpRelative(
              -MediaQuery.of(context).size.height,
            ),
          );
          break;
        case KeybindingAction.pageDown:
          _gatedKeybinding(
            Feature.keybindings,
            () => _scrollableTextController.jumpRelative(
              MediaQuery.of(context).size.height,
            ),
          );
          break;
        case KeybindingAction.jumpStart:
          _gatedKeybinding(
            Feature.keybindings,
            () => _scrollableTextController.jumpTo(0),
          );
          break;
        case KeybindingAction.jumpEnd:
          _gatedKeybinding(
            Feature.keybindings,
            () => _scrollableTextController.jumpTo(
              _scrollableTextController
                  .scrollController
                  .position
                  .maxScrollExtent,
            ),
          );
          break;
        case KeybindingAction.toggleControls:
          _gatedKeybinding(
            Feature.keybindings,
            () => ref.read(controlsVisibleProvider.notifier).state = !ref.watch(
              controlsVisibleProvider,
            ),
          );
          break;
        case KeybindingAction.fontSizeUp:
          _gatedKeybinding(
            Feature.fontSize,
            () => ref.read(prompterProvider.notifier).increaseFontSize(1),
          );
          break;
        case KeybindingAction.fontSizeDown:
          _gatedKeybinding(
            Feature.fontSize,
            () => ref.read(prompterProvider.notifier).decreaseFontSize(1),
          );
          break;
        case KeybindingAction.speedUp:
          _gatedKeybinding(
            Feature.keybindings,
            () => ref.read(prompterProvider.notifier).increaseSpeed(.1),
          );
          break;
        case KeybindingAction.speedDown:
          _gatedKeybinding(
            Feature.keybindings,
            () => ref.read(prompterProvider.notifier).decreaseSpeed(.1),
          );
          break;
        case KeybindingAction.openSettings:
          _gatedKeybinding(
            Feature.keybindings,
            () => context.push('/settings'),
          );
          break;
        case KeybindingAction.saveSettingsFromPrompter:
          _gatedKeybinding(
            Feature.keybindings,
            () => ref
                .read(settingsProvider.notifier)
                .applySettingsFromPrompter(ref.read(prompterProvider)),
          );
          break;
      }
    }
  }

  void _gatedKeybinding(Feature feature, Function() action) {
    final isEnabled = ref.watch(
      featuresProvider.select((s) => s.features.contains(feature)),
    );

    if (isEnabled) {
      action();
    }
  }
}
