import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiefprompt/core/constants.dart';
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

    LicenseRegistry.addLicense(() async* {
      final openDyslexicLicense = await rootBundle
          .loadString('assets/licenses/openDyslexicLicense.txt');
      yield LicenseEntryWithLineBreaks(['OpenDyslexic'], openDyslexicLicense);
      final robotoLicense =
          await rootBundle.loadString('assets/licenses/robotoLicense.txt');
      yield LicenseEntryWithLineBreaks(['roboto'], robotoLicense);
      final robotoMonoLicense =
          await rootBundle.loadString('assets/licenses/robotoMonoLicense.txt');
      yield LicenseEntryWithLineBreaks(['roboto mono'], robotoMonoLicense);
      final robotoSlabLicense =
          await rootBundle.loadString('assets/licenses/robotoSlabLicense.txt');
      yield LicenseEntryWithLineBreaks(['roboto slab'], robotoSlabLicense);
    });

    return Scaffold(
      appBar: AppBar(title: const Text('TiefPrompt')),
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
                          showModalBottomSheet(
                              context: context,
                              builder: (dialogContext) {
                                return Padding(
                                  padding: EdgeInsets.fromLTRB(
                                    16.0,
                                    16.0,
                                    16.0,
                                    MediaQuery.of(context).viewInsets.bottom +
                                        16.0,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
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
                                    ],
                                  ),
                                );
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
                    onPressed: () => _launchUrl(
                        "https://github.com/tiefseetauchner/tiefprompt"),
                  ),
                  IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () => showAboutDialog(
                      context: context,
                      applicationName: 'TiefPrompt',
                      applicationLegalese:
                          'Copyright © 2025 Lena Tauchner\nAll rights reserved.\n\nThis project is licensed under the MIT License. See the LICENSE file for details.',
                      applicationVersion: kApplicationVersion,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 8,
                            children: [
                              Text(
                                  "This application does not collect any personal data. No data is shared with third parties as far as I know. Read more about our privacy policy."),
                              ElevatedButton(
                                  onPressed: () => _launchUrl(
                                      "https://www.lukechriswalker.at/projects/fe5a26d763326489020000a4"),
                                  child: Text("Privacy Policy")),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String uri) async {
    final Uri url = Uri.parse(uri);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
