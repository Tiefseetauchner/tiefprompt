import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiefprompt/core/theme.dart';
import 'package:tiefprompt/providers/prompter_provider.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/ui/widgets/prompter_bottom_bar.dart';
import 'package:tiefprompt/ui/widgets/prompter_top_bar.dart';
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
          switch (keyEvent.logicalKey) {
            case LogicalKeyboardKey.space:
              ref.read(prompterProvider.notifier).togglePlayPause();
              break;
            case LogicalKeyboardKey.arrowUp:
              _scrollableTextController.scrollController.jumpTo(
                  _scrollableTextController.scrollController.offset - 75);
              break;
            case LogicalKeyboardKey.arrowDown:
              _scrollableTextController.scrollController.jumpTo(
                  _scrollableTextController.scrollController.offset + 75);
              break;
            case LogicalKeyboardKey.pageUp:
              _scrollableTextController.scrollController.jumpTo(
                  _scrollableTextController.scrollController.offset -
                      MediaQuery.of(context).size.height);
              break;
            case LogicalKeyboardKey.pageDown:
              _scrollableTextController.scrollController.jumpTo(
                  _scrollableTextController.scrollController.offset +
                      MediaQuery.of(context).size.height);
              break;
            case LogicalKeyboardKey.home:
              _scrollableTextController.scrollController.jumpTo(0);
              break;
            case LogicalKeyboardKey.end:
              _scrollableTextController.scrollController.jumpTo(
                  _scrollableTextController
                      .scrollController.position.maxScrollExtent);
              break;
            case LogicalKeyboardKey.tab:
              ref.read(controlsVisibleProvider.notifier).state =
                  !controlsVisible;
              break;
            case LogicalKeyboardKey.add:
            case LogicalKeyboardKey.numpadAdd:
              ref.read(prompterProvider.notifier).increaseSpeed(1);
              break;
            case LogicalKeyboardKey.minus:
            case LogicalKeyboardKey.numpadSubtract:
              ref.read(prompterProvider.notifier).decreaseSpeed(1);
              break;
            case LogicalKeyboardKey.save:
              ref
                  .read(settingsProvider.notifier)
                  .applySettingsFromPrompter(prompter);
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
                    )),
              ),
              if (controlsVisible) PrompterTopBar(),
              if (controlsVisible) PrompterBottomBar(),
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
    super.dispose();
  }
}
