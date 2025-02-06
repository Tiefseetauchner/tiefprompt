import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiefprompt/providers/prompter_provider.dart';
import 'package:tiefprompt/providers/script_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final script = ref.watch(scriptProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Teleprompter')),
      body: Padding(
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
                controller: TextEditingController(text: script.text)
                  ..selection =
                      TextSelection.collapsed(offset: script.text.length),
                onChanged: (value) {
                  ref.read(scriptProvider.notifier).setText(value);
                }),
            const SizedBox(height: 16),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
    );
  }
}
