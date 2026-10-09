import 'dart:math' as math;

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
      builder: (context, audioLevelSnapshot) {
        if (!audioLevelSnapshot.hasData) {
          return SizedBox.shrink();
        }

        // NOTE: audioLevel is a double from -infinity (silence) to 0 (max)
        //       To convert to the width, we need to normalize it to a range of 0 to 1.
        //       Then we can multiply it by the maximum width (64) to get the actual width.
        //       We also need to consider that the audio level might be -infinity, so we clamp it to a minimum value.
        final double audioLevelWidth = getWidthFromAudioLevel(
          audioLevelSnapshot.data,
        );

        return Stack(
          children: [
            Container(
              width: 64,
              height: 24,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
                border:
                    (audioLevelSnapshot.data ?? -60) >=
                        config.voiceActivationThreshold
                    ? Border.symmetric(
                        horizontal: BorderSide(
                          strokeAlign: BorderSide.strokeAlignOutside,
                          style: BorderStyle.solid,
                          color: Theme.of(context).colorScheme.onSurface,
                          width: 2,
                        ),
                      )
                    : null,
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
              left: getWidthFromAudioLevel(config.voiceActivationThreshold),
              child: Container(
                height: 24,
                width: 2,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
            Positioned(
              left: 3,
              top: 3,
              child: Text(
                "${audioLevelSnapshot.data?.round()}db",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  double getWidthFromAudioLevel(double? audioLevel) {
    return math.max(0, ((audioLevel ?? -60) + 60) / 60 * 64);
  }
}
