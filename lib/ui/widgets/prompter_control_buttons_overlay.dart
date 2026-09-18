import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiefprompt/core/control_buttons.dart';
import 'package:tiefprompt/providers/prompter_provider.dart';
import 'package:tiefprompt/ui/widgets/scrollable_text.dart';

const double kPrompterControlButtonsOverlayIconSize = 45;

class PrompterControlButtonsOverlay extends ConsumerWidget {
  final ScrollableTextController scrollableTextController;

  const PrompterControlButtonsOverlay({
    super.key,
    required this.scrollableTextController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controlButtonsPosition = ref.watch(
      prompterProvider.select((p) => p.config.controlButtonsPosition),
    );

    return SafeArea(
      child: Container(
        alignment: ControlButtonsPositionResolver.getAlignment(
          controlButtonsPosition,
        ),
        padding: EdgeInsets.all(kControlButtonMargin),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withAlpha(120),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: _ControlButtons(
            scrollableTextController: scrollableTextController,
          ),
        ),
      ),
    );
  }
}

class _ControlButtons extends ConsumerWidget {
  final ScrollableTextController scrollableTextController;

  const _ControlButtons({required this.scrollableTextController});

  List<Widget> _getButtons(WidgetRef ref) {
    return [
      IconButton(
        iconSize: kPrompterControlButtonsOverlayIconSize,
        onPressed: () => scrollableTextController.jumpTo(0),
        icon: Icon(Icons.keyboard_double_arrow_up_rounded),
      ),
      IconButton(
        iconSize: kPrompterControlButtonsOverlayIconSize,
        onPressed: () => scrollableTextController.jumpRelative(-75),
        icon: Icon(Icons.keyboard_arrow_up_rounded),
      ),
      IconButton(
        iconSize: kPrompterControlButtonsOverlayIconSize,
        onPressed: () => ref.read(prompterProvider.notifier).togglePlayPause(),
        icon: Icon(
          ref.watch(prompterProvider).isPlaying
              ? Icons.pause_rounded
              : Icons.play_arrow_rounded,
        ),
      ),
      IconButton(
        iconSize: kPrompterControlButtonsOverlayIconSize,
        onPressed: () => scrollableTextController.jumpRelative(75),
        icon: Icon(Icons.keyboard_arrow_down_rounded),
      ),
      IconButton(
        iconSize: kPrompterControlButtonsOverlayIconSize,
        onPressed: () => scrollableTextController.jumpTo(
          scrollableTextController.scrollController.position.maxScrollExtent,
        ),
        icon: Icon(Icons.keyboard_double_arrow_down_rounded),
      ),
    ];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controlButtonsPosition = ref.watch(
      prompterProvider.select((p) => p.config.controlButtonsPosition),
    );

    switch (controlButtonsPosition) {
      case ControlButtonsPosition.left:
      case ControlButtonsPosition.right:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: _getButtons(ref),
        );
      case ControlButtonsPosition.bottom:
      case ControlButtonsPosition.top:
        return Row(mainAxisSize: MainAxisSize.min, children: _getButtons(ref));
    }
  }
}
