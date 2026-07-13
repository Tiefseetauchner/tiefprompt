import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tief_fonts/tief_fonts.dart';
import 'package:tiefprompt/core/fonts.dart';
import 'package:tiefprompt/providers/fonts_provider.dart';
import 'package:tiefprompt/ui/widgets/async_settings_builder.dart';
import 'package:tiefprompt/ui/widgets/safe_scaffold.dart';

class FontSettingsScreen extends ConsumerWidget {
  const FontSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fonts = ref.watch(fontsProvider);

    return AsyncSettingsBuilder(
      state: fonts,
      screenTitle: context.tr("SettingsScreen.FontSettings.Title"),
      builder: (ref, value) {
        final fontsList = value..sort((a, b) => a.name.compareTo(b.name));

        return SafeScaffold(
          appBar: AppBar(
            title: Text(context.tr("SettingsScreen.FontSettings.Title")),
          ),
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () async => await _addFontButtonPressed(ref),
                      child: Text(
                        context.tr("SettingsScreen.FontSettings.AddFont"),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: fontsList.length,
                  itemBuilder: (context, index) {
                    final font = fontsList[index];
                    return ExpansionTile(
                      key: ValueKey(font.name),
                      title: Text(
                        font.name,
                        style: TextStyle(fontFamily: font.name),
                      ),
                      subtitle: Text(
                        font.isBuiltIn
                            ? context.tr("SettingsScreen.FontSettings.BuiltIn")
                            : context.tr("SettingsScreen.FontSettings.Custom"),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            tooltip: font.isBuiltIn
                                ? context.tr(
                                    "SettingsScreen.FontSettings.EditFamilyTooltip.BuiltIn",
                                  )
                                : context.tr(
                                    "SettingsScreen.FontSettings.EditFamilyTooltip.Custom",
                                  ),
                            onPressed: font.isBuiltIn
                                ? null
                                : () async =>
                                      await _editFontFamilyButtonPressed(
                                        context,
                                        font,
                                      ),
                          ),
                        ],
                      ),
                      children: [
                        ...getSortedVariants(font.variants).map(
                          (variant) => ListTile(
                            dense: true,
                            title: Text(
                              "Weight ${variant.weight}; Style ${variant.fontStyle.name}",
                              style: TextStyle(
                                fontFamily: font.name,
                                fontWeight: FontWeight(variant.weight),
                                fontStyle: variant.fontStyle,
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  tooltip: font.isBuiltIn
                                      ? context.tr(
                                          "SettingsScreen.FontSettings.EditVariantTooltip.BuiltIn",
                                        )
                                      : context.tr(
                                          "SettingsScreen.FontSettings.EditVariantTooltip.Custom",
                                        ),
                                  onPressed: font.isBuiltIn
                                      ? null
                                      : () async =>
                                            await _editFontVariantButtonPressed(
                                              context,
                                              fontsList,
                                              font,
                                              variant,
                                            ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.move_down),
                                  tooltip: font.isBuiltIn
                                      ? context.tr(
                                          "SettingsScreen.FontSettings.MoveVariantTooltip.BuiltIn",
                                        )
                                      : context.tr(
                                          "SettingsScreen.FontSettings.MoveVariantTooltip.Custom",
                                        ),
                                  onPressed: font.isBuiltIn
                                      ? null
                                      : () async =>
                                            await _moveFontVariantButtonPressed(
                                              context,
                                              ref,
                                              fontsList,
                                              font,
                                              variant,
                                            ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  tooltip: font.isBuiltIn
                                      ? context.tr(
                                          "SettingsScreen.FontSettings.DeleteVariantTooltip.BuiltIn",
                                        )
                                      : context.tr(
                                          "SettingsScreen.FontSettings.DeleteVariantTooltip.Custom",
                                        ),
                                  onPressed: font.isBuiltIn
                                      ? null
                                      : () async =>
                                            await _deleteFontVariantButtonPressed(
                                              context,
                                              ref,
                                              font,
                                              variant,
                                            ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _addFontButtonPressed(WidgetRef ref) async {
    final fontPaths = await _selectFontFiles();

    final fontFiles = await Future.wait(fontPaths.map(_createFontFile));

    for (final fontFile in fontFiles) {
      await ref.read(fontsProvider.notifier).addFont(fontFile);
    }
  }

  Future<List<File>> _selectFontFiles() async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['ttf', 'otf'],
    );

    if (result == null || result.files.isEmpty) {
      return [];
    }

    return result.files.nonNulls.map((file) => File(file.path!)).toList();
  }

  Future<TiefPromptFontsFile> _createFontFile(File fontFile) async {
    final fileContent = await fontFile.readAsBytes();
    final fontInfo = extractFontInfo(fileContent);

    final fontVariant = TiefPromptFontsVariant(
      weight: fontInfo.weight,
      fontStyle: fontInfo.isItalic ? FontStyle.italic : FontStyle.normal,
      load: () async => ByteData.view(fileContent.buffer),
      originalFileName: fontFile.path.split('/').last,
    );

    return TiefPromptFontsFile(
      name:
          fontInfo.familyName ??
          fontFile.path
              .split('/')
              .last
              .substring(0, fontFile.path.lastIndexOf('.')),
      variants: [fontVariant],
    );
  }

  Future<void> _editFontFamilyButtonPressed(
    BuildContext context,
    TiefPromptFontsFile font,
  ) async {
    showDialog(
      context: context,
      builder: (context) {
        return _EditFontFamilyDialog(font: font);
      },
    );
  }

  Future<void> _editFontVariantButtonPressed(
    BuildContext context,
    List<TiefPromptFontsFile> fonts,
    TiefPromptFontsFile font,
    TiefPromptFontsVariant variant,
  ) async {
    showDialog(
      context: context,
      builder: (context) {
        return _EditFontDialog(
          fonts: fonts,
          variant: variant,
          fontName: font.name,
        );
      },
    );
  }

  Future<void> _deleteFontVariantButtonPressed(
    BuildContext context,
    WidgetRef ref,
    TiefPromptFontsFile font,
    TiefPromptFontsVariant variant,
  ) async {
    await ref.read(fontsProvider.notifier).removeFontVariant(font, variant);
  }

  Future<void> _moveFontVariantButtonPressed(
    BuildContext context,
    WidgetRef ref,
    List<TiefPromptFontsFile> fonts,
    TiefPromptFontsFile font,
    TiefPromptFontsVariant variant,
  ) async {
    final fontNames = fonts
        .where((f) => !f.isBuiltIn)
        .map((f) => f.name)
        .toList();

    final newFontName = await showDialog<String>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(
            context.tr("SettingsScreen.FontSettings.MoveFontDialog.Title"),
          ),
          children: [
            ...fontNames.map(
              (name) => SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, name);
                },
                child: Text(name),
              ),
            ),
          ],
        );
      },
    );

    if (newFontName != null && newFontName != font.name) {
      ref
          .read(fontsProvider.notifier)
          .moveFontVariant(font.name, variant, newFontName);
    }
  }
}

class _EditFontFamilyDialog extends ConsumerStatefulWidget {
  final TiefPromptFontsFile font;

  const _EditFontFamilyDialog({required this.font});

  @override
  ConsumerState<_EditFontFamilyDialog> createState() =>
      _EditFontFamilyDialogState();
}

class _EditFontFamilyDialogState extends ConsumerState<_EditFontFamilyDialog> {
  late String _newFontName;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _newFontName = widget.font.name;
    _controller = TextEditingController(text: _newFontName);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        context.tr("SettingsScreen.FontSettings.EditFontDialog.Title"),
      ),
      content: TextField(
        decoration: InputDecoration(
          labelText: context.tr(
            "SettingsScreen.FontSettings.EditFontDialog.SetFontFamilyName",
          ),
        ),
        controller: _controller,
        onChanged: (value) {
          setState(() {
            _newFontName = value;
          });
        },
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text(
            context.tr("SettingsScreen.FontSettings.EditFontDialog.Cancel"),
          ),
        ),
        TextButton(
          onPressed: () {
            ref
                .read(fontsProvider.notifier)
                .updateFont(widget.font, _newFontName);

            context.pop();
          },
          child: Text(
            context.tr("SettingsScreen.FontSettings.EditFontDialog.Save"),
          ),
        ),
      ],
    );
  }
}

class _EditFontDialog extends ConsumerStatefulWidget {
  final List<TiefPromptFontsFile> fonts;
  final TiefPromptFontsVariant variant;
  final String fontName;

  const _EditFontDialog({
    required this.fonts,
    required this.fontName,
    required this.variant,
  });

  @override
  ConsumerState<_EditFontDialog> createState() => _EditFontDialogState();
}

class _EditFontDialogState extends ConsumerState<_EditFontDialog> {
  late int _newVariantWeight;
  late FontStyle _newVariantStyle;

  @override
  void initState() {
    super.initState();
    _newVariantWeight = widget.variant.weight;
    _newVariantStyle = widget.variant.fontStyle;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        context.tr("SettingsScreen.FontSettings.EditFontDialog.Title"),
      ),
      content: Column(
        spacing: 12,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            context.tr("SettingsScreen.FontSettings.EditFontDialog.Warning"),
          ),
          Column(
            children: [
              Text(
                context.tr(
                  "SettingsScreen.FontSettings.EditFontDialog.SetFontVariantWeight",
                ),
                textScaler: TextScaler.linear(0.8),
              ),
              Slider(
                value: _newVariantWeight.toDouble(),
                min: 100,
                max: 900,
                divisions: 8,
                label: _newVariantWeight.toString(),
                onChanged: (value) {
                  setState(() {
                    _newVariantWeight = value.toInt();
                  });
                },
              ),
            ],
          ),
          Column(
            children: [
              Text(
                context.tr(
                  "SettingsScreen.FontSettings.EditFontDialog.SetFontItalics",
                ),
                textScaler: TextScaler.linear(0.8),
              ),
              Switch(
                value: _newVariantStyle == FontStyle.italic,
                onChanged: (value) {
                  setState(() {
                    _newVariantStyle = value
                        ? FontStyle.italic
                        : FontStyle.normal;
                  });
                },
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text(
            context.tr("SettingsScreen.FontSettings.EditFontDialog.Cancel"),
          ),
        ),
        TextButton(
          onPressed: () {
            ref
                .read(fontsProvider.notifier)
                .updateFontVariant(
                  widget.fontName,
                  widget.variant,
                  _newVariantWeight,
                  _newVariantStyle,
                );

            context.pop();
          },
          child: Text(
            context.tr("SettingsScreen.FontSettings.EditFontDialog.Save"),
          ),
        ),
      ],
    );
  }
}
