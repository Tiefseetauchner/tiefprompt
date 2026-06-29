import 'package:drift/drift.dart' show Value;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tiefprompt/ui/widgets/safe_scaffold.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/core/debouncer.dart';
import 'package:tiefprompt/models/app_state.drift.dart';
import 'package:tiefprompt/providers/database_provider.dart';
import 'package:tiefprompt/providers/feature_provider.dart';
import 'package:tiefprompt/providers/prompter_provider.dart';
import 'package:tiefprompt/providers/script_provider.dart';
import 'package:tiefprompt/services/script_service.dart';
import 'package:tiefprompt/ui/widgets/changelog_modal.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late TextEditingController _scriptTextController;
  late TextEditingController _scriptTitleController;
  late final Debouncer _scriptChangeDebouncer;
  ProviderSubscription? _scriptListener;

  @override
  void initState() {
    super.initState();
    _scriptTextController = TextEditingController();
    _scriptTitleController = TextEditingController();
    _scriptChangeDebouncer = Debouncer(delay: Duration(milliseconds: 500));
    _runStartupChecks();
  }

  Future<void> _runStartupChecks() async {
    if (!mounted) return;

    final appState = await ref
        .read(databaseManagersProvider)
        .appStateModel
        .getSingle();

    await _checkChangelog(appState);
    _checkHelpRequest(appState);
  }

  void _checkHelpRequest(AppStateModelData appState) {
    if (!appState.helpRequestShown) {
      context.push("/helprequest");
    }
  }

  Future<void> _checkChangelog(AppStateModelData appState) async {
    final appStateVersion = appState.lastSeenVersion;
    final packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = packageInfo.version;

    if (appStateVersion == currentVersion) return;

    await showChangelogModal(context);

    await ref
        .read(databaseManagersProvider)
        .appStateModel
        .update((o) => o(lastSeenVersion: Value(currentVersion)));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _scriptListener?.close();
    _scriptListener = ref.listenManual(scriptProvider, (previous, next) {
      var scriptTextChanged =
          previous?.text != next.text &&
          _scriptTextController.text != next.text;
      var scriptTitleChanged =
          previous?.title != next.title &&
          _scriptTitleController.text != next.title;
      if ((scriptTextChanged || scriptTitleChanged) &&
          !_scriptTextController.value.composing.isValid) {
        final selection = TextSelection.collapsed(offset: next.text.length);
        _scriptTextController.value = TextEditingValue(
          text: next.text,
          selection: selection,
        );
        _scriptTitleController.value = TextEditingValue(text: next.title ?? "");
      }
    });
  }

  @override
  void dispose() {
    _scriptListener?.close();
    _scriptTextController.dispose();
    _scriptTitleController.dispose();
    _scriptChangeDebouncer.dispose();
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

    return SafeScaffold(
      appBar: AppBar(title: Text(context.tr("title"))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.tr("HomeScreen.TitleField_heading"),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: context.tr("HomeScreen.TitleField_hintText"),
                      hintStyle: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    controller: _scriptTitleController,
                    onChanged: (value) {
                      ref.read(scriptProvider.notifier).setTitle(value);
                      ref.read(scriptProvider.notifier).setIsSaved(false);
                      if (ref.read(scriptProvider).ephemeral) {
                        _scriptChangeDebouncer.run(_updateEphemeralScript);
                      }
                    },
                  ),
                  Text(
                    context.tr("HomeScreen.TextField_heading") +
                        (ref.watch(scriptProvider).isSaved ? "" : " *"),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  TextField(
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: context.tr("HomeScreen.TextField_hintText"),
                      hintStyle: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    maxLines: (MediaQuery.of(context).size.height / 70).floor(),
                    controller: _scriptTextController,
                    onChanged: (value) {
                      ref.read(scriptProvider.notifier).setText(value);
                      ref.read(scriptProvider.notifier).setIsSaved(false);
                      if (ref.read(scriptProvider).ephemeral) {
                        _scriptChangeDebouncer.run(_updateEphemeralScript);
                      }
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
                          if (ref.read(scriptProvider).isSaved) {
                            context.push('/open_file');
                          } else {
                            _showDiscardConfirmDialog(
                              () => context.push('/open_file'),
                            );
                          }
                        },
                        child: Text(
                          context.tr("HomeScreen.ElevatedButton_Select"),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (ref.read(scriptProvider).ephemeral) {
                            _saveCurrentScript();
                            ref
                                .read(scriptServiceProvider.notifier)
                                .createEphemeral();
                          } else {
                            await _showNewOrOverrideDialog();
                          }
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
              child: Column(
                spacing: 8.0,
                children: [
                  _BuildVersionNote(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.settings),
                        onPressed: () => context.push("/settings"),
                        tooltip: context.tr("HomeScreen.IconButton_Settings"),
                      ),
                      IconButton(
                        icon: Icon(Icons.code),
                        onPressed: () => _launchUrl(kRepoUrl),
                        tooltip: context.tr("HomeScreen.IconButton_SourceCode"),
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
                                      context.tr(
                                        "AboutDialog.Text_PrivacyText",
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () =>
                                          _launchUrl(kPrivacyPolicyUrl),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateEphemeralScript() {
    final script = ref.read(scriptProvider);
    ref.read(scriptServiceProvider.notifier).saveEphemeral(script);
  }

  Future<void> _launchUrl(String uri) async {
    final Uri url = Uri.parse(uri);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  void _showDiscardConfirmDialog(Function() confirmAction) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.tr("HomeScreen.DiscardConfirmDialog.Title")),
        content: Text(context.tr("HomeScreen.DiscardConfirmDialog.Body")),
        actions: [
          ElevatedButton(
            onPressed: () => context.pop(),
            child: Text(context.tr("HomeScreen.DiscardConfirmDialog.Cancel")),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            onPressed: () {
              context.pop();
              confirmAction();
            },
            child: Text(context.tr("HomeScreen.DiscardConfirmDialog.Confirm")),
          ),
        ],
      ),
    );
  }

  Future<void> _showNewOrOverrideDialog() async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.tr("HomeScreen.NewOrOverrideDialog.Title")),
        actions: [
          ElevatedButton(
            onPressed: () async {
              await _saveCurrentScriptAsNew();
              context.pop();
            },
            child: Text(context.tr("HomeScreen.NewOrOverrideDialog.NewScript")),
          ),
          ElevatedButton(
            onPressed: () async {
              await _saveCurrentScript();
              context.pop();
            },
            child: Text(
              context.tr("HomeScreen.NewOrOverrideDialog.OverrideScript"),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveCurrentScriptAsNew() async {
    final scriptService = ref.read(scriptServiceProvider.notifier);
    final currentScript = ref.read(scriptProvider);
    final scriptProviderNotifier = ref.read(scriptProvider.notifier);

    final savedScriptId = await scriptService.saveAsNew(currentScript);

    scriptProviderNotifier.loadScript(
      await scriptService.loadScript(savedScriptId),
    );
    scriptProviderNotifier.setEphemeral(false);
    scriptProviderNotifier.setIsSaved(true);
  }

  Future<int> _saveCurrentScript() async {
    final scriptService = ref.read(scriptServiceProvider.notifier);
    final currentScript = ref.read(scriptProvider);
    final scriptProviderNotifier = ref.read(scriptProvider.notifier);

    final savedScriptId = await scriptService.save(currentScript);

    scriptProviderNotifier.setEphemeral(false);
    scriptProviderNotifier.setIsSaved(true);
    scriptProviderNotifier.setId(savedScriptId);

    return savedScriptId;
  }
}

class _BuildVersionNote extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appFeatures = ref.watch(featuresProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (dialogContext) {
                return AlertDialog(
                  title: Text(
                    switch (appFeatures.featureKind) {
                      FeatureKind.fossVersion => context.tr(
                        "HomeScreen.FossVersion",
                      ),
                      FeatureKind.freeVersion => context.tr(
                        "HomeScreen.FreeVersion",
                      ),
                      FeatureKind.paidVersion => context.tr(
                        "HomeScreen.PaidVersion",
                      ),
                      FeatureKind.unverifiedBuild => context.tr(
                        "HomeScreen.UnverifiedBuild",
                      ),
                    },
                    style: TextStyle(
                      color:
                          appFeatures.featureKind == FeatureKind.unverifiedBuild
                          ? Colors.red
                          : null,
                    ),
                  ),
                  content: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 10,
                      children: [
                        Text(switch (appFeatures.featureKind) {
                          FeatureKind.fossVersion => context.tr(
                            "HomeScreen.FossVersion_Explanation",
                          ),
                          FeatureKind.freeVersion => context.tr(
                            "HomeScreen.FreeVersion_Explanation",
                          ),
                          FeatureKind.paidVersion => context.tr(
                            "HomeScreen.PaidVersion_Explanation",
                          ),
                          FeatureKind.unverifiedBuild => context.tr(
                            "HomeScreen.UnverifiedBuild_Explanation",
                          ),
                        }),
                        if (appFeatures.featureKind == FeatureKind.freeVersion)
                          ElevatedButton(
                            onPressed: () => context.push("/disabledfeature"),
                            child: Text("Buy the Pro Version"),
                          ),
                        ElevatedButton(
                          onPressed: () => _launchUrl(kRepoUrl),
                          child: Text(kRepoUrl),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => dialogContext.pop(),
                      child: Text(context.tr("HomeScreen.Understood")),
                    ),
                  ],
                );
              },
            );
          },
          child: Text(switch (appFeatures.featureKind) {
            FeatureKind.fossVersion => context.tr("HomeScreen.FossVersion"),
            FeatureKind.freeVersion => context.tr("HomeScreen.FreeVersion"),
            FeatureKind.paidVersion => context.tr("HomeScreen.PaidVersion"),
            FeatureKind.unverifiedBuild => context.tr(
              "HomeScreen.UnverifiedBuild",
            ),
          }),
        ),
      ],
    );
  }

  Future<void> _launchUrl(String uri) async {
    final Uri url = Uri.parse(uri);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
