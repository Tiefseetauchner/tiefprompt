import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tief_weave/markdown.dart';
import 'package:tiefprompt/ui/widgets/safe_scaffold.dart';

class NoPurchaseAvailableScreen extends ConsumerWidget {
  const NoPurchaseAvailableScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeScaffold(
      appBar: AppBar(title: Text(context.tr("NoPurchaseAvailable.Title"))),
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: context.pop,
          child: Text(context.tr("NoPurchaseAvailable.Back")),
        ),
      ],
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 20,
              children: [
                Markdown(
                  textAlign: TextAlign.left,
                  context.tr("NoPurchaseAvailable.MainBody"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
