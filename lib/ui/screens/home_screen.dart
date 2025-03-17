import 'package:easy_localization/easy_localization.dart';
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
      appBar: AppBar(title: Text(context.tr("title"))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: context.tr("HomeScreen.TextField_hintText"),
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
                        child: Text(
                          context.tr("HomeScreen.ElevatedButton_Start"),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.push('/open_file');
                        },
                        child: Text(
                          context.tr("HomeScreen.ElevatedButton_Select"),
                        ),
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
                                    Text(
                                      context.tr(
                                          "HomeScreen.BottomSheet.Text_Title"),
                                    ),
                                    TextField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: context.tr(
                                            "HomeScreen.BottomSheet.TextField_hintText"),
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
                                      child: Text(
                                        context.tr(
                                            "HomeScreen.BottomSheet.ElevatedButton_Save"),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Text(
                          context.tr('HomeScreen.ElevatedButton_Save'),
                        ),
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
                    tooltip: context.tr("HomeScreen.IconButton_Settings"),
                  ),
                  IconButton(
                    icon: Icon(Icons.code),
                    onPressed: () => _launchUrl(
                        "https://github.com/tiefseetauchner/tiefprompt"),
                    tooltip: context.tr("HomeScreen.IconButton_SourceCode"),
                  ),
                  IconButton(
                    icon: Icon(Icons.info),
                    tooltip: context.tr("HomeScreen.IconButton_About"),
                    onPressed: () => showAboutDialog(
                      context: context,
                      applicationName: context.tr("title"),
                      applicationLegalese: context.tr("copyright"),
                      applicationVersion: kApplicationVersion,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 8,
                            children: [
                              Text(context.tr("AboutDialog.Text_PrivacyText")),
                              ElevatedButton(
                                onPressed: () => _launchUrl(
                                    "https://www.lukechriswalker.at/projects/fe5a26d763326489020000a4"),
                                child: Text(
                                  context
                                      .tr("AboutDialog.ElevatedButton_Privacy"),
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
