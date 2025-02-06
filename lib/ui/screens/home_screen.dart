import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiefprompt/models/script.dart';
import 'package:tiefprompt/providers/script_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final script = Script();

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
                controller: TextEditingController(text: script.text),
                onChanged: (value) {
                  script.text = value;
                }),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(scriptProvider.notifier).state = script;
                context.push('/teleprompter');
              },
              child: const Text('Start Teleprompter'),
            ),
          ],
        ),
      ),
    );
  }
}
