import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/providers/banner_provider.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/services/settings_storage_service.dart';
import 'package:tiefprompt/ui/widgets/app_settings.dart';

final importedSettingsJsonProvider = StateProvider<dynamic>((ref) => null);

class SettingsRestoreSetingsScreen extends ConsumerWidget {
  const SettingsRestoreSetingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return switch (settings) {
      AsyncData(:final value) => FutureBuilder(
        future: ref
            .watch(settingsStorageServiceProvider.notifier)
            .getSettings(),
        builder: (context, settingDisplayStream) {
          if (settingDisplayStream.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text(context.tr("SettingsScreen.SettingsRestore.Title")),
              ),
              body: Center(
                child: Text(
                  context.tr("SettingsScreen.SettingsRestore.LoadError"),
                ),
              ),
            );
          }

          if (!settingDisplayStream.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Text(context.tr("SettingsScreen.SettingsRestore.Title")),
              ),
              body: Center(child: CircularProgressIndicator()),
            );
          }

          return StreamBuilder(
            stream: settingDisplayStream.data,
            builder: (context, settingDisplays) {
              if (settingDisplays.hasError) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text(
                      context.tr("SettingsScreen.SettingsRestore.Title"),
                    ),
                  ),
                  body: Center(
                    child: Text(
                      context.tr("SettingsScreen.SettingsRestore.LoadError"),
                    ),
                  ),
                );
              }

              if (!settingDisplays.hasData) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text(
                      context.tr("SettingsScreen.SettingsRestore.Title"),
                    ),
                  ),
                  body: Center(child: CircularProgressIndicator()),
                );
              }

              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    context.tr("SettingsScreen.SettingsRestore.Title"),
                  ),
                ),
                body: ListView(
                  children: [
                    DialogAppSetting<SettingsState>(
                      feature: Feature.settingsRestore,
                      displayText: context.tr(
                        "SettingsScreen.SettingsRestore.Save",
                      ),
                      value: value,
                      onTap: (context, ref) async {
                        final name = await _showNameBottomSheet(
                          context,
                          titleText: context.tr(
                            "SettingsScreen.SettingsRestore.SaveDialog.Title",
                          ),
                          contentText: context.tr(
                            "SettingsScreen.SettingsRestore.SaveDialog.Content",
                          ),
                          hintText: context.tr(
                            "SettingsScreen.SettingsRestore.SaveDialog.HintText",
                          ),
                          cancelText: context.tr(
                            "SettingsScreen.SettingsRestore.SaveDialog.Cancel",
                          ),
                          saveText: context.tr(
                            "SettingsScreen.SettingsRestore.SaveDialog.Save",
                          ),
                        );

                        if (name.trim().isEmpty) {
                          ref
                              .read(bannerMessageProvider.notifier)
                              .state = context.tr(
                            "SettingsScreen.SettingsRestore.NameRequired",
                          );
                          return;
                        }

                        await ref
                            .read(settingsStorageServiceProvider.notifier)
                            .save(name.trim(), value);
                        ref.read(bannerMessageProvider.notifier).state = context
                            .tr("SettingsScreen.SettingsRestore.SaveSuccess");
                      },
                    ),
                    DialogAppSetting<SettingsState>(
                      feature: Feature.settingsRestore,
                      displayText: context.tr(
                        "SettingsScreen.SettingsRestore.Import",
                      ),
                      value: value,
                      dialogContent: _ImportSettingsDialog(value: value),
                      callback: () async {
                        final importedJson = ref.read(
                          importedSettingsJsonProvider,
                        );
                        if (importedJson == null) {
                          return;
                        }

                        final name =
                            (importedJson['name'] as String?)?.trim() ??
                            await _showNameBottomSheet(
                              context,
                              titleText: context.tr(
                                "SettingsScreen.SettingsRestore.NameSheet.Title",
                              ),
                              contentText: context.tr(
                                "SettingsScreen.SettingsRestore.NameSheet.Content",
                              ),
                              hintText: context.tr(
                                "SettingsScreen.SettingsRestore.SaveDialog.HintText",
                              ),
                              cancelText: context.tr(
                                "SettingsScreen.SettingsRestore.SaveDialog.Cancel",
                              ),
                              saveText: context.tr(
                                "SettingsScreen.SettingsRestore.SaveDialog.Save",
                              ),
                            );

                        if (name.trim().isEmpty) {
                          ref
                              .read(bannerMessageProvider.notifier)
                              .state = context.tr(
                            "SettingsScreen.SettingsRestore.NameRequired",
                          );
                          return;
                        }

                        try {
                          final settings = SettingsState.fromJson(
                            importedJson['settings'],
                          );

                          await ref
                              .read(settingsStorageServiceProvider.notifier)
                              .save(name.trim(), settings);

                          ref
                                  .read(importedSettingsJsonProvider.notifier)
                                  .state =
                              null;

                          ref
                              .read(bannerMessageProvider.notifier)
                              .state = context.tr(
                            "SettingsScreen.SettingsRestore.ImportSuccess",
                          );
                        } catch (_) {
                          ref
                              .read(bannerMessageProvider.notifier)
                              .state = context.tr(
                            "SettingsScreen.SettingsRestore.ImportFailed",
                          );
                        }
                      },
                    ),
                    Divider(height: 30, thickness: 3),
                    ...settingDisplays.data?.map(
                          (e) => ListTile(
                            title: Text(e.title),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(e.createdAt.toString()),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () => _showDeletionConfirmDialog(
                                    context,
                                    ref,
                                    e.title,
                                    e.id,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.more_horiz),
                                  onPressed: () => _showOptionsDialog(
                                    context,
                                    ref,
                                    e.title,
                                    e.id,
                                  ),
                                ),
                              ],
                            ),
                            onLongPress: () =>
                                _showOptionsDialog(context, ref, e.title, e.id),
                            onTap: () async {
                              try {
                                final settings = await ref
                                    .read(
                                      settingsStorageServiceProvider.notifier,
                                    )
                                    .loadSettings(e.id);
                                await ref
                                    .watch(settingsProvider.notifier)
                                    .loadSettings(settings);
                                ref
                                    .read(bannerMessageProvider.notifier)
                                    .state = context.tr(
                                  "SettingsScreen.SettingsRestore.RestoreSuccess",
                                );
                              } catch (_) {
                                ref
                                    .read(bannerMessageProvider.notifier)
                                    .state = context.tr(
                                  "SettingsScreen.SettingsRestore.RestoreFailed",
                                );
                              }
                            },
                          ),
                        ) ??
                        [],
                  ],
                ),
              );
            },
          );
        },
      ),
      AsyncLoading() => Scaffold(
        appBar: AppBar(
          title: Text(context.tr("SettingsScreen.KeybindingsSettings.Title")),
        ),
        body: SpinKitRing(
          color:
              ref.read(settingsProvider).value?.appPrimaryColor ??
              Color.fromARGB(255, 77, 103, 214),
        ),
      ),
      _ => Center(
        child: Column(
          children: [
            Text(
              "An error occurred loading the settings. Do you want to reset them?",
            ),
            ElevatedButton(
              onPressed: () =>
                  ref.read(settingsProvider.notifier).resetSettings(),
              child: Text("Reset Settings"),
            ),
          ],
        ),
      ),
    };
  }

  void _showOptionsDialog(
    BuildContext context,
    WidgetRef ref,
    String title,
    int id,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          context.tr("SettingsScreen.SettingsRestore.OptionsDialog.Title"),
        ),
        content: Column(
          children: [
            ListTile(
              title: Text(
                context.tr(
                  "SettingsScreen.SettingsRestore.OptionsDialog.Export",
                ),
              ),
              onTap: () async {
                try {
                  final exportedString = jsonEncode({
                    'schemaVersion': kSettingsSchemaVersion,
                    'name': await ref
                        .read(settingsStorageServiceProvider.notifier)
                        .getName(id),
                    'settings': SettingsState.toJson(
                      await ref
                          .read(settingsStorageServiceProvider.notifier)
                          .loadSettings(id),
                    ),
                  });
                  await FilePicker.platform.saveFile(
                    dialogTitle: context.tr(
                      "SettingsScreen.SettingsRestore.OptionsDialog.FilePickerTitle",
                    ),
                    allowedExtensions: ["json"],
                    type: FileType.custom,
                    bytes: Utf8Encoder().convert(exportedString),
                  );
                  ref.read(bannerMessageProvider.notifier).state = context.tr(
                    "SettingsScreen.SettingsRestore.ExportSuccess",
                  );
                  context.pop();
                } catch (_) {
                  ref.read(bannerMessageProvider.notifier).state = context.tr(
                    "SettingsScreen.SettingsRestore.ExportFailed",
                  );
                  context.pop();
                }
              },
            ),
            ListTile(
              title: Text(
                context.tr(
                  "SettingsScreen.SettingsRestore.OptionsDialog.Delete",
                ),
              ),
              onTap: () {
                _showDeletionConfirmDialog(
                  context,
                  ref,
                  title,
                  id,
                  cb: () => context.pop(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDeletionConfirmDialog(
    BuildContext context,
    WidgetRef ref,
    String title,
    int id, {
    Function()? cb,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          context.tr("SettingsScreen.SettingsRestore.DeleteDialog.Title"),
        ),
        content: SingleChildScrollView(
          child: Text(
            context.tr(
              "SettingsScreen.SettingsRestore.DeleteDialog.Content",
              args: [title],
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => context.pop(),
            child: Text(
              context.tr("SettingsScreen.SettingsRestore.DeleteDialog.Cancel"),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              ref
                  .watch(settingsStorageServiceProvider.notifier)
                  .deleteSettings(id);
              context.pop();
              if (cb != null) {
                cb();
              }
              ref.read(bannerMessageProvider.notifier).state = context.tr(
                "SettingsScreen.SettingsRestore.DeleteSuccess",
              );
            },
            child: Text(
              context.tr("SettingsScreen.SettingsRestore.DeleteDialog.Confirm"),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> _showNameBottomSheet(
    BuildContext context, {
    required String titleText,
    String? contentText,
    required String hintText,
    String? cancelText,
    required String saveText,
  }) async {
    final value = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (dialogContext) => _NameBottomSheet(
        titleText: titleText,
        contentText: contentText,
        hintText: hintText,
        cancelText: cancelText,
        saveText: saveText,
      ),
    );
    return value ?? '';
  }
}

class _NameBottomSheet extends StatefulWidget {
  final String titleText;
  final String? contentText;
  final String hintText;
  final String? cancelText;
  final String saveText;

  const _NameBottomSheet({
    required this.titleText,
    required this.hintText,
    required this.saveText,
    this.contentText,
    this.cancelText,
  });

  @override
  State<_NameBottomSheet> createState() => _NameBottomSheetState();
}

class _NameBottomSheetState extends State<_NameBottomSheet> {
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
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          16.0,
          16.0,
          16.0,
          MediaQuery.of(context).viewInsets.bottom + 16.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Text(widget.titleText),
            if (widget.contentText != null) Text(widget.contentText!),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: widget.hintText,
              ),
              controller: _controller,
              onChanged: (value) => setState(() {}),
              onSubmitted: (value) => _submit(context),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (widget.cancelText != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: TextButton(
                      onPressed: () => context.pop(),
                      child: Text(widget.cancelText!),
                    ),
                  ),
                ElevatedButton(
                  onPressed: _controller.text.trim().isEmpty
                      ? null
                      : () => _submit(context),
                  child: Text(widget.saveText),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _submit(BuildContext context) {
    context.pop(_controller.text.trim());
  }
}

class _ImportSettingsDialog extends ConsumerStatefulWidget {
  final SettingsState value;

  const _ImportSettingsDialog({required this.value});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ImportSettingsDialogState();
}

class _ImportSettingsDialogState extends ConsumerState<_ImportSettingsDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        context.tr("SettingsScreen.SettingsRestore.ImportSettings.Title"),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Text(
              context.tr(
                "SettingsScreen.SettingsRestore.ImportSettings.Content",
              ),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => context.pop(),
          child: Text(
            context.tr("SettingsScreen.SettingsRestore.ImportSettings.Cancel"),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            final resultFile = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['json'],
            );

            if (resultFile != null) {
              final file = resultFile.files.first;

              try {
                final fileContent = await File(file.path!).readAsString();
                final jsonContent = jsonDecode(fileContent);

                if (jsonContent['schemaVersion'] != kSettingsSchemaVersion) {
                  ref.read(bannerMessageProvider.notifier).state = context.tr(
                    "SettingsScreen.SettingsRestore.ImportSettings.InvalidVersion",
                  );
                  context.pop();
                  return;
                }

                if (jsonContent['settings'] == null) {
                  ref.read(bannerMessageProvider.notifier).state = context.tr(
                    "SettingsScreen.SettingsRestore.ImportFailed",
                  );
                  context.pop();
                  return;
                }

                ref.read(importedSettingsJsonProvider.notifier).state =
                    jsonContent;

                context.pop();
              } catch (_) {
                ref.read(bannerMessageProvider.notifier).state = context.tr(
                  "SettingsScreen.SettingsRestore.ImportFailed",
                );
                context.pop();
              }
            }
          },
          child: Text(
            context.tr("SettingsScreen.SettingsRestore.ImportSettings.Import"),
          ),
        ),
      ],
    );
  }
}
