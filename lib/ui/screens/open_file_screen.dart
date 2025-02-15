import 'dart:io';

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
    final scriptService = ScriptService();

    return FutureBuilder(
      future: scriptService.getScripts(),
      builder: (buildContext, snapshot) => Scaffold(
        appBar: AppBar(title: const Text('Select Script')),
        body: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['txt'],
                  );
                  if (result != null) {
                    final file = result.files.first;

                    final fileContent = await File(file.path!).readAsString();

                    ref.read(scriptProvider.notifier).setText(fileContent);
                    context.pop();
                  }
                },
                child: Text('Select Script'),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (itemContext, index) {
                final script = snapshot.data![index];
                return ListTile(
                  title: Text(script.title),
                  subtitle: Text(script.createdAt.toString()),
                  onTap: () async {
                    ref
                        .read(scriptProvider.notifier)
                        .setText((await scriptService.loadScript(script.id)));

                    context.pop();
                  },
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
