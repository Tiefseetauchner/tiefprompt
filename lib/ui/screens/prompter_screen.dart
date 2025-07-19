import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
    final controlsVisible = ref.watch(controlsVisibleProvider);

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
          switch (keyEvent.logicalKey) {
            case LogicalKeyboardKey.enter:
            case LogicalKeyboardKey.space:
              ref.read(prompterProvider.notifier).togglePlayPause();
              break;
            case LogicalKeyboardKey.arrowUp:
              _scrollableTextController.jumpRelative(-75);
              break;
            case LogicalKeyboardKey.arrowDown:
              _scrollableTextController.jumpRelative(75);
              break;
            case LogicalKeyboardKey.pageUp:
              _scrollableTextController.jumpRelative(
                -MediaQuery.of(context).size.height,
              );
              break;
            case LogicalKeyboardKey.pageDown:
              _scrollableTextController.jumpRelative(
                MediaQuery.of(context).size.height,
              );
              break;
            case LogicalKeyboardKey.home:
              _scrollableTextController.jumpTo(0);
              break;
            case LogicalKeyboardKey.end:
              _scrollableTextController.jumpTo(
                _scrollableTextController
                    .scrollController
                    .position
                    .maxScrollExtent,
              );
              break;
            case LogicalKeyboardKey.tab:
              ref.read(controlsVisibleProvider.notifier).state =
                  !controlsVisible;
              break;
          }

          switch (keyEvent.physicalKey) {
            case PhysicalKeyboardKey.equal:
            case PhysicalKeyboardKey.numpadAdd:
              if (HardwareKeyboard.instance.isControlPressed) {
                ref.read(prompterProvider.notifier).increaseFontSize(1);
              } else {
                ref.read(prompterProvider.notifier).increaseSpeed(.1);
              }
              break;
            case PhysicalKeyboardKey.minus:
            case PhysicalKeyboardKey.numpadSubtract:
              if (HardwareKeyboard.instance.isControlPressed) {
                ref.read(prompterProvider.notifier).decreaseFontSize(1);
              } else {
                ref.read(prompterProvider.notifier).decreaseSpeed(.1);
              }
              break;
            case PhysicalKeyboardKey.period:
              if (HardwareKeyboard.instance.isControlPressed) {
                context.push('/settings');
              }
              break;
          }

          switch (keyEvent.character) {
            case "s":
              if (HardwareKeyboard.instance.isControlPressed) {
                ref
                    .read(settingsProvider.notifier)
                    .applySettingsFromPrompter(prompter);
              }
              break;
          }
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
                ref.read(controlsVisibleProvider.notifier).state =
                    !controlsVisible;
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
            if (controlsVisible) PrompterTopBar(),
            if (controlsVisible) PrompterBottomBar(),
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
}
