import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiefprompt/providers/prompter_provider.dart';
import 'package:tiefprompt/providers/settings_provider.dart';

final fontSettingsVisibleProvider = StateProvider<bool>((ref) => false);

class PrompterBottomBar extends ConsumerWidget {
  const PrompterBottomBar({
    super.key,
  });

  List<Widget> _getWidgetButtons(
      BuildContext context, WidgetRef ref, PrompterState prompterState) {
    final fontSettingsVisible = ref.watch(fontSettingsVisibleProvider);

    return [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          VerticalDivider(
            width: 50,
          ),
          IconButton(
            icon: Icon(Icons.save,
                color: Theme.of(context).colorScheme.onPrimary),
            onPressed: () => ref
                .read(settingsProvider.notifier)
                .applySettingsFromPrompter(prompterState),
          ),
          VerticalDivider(
            width: 15,
          ),
        ],
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          VerticalDivider(
            width: 15,
          ),
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
            width: 15,
          ),
        ],
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          VerticalDivider(
            width: 15,
          ),
          IconButton(
            icon: Icon(Icons.remove,
                color: Theme.of(context).colorScheme.onPrimary),
            onPressed: () =>
                ref.read(prompterProvider.notifier).decreaseSpeed(.1),
          ),
          IconButton(
            icon: Icon(prompterState.isPlaying ? Icons.pause : Icons.play_arrow,
                color: Theme.of(context).colorScheme.onPrimary),
            onPressed: () =>
                ref.read(prompterProvider.notifier).togglePlayPause(),
          ),
          IconButton(
            icon:
                Icon(Icons.add, color: Theme.of(context).colorScheme.onPrimary),
            onPressed: () =>
                ref.read(prompterProvider.notifier).increaseSpeed(.1),
          ),
          VerticalDivider(
            width: 15,
          ),
        ],
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          VerticalDivider(
            width: 15,
          ),
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.text_format,
                    color: Theme.of(context).colorScheme.onPrimary),
                onPressed: () => ref
                    .read(fontSettingsVisibleProvider.notifier)
                    .state = !fontSettingsVisible,
              ),
            ],
          ),
          VerticalDivider(
            width: 15,
          ),
        ],
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          VerticalDivider(
            width: 15,
          ),
          IconButton(
            icon: Icon(Icons.settings,
                color: Theme.of(context).colorScheme.onPrimary),
            onPressed: () => context.push("/settings"),
          ),
          VerticalDivider(
            width: 50,
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prompterState = ref.watch(prompterProvider);
    final fontSettingsVisible = ref.watch(fontSettingsVisibleProvider);

    return Stack(
      children: [
        if (fontSettingsVisible) Positioned(child: _FontSettingsDialog()),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSecondary.withAlpha(120),
            ),
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            child: Stack(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _getWidgetButtons(context, ref, prompterState),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Column(
                    children: [
                      Text(
                        "${prompterState.speed.toStringAsFixed(1)}x",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                      Text(
                        "F: ${prompterState.fontSize.toStringAsFixed(1)}",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _FontSettingsDialog extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prompter = ref.watch(prompterProvider);

    return SimpleDialog(
      title: Text("Font Settings", style: TextStyle(fontSize: 18)),
      alignment: Alignment(1, 0),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text("F: ${prompter.fontSize.toStringAsFixed(1)}"),
                  IconButton(
                    icon: Icon(Icons.text_increase,
                        color: Theme.of(context).colorScheme.primary),
                    onPressed: () => ref
                        .read(prompterProvider.notifier)
                        .increaseFontSize(20),
                  ),
                  IconButton(
                    icon: Icon(Icons.text_decrease,
                        color: Theme.of(context).colorScheme.primary),
                    onPressed: () => ref
                        .read(prompterProvider.notifier)
                        .decreaseFontSize(20),
                  ),
                ],
              ),
              Row(
                children: [
                  DropdownButton(
                      items: [
                        DropdownMenuItem(
                          value: "Roboto",
                          child: Text("Roboto"),
                        ),
                        DropdownMenuItem(
                          value: "OpenDyslexic",
                          child: Text("OpenDyslexic"),
                        ),
                      ],
                      onChanged: (value) => ref
                          .read(prompterProvider.notifier)
                          .setFontFamily(value ?? 'Roboto')),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
