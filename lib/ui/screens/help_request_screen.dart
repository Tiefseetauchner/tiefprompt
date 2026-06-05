import 'package:drift/drift.dart' hide Column;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/providers/database_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpRequestScreen extends ConsumerWidget {
  const HelpRequestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(35, 35, 35, 100),
        child: Column(
          spacing: 20,
          children: [
            Text(
              context.tr("HelpRequestScreen.Title"),
              textScaler: TextScaler.linear(2),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Divider(),
            Text(context.tr("HelpRequestScreen.Abstract")),
            ElevatedButton(
              onPressed: () => _launchUrl(kRepoUrl),
              child: Text(kRepoUrl),
            ),
            ExpansionTile(
              title: Text(context.tr("HelpRequestScreen.ReadMore")),
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    spacing: 20,
                    children: [
                      Text(
                        context.tr("HelpRequestScreen.ElaborateExplanation"),
                      ),
                      ElevatedButton(
                        onPressed: () => _launchUrl(kRepoUrl),
                        child: Text(kRepoUrl),
                      ),
                      ElevatedButton(
                        onPressed: () => _launchUrl(kWeblateUrl),
                        child: Text(kWeblateUrl),
                      ),
                      ElevatedButton(
                        onPressed: () => _launchUrl(kPrivacyPolicyUrl),
                        child: Text(kPrivacyPolicyUrl),
                      ),
                      ElevatedButton(
                        onPressed: () => _launchUrl(kLukeChriswalkerUrl),
                        child: Text(kLukeChriswalkerUrl),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomSheet: Row(
        spacing: 10,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsetsGeometry.all(10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: () {
                ref
                    .read(databaseManagersProvider)
                    .appStateModel
                    .update((o) => o(helpRequestShown: Value(true)));

                while (context.canPop()) {
                  context.pop();
                }

                context.pushReplacement("/");
              },
              child: Text(context.tr("HelpRequestScreen.Continue")),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String uri) async {
    final Uri url = Uri.parse(uri);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
