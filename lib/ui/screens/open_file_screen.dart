import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiefprompt/providers/script_provider.dart';

class OpenFileScreen extends ConsumerWidget {
  const OpenFileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
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
        Text("In the future, there will be a list of scripts here."),
      ]),
    );
  }
}
