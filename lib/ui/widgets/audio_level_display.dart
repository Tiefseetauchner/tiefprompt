import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiefprompt/providers/prompter_config.dart';
import 'package:tiefprompt/providers/voice_activation_provider.dart';

class AudioLevelDisplay extends ConsumerWidget {
  final PrompterConfiguration config;

  const AudioLevelDisplay({super.key, required this.config});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioLevel = ref.watch(voiceActivationProvider.future);

    return FutureBuilder(
      future: audioLevel,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SizedBox.shrink();
        }

        // NOTE: audioLevel is a double from -infinity (silence) to 0 (max)
        //       To convert to the width, we need to normalize it to a range of 0 to 1.
        //       Then we can multiply it by the maximum width (64) to get the actual width.
        //       We also need to consider that the audio level might be -infinity, so we clamp it to a minimum value.
        final double audioLevelWidth = max(
          0,
          ((snapshot.data ?? -60) + 60) / 60 * 64,
        );

        return Stack(
          children: [
            Container(
              width: 64,
              height: 24,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  style: BorderStyle.solid,
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
              ),
            ),
            Container(
              height: 24,
              width: 64,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              clipBehavior: Clip.antiAlias,
              alignment: Alignment.centerLeft,
              child: Container(
                height: 24,
                width: audioLevelWidth,
                decoration: BoxDecoration(
                  color: Color.lerp(
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.error,
                    audioLevelWidth / 64,
                  ),
                ),
              ),
            ),
            Positioned(
              left: max(0, (config.voiceActivationThreshold + 60) / 60 * 64),
              child: Container(
                height: 24,
                width: 2,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
