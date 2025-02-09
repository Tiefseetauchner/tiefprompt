import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiefprompt/providers/prompter_provider.dart';
import 'package:tiefprompt/providers/script_provider.dart';
import 'package:tiefprompt/providers/settings_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final script = ref.watch(scriptProvider);
    final settings = ref.watch(settingsProvider);

    return Scaffold(
        appBar: AppBar(title: const Text('Teleprompter')),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter script text',
                      ),
                      maxLines: 5,
                      controller: TextEditingController(text: script.text),
                      onChanged: (value) {
                        ref.read(scriptProvider.notifier).setText(value);
                      }),
                  const SizedBox(height: 16),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            ref.invalidate(prompterProvider);
                            context.push('/teleprompter');
                          },
                          child: const Text('Start Teleprompter'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            context.push('/open_file');
                          },
                          child: const Text('Select Script from Device'),
                        ),
                      ]),
                ],
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: Icon(Icons.settings),
                            onPressed: () => context.push("/settings"),
                          ),
                        ])))
          ],
        ));
  }
}
