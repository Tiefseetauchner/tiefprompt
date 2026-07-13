import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tiefprompt/ui/screens/open_file_screen.dart';
import 'package:tief_screen/tief_screen.dart';
import 'package:tief_test_harness/tief_test_harness.dart';

import '../../constants.dart';
import '../harness_preparation.dart';

@RegisterHarness('Marketing Tablet', name: "Select Script Screen")
Future<ScenarioHarness> buildSelectScriptScreenHarness() async {
  final harness = prepareScreenshotHarness(
    screenshotManager: ScreenshotManager(serverPort: 3824),
    appContent: const OpenFileScreen(),
  );

  harness.addScenario(Scenario(name: "Foss"));

  harness.addScenario(
    Scenario(
      name: "Load Highlight",
      testCallback: (tester, binding) async {
        await tester.pumpAndSettle();

        await WidgetHighlighter(
          tester,
          defaultHighlightColor: kMarketingHighlightColor,
        ).highlightWidget(find.widgetWithText(ListTile, kMarketingScriptName));
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Delete Highlight",
      testCallback: (tester, binding) async {
        await tester.pumpAndSettle();

        await WidgetHighlighter(
          tester,
          defaultHighlightColor: kMarketingHighlightColor,
        ).highlightWidget(
          find.descendant(
            of: find.widgetWithText(ListTile, kMarketingScriptName),
            matching: find.byIcon(Icons.delete),
          ),
          padding: 8,
        );
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Delete Complete",
      testCallback: (tester, binding) async {
        await tester.pumpAndSettle();
        await tester.tap(
          find.descendant(
            of: find.widgetWithText(ListTile, kMarketingScriptName),
            matching: find.byIcon(Icons.delete),
          ),
        );
        await tester.pumpAndSettle();
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Import Highlight",
      testCallback: (tester, binding) async {
        await tester.pumpAndSettle();

        await WidgetHighlighter(
          tester,
          defaultHighlightColor: kMarketingHighlightColor,
        ).highlightWidget(
          find.byKey(const Key("OpenFileScreen.ElevatedButton_Select")),
        );
      },
    ),
  );

  return harness;
}

@RegisterHarness("Marketing Wide Tablet", name: "Select Script Screen Wide")
Future<ScenarioHarness> buildSelectScriptScreenWideHarness() async {
  final harness = prepareScreenshotHarness(
    screenshotManager: ScreenshotManager(serverPort: 3824),
    appContent: const OpenFileScreen(),
  );

  harness.addScenario(Scenario(name: "Foss"));

  return harness;
}
