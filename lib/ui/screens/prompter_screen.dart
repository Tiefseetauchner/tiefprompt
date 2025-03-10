import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiefprompt/core/theme.dart';
import 'package:tiefprompt/providers/prompter_provider.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/ui/widgets/countdown_timer.dart';
import 'package:tiefprompt/ui/widgets/prompter_bottom_bar.dart';
import 'package:tiefprompt/ui/widgets/prompter_top_bar.dart';
import 'package:tiefprompt/ui/widgets/reading_indicator.dart';
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

    WidgetsBinding.instance.addPostFrameCallback((_) =>
        _scrollableTextController
            .jumpTo(MediaQuery.of(context).size.height / 2));
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

    ref.listen(settingsProvider, (previous, next) {
      next.whenData((settings) {
        ref.read(prompterProvider.notifier).applySettings(settings);
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
          switch (keyEvent.physicalKey) {
            case PhysicalKeyboardKey.enter:
            case PhysicalKeyboardKey.space:
              ref.read(prompterProvider.notifier).togglePlayPause();
              break;
            case PhysicalKeyboardKey.arrowUp:
              _scrollableTextController.jumpRelative(-75);
              break;
            case PhysicalKeyboardKey.arrowDown:
              _scrollableTextController.jumpRelative(75);
              break;
            case PhysicalKeyboardKey.pageUp:
              _scrollableTextController
                  .jumpRelative(-MediaQuery.of(context).size.height);
              break;
            case PhysicalKeyboardKey.pageDown:
              _scrollableTextController
                  .jumpRelative(MediaQuery.of(context).size.height);
              break;
            case PhysicalKeyboardKey.home:
              _scrollableTextController.jumpTo(0);
              break;
            case PhysicalKeyboardKey.end:
              _scrollableTextController.jumpTo(_scrollableTextController
                  .scrollController.position.maxScrollExtent);
              break;
            case PhysicalKeyboardKey.tab:
              ref.read(controlsVisibleProvider.notifier).state =
                  !controlsVisible;
              break;
            case PhysicalKeyboardKey.equal:
            case PhysicalKeyboardKey.numpadAdd:
              if (HardwareKeyboard.instance.isControlPressed) {
                ref.read(prompterProvider.notifier).increaseFontSize(10);
              } else {
                ref.read(prompterProvider.notifier).increaseSpeed(1);
              }
              break;
            case PhysicalKeyboardKey.minus:
            case PhysicalKeyboardKey.numpadSubtract:
              if (HardwareKeyboard.instance.isControlPressed) {
                ref.read(prompterProvider.notifier).decreaseFontSize(10);
              } else {
                ref.read(prompterProvider.notifier).decreaseSpeed(1);
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
      child: Theme(
        data: prompterBlackTheme,
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
                        color: Theme.of(context).colorScheme.onPrimary),
                    sideMargin: (MediaQuery.of(context).size.width / 2) *
                        (prompter.sideMargin / 100),
                  ),
                ),
              ),
              ReadingIndicator(),
              if (controlsVisible) PrompterTopBar(),
              if (controlsVisible) PrompterBottomBar(),
              if (prompter.displayCountdown && prompter.countdownDuration > 0)
                CountdownTimer(
                  duration: prompter.countdownDuration.toInt(),
                )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    WakelockPlus.disable();
    _focusNode.dispose();
    _scrollableTextController.dispose();
    super.dispose();
  }
}
