import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiefprompt/providers/prompter_provider.dart';
import 'package:tiefprompt/providers/script_provider.dart';
import 'package:tiefprompt/services/script_service.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final script = ref.watch(scriptProvider);
    _controller.text = script.text;

    return Scaffold(
      appBar: AppBar(title: const Text('Teleprompter')),
      body: SingleChildScrollView(
        child: Column(
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
                    maxLines: (MediaQuery.of(context).size.height / 70).floor(),
                    controller: _controller,
                    onChanged: (value) {
                      // Update script text when user changes screen
                      ref.read(scriptProvider.notifier).setText(value);
                    },
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 16,
                    runSpacing: 16,
                    direction: Axis.horizontal,
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
                      ElevatedButton(
                        onPressed: () {
                          showAdaptiveDialog(
                              context: context,
                              builder: (dialogContext) {
                                return Column(children: [
                                  Text('Save Script'),
                                  TextField(
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter script name',
                                    ),
                                    onChanged: (value) => ref
                                        .read(scriptProvider.notifier)
                                        .setTitle(value),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      ScriptService()
                                          .save(ref.watch(scriptProvider));
                                      dialogContext.pop();
                                    },
                                    child: const Text('Save'),
                                  ),
                                ]);
                              });
                        },
                        child: const Text('Save Script'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () => context.push("/settings"),
                  ),
                  IconButton(
                    icon: Icon(Icons.code),
                    onPressed: () => _launchUrl(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse('https://github.com/tiefseetauchner/tiefprompt');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
