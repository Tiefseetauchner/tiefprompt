import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiefprompt/providers/prompter_provider.dart';

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
        color: Theme.of(context).colorScheme.onSecondary.withAlpha(120),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.flip,
                  color: Theme.of(context).colorScheme.onPrimary),
              onPressed: () =>
                  ref.read(prompterProvider.notifier).toggleMirroredX(),
            ),
            RotatedBox(
                quarterTurns: 1,
                child: IconButton(
                  icon: Icon(Icons.flip,
                      color: Theme.of(context).colorScheme.onPrimary),
                  onPressed: () =>
                      ref.read(prompterProvider.notifier).toggleMirroredY(),
                )),
            VerticalDivider(
              width: 30,
            ),
            IconButton(
              icon: Icon(Icons.remove,
                  color: Theme.of(context).colorScheme.onPrimary),
              onPressed: () =>
                  ref.read(prompterProvider.notifier).decreaseSpeed(1),
            ),
            IconButton(
              icon: Icon(
                  prompterState.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Theme.of(context).colorScheme.onPrimary),
              onPressed: () =>
                  ref.read(prompterProvider.notifier).togglePlayPause(),
            ),
            IconButton(
              icon: Icon(Icons.add,
                  color: Theme.of(context).colorScheme.onPrimary),
              onPressed: () =>
                  ref.read(prompterProvider.notifier).increaseSpeed(1),
            ),
            VerticalDivider(
              width: 30,
            ),
            IconButton(
              icon: Icon(Icons.text_decrease,
                  color: Theme.of(context).colorScheme.onPrimary),
              onPressed: () =>
                  ref.read(prompterProvider.notifier).decreaseFontSize(1.2),
            ),
            IconButton(
              icon: Icon(Icons.text_increase,
                  color: Theme.of(context).colorScheme.onPrimary),
              onPressed: () =>
                  ref.read(prompterProvider.notifier).increaseFontSize(1.2),
            ),
            Text(prompterState.speed.toString()),
          ],
        ),
      ),
    );
  }
}
