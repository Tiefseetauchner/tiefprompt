import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/services/settings_storage_service.dart';
import 'package:tiefprompt/ui/widgets/app_settings.dart';

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
        builder: (context, settingDisplayStream) => StreamBuilder(
          stream: settingDisplayStream.data,
          builder: (context, settingDisplays) => Scaffold(
            appBar: AppBar(
              title: Text(context.tr("SettingsScreen.SettingsRestore.Title")),
            ),
            body: ListView(
              children: [
                DialogAppSetting(
                  feature: Feature.settingsRestore,
                  displayText: context.tr(
                    "SettingsScreen.SettingsRestore.Save",
                  ),
                  dialogContent: (context) => _SaveSettingsDialog(value: value),
                ),
                DialogAppSetting(
                  feature: Feature.settingsRestore,
                  displayText: context.tr(
                    "SettingsScreen.SettingsRestore.Import",
                  ),
                  dialogContent: (context) =>
                      _ImportSettingsDialog(value: value),
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
                        onTap: () async => ref
                            .watch(settingsProvider.notifier)
                            .loadSettings(
                              await ref
                                  .read(settingsStorageServiceProvider.notifier)
                                  .loadSettings(e.id),
                            ),
                      ),
                    ) ??
                    [],
              ],
            ),
          ),
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
                final exportedBytes = jsonEncode({
                  'schemaVersion': kSettingsSchemaVersion,
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
                  bytes: Uint8List.fromList(exportedBytes.runes.toList()),
                );
                context.pop();
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
            },
            child: Text(
              context.tr("SettingsScreen.SettingsRestore.DeleteDialog.Confirm"),
            ),
          ),
        ],
      ),
    );
  }
}

class _SaveSettingsDialog extends ConsumerStatefulWidget {
  final SettingsState value;

  const _SaveSettingsDialog({required this.value});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SaveSettingsDialogState();
}

class _SaveSettingsDialogState extends ConsumerState<_SaveSettingsDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        context.tr("SettingsScreen.SettingsRestore.SaveDialog.Title"),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Text(
              context.tr("SettingsScreen.SettingsRestore.SaveDialog.Content"),
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: context.tr(
                  "SettingsScreen.SettingsRestore.SaveDialog.HintText",
                ),
              ),
              controller: _controller,
              onChanged: (value) => setState(() {}),
              onSubmitted: (value) => _saveSettings(context),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => context.pop(),
          child: Text(
            context.tr("SettingsScreen.SettingsRestore.SaveDialog.Cancel"),
          ),
        ),
        ElevatedButton(
          onPressed: _controller.text.trim().isEmpty
              ? null
              : () => _saveSettings(context),
          child: Text(
            context.tr("SettingsScreen.SettingsRestore.SaveDialog.Save"),
          ),
        ),
      ],
    );
  }

  void _saveSettings(BuildContext context) {
    final settingsService = ref.watch(settingsStorageServiceProvider.notifier);

    ref.read(settingsProvider).whenData((data) {
      settingsService.save(_controller.text, data);
      context.pop();
    });
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

            throw UnimplementedError();
          },
          child: Text(
            context.tr("SettingsScreen.SettingsRestore.ImportSettings.Import"),
          ),
        ),
      ],
    );
  }
}
