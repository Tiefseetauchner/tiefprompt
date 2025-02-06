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
        color: Colors.black.withAlpha(100),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.remove, color: Colors.white),
              onPressed: () =>
                  ref.read(prompterProvider.notifier).decreaseSpeed(0.1),
            ),
            IconButton(
              icon: Icon(
                  prompterState.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white),
              onPressed: () =>
                  ref.read(prompterProvider.notifier).togglePlayPause(),
            ),
            IconButton(
              icon: const Icon(Icons.add, color: Colors.white),
              onPressed: () =>
                  ref.read(prompterProvider.notifier).increaseSpeed(0.1),
            ),
          ],
        ),
      ),
    );
  }
}
