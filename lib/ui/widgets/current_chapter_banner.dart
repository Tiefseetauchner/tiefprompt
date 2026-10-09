import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiefprompt/providers/current_chapter_provider.dart';
import 'package:tiefprompt/providers/prompter_provider.dart';
import 'package:tiefprompt/ui/widgets/scrollable_text.dart';

class CurrentChapterBanner extends ConsumerWidget {
  final EdgeInsets? offset;
  final ScrollableTextController scrollableTextController;

  const CurrentChapterBanner({
    super.key,
    this.offset,
    required this.scrollableTextController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chapter = ref.watch(currentChapterProvider);
    final (:mirroredX, :mirroredY, :sideMargin, :fontFamily, :alignment) = ref
        .watch(
          prompterProvider.select(
            (p) => (
              mirroredX: p.config.mirroredX,
              mirroredY: p.config.mirroredY,
              sideMargin: p.config.sideMargin,
              fontFamily: p.config.fontFamily,
              alignment: p.config.alignment,
            ),
          ),
        );

    if (chapter == null) return const SizedBox.shrink();

    final onSurface = Theme.of(context).colorScheme.onSurface;
    final canvas = Theme.of(context).canvasColor;
    final borderSide = BorderSide(color: onSurface.withAlpha(180));

    return Positioned(
      top: mirroredY ? null : (offset?.top ?? 0),
      bottom: mirroredY ? (offset?.top ?? 0) : null,
      left: 0,
      right: 0,
      child: GestureDetector(
        onTap: () {
          scrollableTextController.jumpTo(chapter.chapterOffset);
        },
        child: Container(
          decoration: BoxDecoration(
            color: canvas.withAlpha(120),
            border: Border(
              bottom: mirroredY ? BorderSide.none : borderSide,
              top: mirroredY ? borderSide : BorderSide.none,
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal:
                    16 +
                    (MediaQuery.of(context).size.width / 2) *
                        (sideMargin / 100),
                vertical: 8,
              ),
              child: Transform.flip(
                flipX: mirroredX,
                flipY: mirroredY,
                child: Text(
                  chapter.chapterText,
                  style: TextStyle(
                    color: onSurface,
                    fontFamily: fontFamily,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: alignment,
                  textScaler: TextScaler.linear(2),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
