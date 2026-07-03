import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:tiefprompt/ui/widgets/safe_scaffold.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/models/keybinding.dart';
import 'package:tiefprompt/providers/banner_provider.dart';
import 'package:tiefprompt/providers/talker_provider.dart';
import 'package:tiefprompt/providers/keybinding_provider.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/services/settings_storage_service.dart';
import 'package:tiefprompt/ui/widgets/app_settings.dart';
import 'package:tiefprompt/ui/widgets/async_settings_builder.dart';

class _ImportedSettingsJson extends Notifier<dynamic> {
  @override
  dynamic build() => null;
  void setValue(dynamic v) => state = v;
}

final importedSettingsJsonProvider =
    NotifierProvider<_ImportedSettingsJson, dynamic>(_ImportedSettingsJson.new);

class SettingsRestoreScreen extends ConsumerWidget {
  const SettingsRestoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncSettingsBuilder(
      state: ref.watch(settingsProvider),
      screenTitle: context.tr("SettingsScreen.SettingsRestore.Title"),
      builder: (ref, value) => _SettingsRestoreView(settings: value),
    );
  }
}

class _SettingsRestoreView extends ConsumerWidget {
  final SettingsState settings;

  const _SettingsRestoreView({required this.settings});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entriesStream = ref
        .watch(settingsStorageServiceProvider.notifier)
        .getSettingDisplayData();

    return SafeScaffold(
      appBar: AppBar(
        title: Text(context.tr("SettingsScreen.SettingsRestore.Title")),
      ),
      body: StreamBuilder(
        stream: entriesStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                context.tr("SettingsScreen.SettingsRestore.LoadError"),
              ),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: SpinKitRing(color: settings.appPrimaryColor),
            );
          }

          return ListView(
            children: [
              DialogAppSetting(
                feature: Feature.settingsRestore,
                displayText: context.tr("SettingsScreen.SettingsRestore.Save"),
                onTap: _saveSettings,
              ),
              DialogAppSetting(
                feature: Feature.settingsRestore,
                displayText: context.tr("SettingsScreen.SettingsRestore.Import"),
                dialogContent: const _ImportSettingsDialog(),
                callback: () => _importSettings(context, ref),
              ),
              Divider(height: 30, thickness: 3),
              ...snapshot.data!.map((e) => _SavedSettingsTile(entry: e)),
            ],
          );
        },
      ),
    );
  }

  Future<void> _saveSettings(BuildContext context, WidgetRef ref) async {
    final name = await _showNameBottomSheet(
      context,
      titleText: context.tr("SettingsScreen.SettingsRestore.SaveDialog.Title"),
      contentText: context.tr(
        "SettingsScreen.SettingsRestore.SaveDialog.Content",
      ),
      hintText: context.tr(
        "SettingsScreen.SettingsRestore.SaveDialog.HintText",
      ),
      cancelText: context.tr(
        "SettingsScreen.SettingsRestore.SaveDialog.Cancel",
      ),
      saveText: context.tr("SettingsScreen.SettingsRestore.SaveDialog.Save"),
    );

    if (name.trim().isEmpty) {
      ref
          .read(bannerMessageProvider.notifier)
          .set(context.tr("SettingsScreen.SettingsRestore.NameRequired"));
      return;
    }

    final keybindingMapId = await ref
        .read(keybindingsProvider.notifier)
        .createKeybindingsMap(await ref.read(keybindingsProvider.future));

    await ref
        .read(settingsStorageServiceProvider.notifier)
        .save(name.trim(), settings, keybindingMapId);
    ref
        .read(bannerMessageProvider.notifier)
        .set(context.tr("SettingsScreen.SettingsRestore.SaveSuccess"));
  }

  Future<void> _importSettings(BuildContext context, WidgetRef ref) async {
    final importedJson = ref.read(importedSettingsJsonProvider);
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
          .set(context.tr("SettingsScreen.SettingsRestore.NameRequired"));
      return;
    }

    try {
      final importedSettings = SettingsState.fromJson(
        importedJson['settings'],
      );
      final keybindings = KeybindingMap.fromJson(importedJson['keybindings']);

      final keybindingMapId = await ref
          .read(keybindingsProvider.notifier)
          .createKeybindingsMap(keybindings);

      await ref
          .read(settingsStorageServiceProvider.notifier)
          .save(name.trim(), importedSettings, keybindingMapId);

      ref.read(importedSettingsJsonProvider.notifier).setValue(null);

      ref
          .read(bannerMessageProvider.notifier)
          .set(context.tr("SettingsScreen.SettingsRestore.ImportSuccess"));
    } catch (e) {
      ref
          .read(bannerMessageProvider.notifier)
          .set(context.tr("SettingsScreen.SettingsRestore.ImportFailed"));
      ref.read(talkerProvider).error('Settings import failed', e);
    }
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

class _SavedSettingsTile extends ConsumerWidget {
  final SettingsDisplayData entry;

  const _SavedSettingsTile({required this.entry});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(entry.title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(entry.createdAt.toString()),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _showDeletionConfirmDialog(context, ref),
          ),
          IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () => _showOptionsDialog(context, ref),
          ),
        ],
      ),
      onLongPress: () => _showOptionsDialog(context, ref),
      onTap: () => _restore(context, ref),
    );
  }

  Future<void> _restore(BuildContext context, WidgetRef ref) async {
    try {
      await ref
          .read(settingsStorageServiceProvider.notifier)
          .loadSettings(entry.id);

      ref.invalidate(keybindingsProvider);

      ref
          .read(talkerProvider)
          .debug(
            'Loaded keybindingsMapId: ${(await ref.read(settingsProvider.future)).keybindingsMapId}',
          );

      ref
          .read(bannerMessageProvider.notifier)
          .set(context.tr("SettingsScreen.SettingsRestore.RestoreSuccess"));
    } catch (e) {
      ref
          .read(bannerMessageProvider.notifier)
          .set(context.tr("SettingsScreen.SettingsRestore.RestoreFailed"));
      ref.read(talkerProvider).error('Settings restore failed', e);
    }
  }

  void _showOptionsDialog(BuildContext context, WidgetRef ref) {
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
              onTap: () => _export(context, ref),
            ),
            ListTile(
              title: Text(
                context.tr(
                  "SettingsScreen.SettingsRestore.OptionsDialog.Delete",
                ),
              ),
              onTap: () => _showDeletionConfirmDialog(
                context,
                ref,
                cb: () => context.pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _export(BuildContext context, WidgetRef ref) async {
    final settings = await ref
        .read(settingsStorageServiceProvider.notifier)
        .getSettings(entry.id);

    try {
      final exportedString = jsonEncode({
        'schemaVersion': kSettingsSchemaVersion,
        'name': await ref
            .read(settingsStorageServiceProvider.notifier)
            .getName(entry.id),
        'settings': SettingsState.toJson(settings),
        'keybindings':
            (await ref
                    .read(keybindingsProvider.notifier)
                    .getKeybindings(settings.keybindingsMapId))
                .toJsonMap(),
      });
      await FilePicker.saveFile(
        fileName: "settings.json",
        dialogTitle: context.tr(
          "SettingsScreen.SettingsRestore.OptionsDialog.FilePickerTitle",
        ),
        allowedExtensions: ["json"],
        type: FileType.custom,
        bytes: Utf8Encoder().convert(exportedString),
      );
      ref
          .read(bannerMessageProvider.notifier)
          .set(context.tr("SettingsScreen.SettingsRestore.ExportSuccess"));
      context.pop();
    } catch (e) {
      ref
          .read(bannerMessageProvider.notifier)
          .set(context.tr("SettingsScreen.SettingsRestore.ExportFailed"));
      context.pop();

      ref.read(talkerProvider).error('Settings export failed', e);
    }
  }

  void _showDeletionConfirmDialog(
    BuildContext context,
    WidgetRef ref, {
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
              args: [entry.title],
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
                  .read(settingsStorageServiceProvider.notifier)
                  .deleteSettings(entry.id);
              context.pop();
              if (cb != null) {
                cb();
              }
              ref
                  .read(bannerMessageProvider.notifier)
                  .set(context.tr("SettingsScreen.SettingsRestore.DeleteSuccess"));
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

class _ImportSettingsDialog extends ConsumerWidget {
  const _ImportSettingsDialog();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          onPressed: () => _pickAndStage(context, ref),
          child: Text(
            context.tr("SettingsScreen.SettingsRestore.ImportSettings.Import"),
          ),
        ),
      ],
    );
  }

  Future<void> _pickAndStage(BuildContext context, WidgetRef ref) async {
    final resultFile = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (resultFile == null) {
      return;
    }

    final file = resultFile.files.first;

    try {
      final fileContent = await File(file.path!).readAsString();
      final jsonContent = jsonDecode(fileContent);

      if (jsonContent['schemaVersion'] != kSettingsSchemaVersion) {
        ref
            .read(bannerMessageProvider.notifier)
            .set(
              context.tr(
                "SettingsScreen.SettingsRestore.ImportSettings.InvalidVersion",
              ),
            );
        context.pop();
        return;
      }

      if (jsonContent['settings'] == null) {
        ref
            .read(bannerMessageProvider.notifier)
            .set(context.tr("SettingsScreen.SettingsRestore.ImportFailed"));
        context.pop();
        return;
      }

      ref.read(importedSettingsJsonProvider.notifier).setValue(jsonContent);

      context.pop();
    } catch (e) {
      ref
          .read(bannerMessageProvider.notifier)
          .set(context.tr("SettingsScreen.SettingsRestore.ImportFailed"));
      context.pop();

      ref.read(talkerProvider).error('Settings import failed', e);
    }
  }
}
