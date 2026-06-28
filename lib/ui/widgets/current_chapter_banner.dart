import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiefprompt/providers/current_chapter_provider.dart';
import 'package:tiefprompt/providers/prompter_provider.dart';

class CurrentChapterBanner extends ConsumerWidget {
  final EdgeInsets? offset;

  const CurrentChapterBanner({super.key, this.offset});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chapter = ref.watch(currentChapterProvider);
    final prompter = ref.watch(prompterProvider);

    if (chapter == null) return const SizedBox.shrink();

    final onSurface = Theme.of(context).colorScheme.onSurface;
    final canvas = Theme.of(context).canvasColor;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: offset,
        child: Container(
          decoration: BoxDecoration(
            color: canvas.withAlpha(120),
            border: Border(bottom: BorderSide(color: onSurface.withAlpha(180))),
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal:
                    16 +
                    (MediaQuery.of(context).size.width / 2) *
                        (prompter.sideMargin / 100),
                vertical: 8,
              ),
              child: Text(
                chapter,
                style: TextStyle(
                  color: onSurface,
                  fontFamily: prompter.fontFamily,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: prompter.alignment,
                textScaler: TextScaler.linear(2),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
