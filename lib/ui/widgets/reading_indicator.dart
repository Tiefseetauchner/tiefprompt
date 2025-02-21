import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiefprompt/providers/prompter_provider.dart';

class ReadingIndicator extends ConsumerWidget {
  const ReadingIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prompter = ref.watch(prompterProvider);

    return IgnorePointer(
      child: Stack(
        children: [
          if (prompter.displayReadingIndicatorBoxes)
            Positioned(top: 0, left: 0, right: 0, child: ReadingIndicatorBox()),
          if (prompter.displayReadingIndicatorBoxes)
            Positioned(
                bottom: 0, left: 0, right: 0, child: ReadingIndicatorBox()),
        ],
      ),
    );
  }
}

class ReadingIndicatorBox extends ConsumerWidget {
  const ReadingIndicatorBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prompter = ref.watch(prompterProvider);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height *
          (prompter.readingIndicatorBoxesHeight / 200),
      child: Container(
        color: Theme.of(context).colorScheme.onSecondary.withAlpha(60),
      ),
    );
  }
}
