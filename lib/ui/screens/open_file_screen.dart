import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiefprompt/providers/script_provider.dart';
import 'package:tiefprompt/services/script_service.dart';

class OpenFileScreen extends ConsumerWidget {
  const OpenFileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scriptService = ref.watch(scriptServiceProvider.notifier);

    return FutureBuilder(
      future: scriptService.getScripts(),
      builder: (buildContext, streamSnapshot) => StreamBuilder(
        stream: streamSnapshot.data,
        builder: (context, snapshot) => Scaffold(
          appBar: AppBar(title: Text(context.tr("OpenFileScreen.title"))),
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        final result = await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['txt'],
                        );
                        if (result != null) {
                          final file = result.files.first;

                          final fileContent = await File(
                            file.path!,
                          ).readAsString();

                          ref
                              .read(scriptProvider.notifier)
                              .setText(fileContent);
                          ref.read(scriptProvider.notifier).setTitle(file.name);
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
                          script.createdAt.toString(),
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () async {
                          ref
                              .read(scriptProvider.notifier)
                              .setText(
                                (await scriptService.loadScript(script.id)),
                              );

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
      ),
    );
  }
}
