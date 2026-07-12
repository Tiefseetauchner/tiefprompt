import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:tiefprompt/ui/widgets/safe_scaffold.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiefprompt/providers/script_provider.dart';
import 'package:tiefprompt/services/script_service.dart';

class OpenFileScreen extends ConsumerWidget {
  const OpenFileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scriptService = ref.watch(scriptServiceProvider.notifier);

    return StreamBuilder(
      stream: ref.watch(scriptServiceProvider.notifier).getScripts(),
      builder: (context, snapshot) => SafeScaffold(
        appBar: AppBar(title: Text(context.tr("OpenFileScreen.title"))),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    key: const Key("OpenFileScreen.ElevatedButton_Select"),
                    onPressed: () async {
                      final result = await FilePicker.pickFile(
                        type: FileType.custom,
                        allowedExtensions: ['txt', 'md'],
                      );
                      if (result != null) {
                        final fileContent = await File(
                          result.path!,
                        ).readAsString();

                        final newScriptId = await scriptService.saveAsNew(
                          ScriptState(
                            id: null,
                            text: fileContent,
                            title: result.name,
                            isSaved: true,
                            scrollPosition: null,
                            ephemeral: false,
                          ),
                        );
                        final newScript = await scriptService.loadScript(
                          newScriptId,
                        );
                        ref.read(scriptProvider.notifier).loadScript(newScript);

                        context.pop();
                      }
                    },
                    child: Text(
                      context.tr("OpenFileScreen.ElevatedButton_Select"),
                    ),
                  ),
                ),
              ],
            ),
            if (snapshot.data == null || snapshot.data!.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 0.0,
                  horizontal: 16.0,
                ),
                child: Text(
                  context.tr("OpenFileScreen.if_empty"),
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
            if (snapshot.data != null && snapshot.data!.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (itemContext, index) {
                    final script = snapshot.data![index];
                    return ListTile(
                      title: Text(
                        script.title,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        DateFormat.yMd().add_jm().format(
                          script.createdAt.toLocal(),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () async {
                        final loadedScript = await scriptService.loadScript(
                          script.id,
                        );

                        ref
                            .read(scriptProvider.notifier)
                            .loadScript(loadedScript);

                        context.pop();
                      },
                      trailing: IconButton(
                        tooltip: context.tr("OpenFileScreen.ListTile_Delete"),
                        onPressed: () {
                          scriptService.deleteScript(script.id);
                        },
                        icon: Icon(Icons.delete),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
