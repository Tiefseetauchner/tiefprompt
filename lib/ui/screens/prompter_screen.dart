import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiefprompt/providers/prompter_provider.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/ui/widgets/prompter_bottom_bar.dart';
import 'package:tiefprompt/ui/widgets/prompter_top_bar.dart';
import 'package:tiefprompt/ui/widgets/scrollable_text.dart';
import 'package:tiefprompt/providers/script_provider.dart';

final controlsVisibleProvider = StateProvider<bool>((ref) => true);

class PrompterScreen extends ConsumerWidget {
  const PrompterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final script = ref.watch(scriptProvider);
    final controlsVisible = ref.watch(controlsVisibleProvider);
    final settings = ref.watch(settingsProvider);

    settings.whenData((settingsState) {
      ref.read(prompterProvider.notifier).setSpeed(settingsState.scrollSpeed);
    });

    return Scaffold(
        body: Stack(fit: StackFit.expand, children: [
      GestureDetector(
        onTap: () {
          ref.read(controlsVisibleProvider.notifier).state = !controlsVisible;
        },
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ScrollableText(
              text: script.text,
              style: const TextStyle(fontSize: 80),
            )),
      ),
      if (controlsVisible) PrompterTopBar(),
      if (controlsVisible) PrompterBottomBar(),
    ]));
  }
}
