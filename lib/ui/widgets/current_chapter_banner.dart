import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiefprompt/providers/current_chapter_provider.dart';

class CurrentChapterBanner extends ConsumerWidget {
  const CurrentChapterBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chapter = ref.watch(currentChapterProvider);

    if (chapter == null) return const SizedBox.shrink();

    final surface = Theme.of(context).colorScheme.onSurface;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          color: surface.withAlpha(120),
          border: Border(bottom: BorderSide(color: surface.withAlpha(180))),
        ),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              chapter,
              style: TextStyle(color: surface),
              textScaler: TextScaler.linear(2),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
