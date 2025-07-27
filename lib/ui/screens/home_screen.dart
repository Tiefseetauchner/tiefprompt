import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
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
  ProviderSubscription? _scriptListener;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _scriptListener?.close();
    _scriptListener = ref.listenManual(scriptProvider, (previous, next) {
      if (previous?.text != next.text &&
          _controller.text != next.text &&
          !_controller.value.composing.isValid) {
        final selection = TextSelection.collapsed(offset: next.text.length);
        _controller.value = TextEditingValue(
          text: next.text,
          selection: selection,
        );
      }
    });
  }

  @override
  void dispose() {
    _scriptListener?.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LicenseRegistry.addLicense(() async* {
      final openDyslexicLicense = await rootBundle.loadString(
        'assets/licenses/openDyslexicLicense.txt',
      );
      yield LicenseEntryWithLineBreaks(['OpenDyslexic'], openDyslexicLicense);
      final robotoLicense = await rootBundle.loadString(
        'assets/licenses/robotoLicense.txt',
      );
      yield LicenseEntryWithLineBreaks(['roboto'], robotoLicense);
      final robotoMonoLicense = await rootBundle.loadString(
        'assets/licenses/robotoMonoLicense.txt',
      );
      yield LicenseEntryWithLineBreaks(['roboto mono'], robotoMonoLicense);
      final robotoSlabLicense = await rootBundle.loadString(
        'assets/licenses/robotoSlabLicense.txt',
      );
      yield LicenseEntryWithLineBreaks(['roboto slab'], robotoSlabLicense);
    });

    Future<PackageInfo> packageInfo = PackageInfo.fromPlatform();

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
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: context.tr("HomeScreen.TextField_hintText"),
                    ),
                    // textInputAction: TextInputAction.newline,
                    maxLines: (MediaQuery.of(context).size.height / 70).floor(),
                    controller: _controller,
                    onChanged: (value) {
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
                            isScrollControlled: true,
                            builder: (dialogContext) {
                              return SafeArea(
                                child: Padding(
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
                                          "HomeScreen.BottomSheet.Text_Title",
                                        ),
                                      ),
                                      TextField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: context.tr(
                                            "HomeScreen.BottomSheet.TextField_hintText",
                                          ),
                                        ),
                                        onChanged: (value) => ref
                                            .read(scriptProvider.notifier)
                                            .setTitle(value),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          ScriptService().save(
                                            ref.watch(scriptProvider),
                                          );
                                          dialogContext.pop();
                                        },
                                        child: Text(
                                          context.tr(
                                            "HomeScreen.BottomSheet.ElevatedButton_Save",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 16.0,
              ),
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
                      "https://github.com/tiefseetauchner/tiefprompt",
                    ),
                    tooltip: context.tr("HomeScreen.IconButton_SourceCode"),
                  ),
                  IconButton(
                    icon: Icon(Icons.crisis_alert),
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        actions: [],
                        title: Text(context.tr("HelpDialog.Title")),
                        content: SingleChildScrollView(
                          child: Row(
                            children: [
                              Text(context.tr("HelpDialog.Text.Intro")),
                              Text(context.tr("HelpDialog.Text.Translation")),
                              ElevatedButton(
                                onPressed: () => _launchUrl(
                                  "https://hosted.weblate.org/projects/tiefprompt/",
                                ),
                                child: Text(context.tr("HelpDialog.Weblate")),
                              ),
                              Text(
                                context.tr("HelpDialog.Text.JoinTesterGroup"),
                              ),
                              ElevatedButton(
                                onPressed: () => _launchUrl(
                                  "https://groups.google.com/g/tiefprompt",
                                ),
                                child: Text(context.tr("HelpDialog.TesterGrp")),
                              ),
                              Text(context.tr("HelpDialog.Text.Contribute")),
                              ElevatedButton(
                                onPressed: () => _launchUrl(
                                  "https://github.com/Tiefseetauchner/tiefprompt",
                                ),
                                child: Text(context.tr("HelpDialog.Github")),
                              ),
                              Text(context.tr("HelpDialog.Text.Outro")),
                            ],
                          ),
                        ),
                      ),
                    ),
                    tooltip: context.tr("HomeScreen.IconButton_FullRelease"),
                  ),
                  FutureBuilder(
                    future: packageInfo,
                    builder: (buildContext, packageInfo) => IconButton(
                      icon: Icon(Icons.info),
                      tooltip: context.tr("HomeScreen.IconButton_About"),
                      onPressed: () => showAboutDialog(
                        context: context,
                        applicationName: context.tr("title"),
                        applicationLegalese:
                            "${context.tr("copyright")}\n${context.tr("credits")}",
                        applicationVersion:
                            "${packageInfo.data?.version} (Build ${packageInfo.data?.buildNumber})",
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 8,
                              children: [
                                Text(
                                  context.tr("AboutDialog.Text_PrivacyText"),
                                ),
                                ElevatedButton(
                                  onPressed: () => _launchUrl(
                                    "https://www.lukechriswalker.at/projects/fe5a26d763326489020000a4",
                                  ),
                                  child: Text(
                                    context.tr(
                                      "AboutDialog.ElevatedButton_Privacy",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
