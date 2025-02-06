import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiefprompt/providers/prompter_provider.dart';
import 'package:tiefprompt/providers/settings_provider.dart';

class PrompterBottomBar extends ConsumerWidget {
  const PrompterBottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prompterState = ref.watch(prompterProvider);

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.black.withAlpha(100),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.flip, color: ThemeData().colorScheme.onPrimary),
              onPressed: () =>
                  ref.read(settingsProvider.notifier).toggleMirroredX(),
            ),
            RotatedBox(
                quarterTurns: 1,
                child: IconButton(
                  icon: Icon(Icons.flip,
                      color: ThemeData().colorScheme.onPrimary),
                  onPressed: () =>
                      ref.read(settingsProvider.notifier).toggleMirroredY(),
                )),
            VerticalDivider(
              width: 30,
            ),
            IconButton(
              icon:
                  Icon(Icons.remove, color: ThemeData().colorScheme.onPrimary),
              onPressed: () =>
                  ref.read(prompterProvider.notifier).decreaseSpeed(0.1),
            ),
            IconButton(
              icon: Icon(
                  prompterState.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: ThemeData().colorScheme.onPrimary),
              onPressed: () =>
                  ref.read(prompterProvider.notifier).togglePlayPause(),
            ),
            IconButton(
              icon: Icon(Icons.add, color: ThemeData().colorScheme.onPrimary),
              onPressed: () =>
                  ref.read(prompterProvider.notifier).increaseSpeed(0.1),
            ),
          ],
        ),
      ),
    );
  }
}
