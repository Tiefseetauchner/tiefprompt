import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:tief_weave/markdown.dart';

const _fallbackChangelogDir = 'en-US';

class _ChangelogEntry {
  final Version version;
  final String content;

  _ChangelogEntry(this.version, this.content);
}

Future<List<_ChangelogEntry>> _loadChangelogs(Locale locale) async {
  final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
  final allAssets = manifest.listAssets();

  final localeString = locale.toString();

  List<String> paths = allAssets
      .where(
        (a) =>
            a.startsWith('assets/changelogs/$localeString/') &&
            a.endsWith('.md'),
      )
      .toList();

  if (paths.isEmpty && localeString != _fallbackChangelogDir) {
    paths = allAssets
        .where(
          (a) =>
              a.startsWith('assets/changelogs/$_fallbackChangelogDir/') &&
              a.endsWith('.md'),
        )
        .toList();
  }

  final entries = <_ChangelogEntry>[];
  for (final path in paths) {
    final fileName = path.split('/').last;
    final versionString = fileName.split('.md')[0];

    final Version version;
    try {
      version = Version.parse(versionString);
    } catch (_) {
      continue;
    }

    final content = await rootBundle.loadString(path);
    entries.add(_ChangelogEntry(version, content));
  }

  entries.sort((a, b) => b.version.compareTo(a.version));
  return entries;
}

Future<void> showChangelogModal(BuildContext context) async {
  final entries = await _loadChangelogs(context.locale);

  if (entries.isEmpty || !context.mounted) return;

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(context.tr("ChangelogModal.title")),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final (index, entry) in entries.indexed)
                  ExpansionTile(
                    initiallyExpanded: index == 0,
                    tilePadding: EdgeInsets.zero,
                    childrenPadding: const EdgeInsets.only(bottom: 8),
                    title: Text(entry.version.toString()),
                    children: [
                      Align(
                        alignment: AlignmentGeometry.centerLeft,
                        child: Markdown(
                          entry.content,
                          textAlign: TextAlign.left,
                          width: MediaQuery.of(context).size.width - 200,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(context.tr("ChangelogModal.close")),
          ),
        ],
      );
    },
  );
}
