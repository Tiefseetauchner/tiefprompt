import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tief_screen/tief_screen.dart';
import 'package:tief_test_harness/tief_test_harness.dart';
import 'package:tiefprompt/ui/screens/settings/scroll_settings_screen.dart';

import '../../constants.dart';
import '../harness_preparation.dart';

@RegisterHarness('Marketing Tablet', name: "Scroll Settings Screen")
Future<ScenarioHarness> buildScrollSettingsHarness() async {
  final harness = prepareScreenshotHarness(
    appContent: const ScrollSettingsScreen(),
  );

  harness.addScenario(
    Scenario(
      name: "Scroll Speed Highlight",
      testCallback: (tester, binding) async {
        await WidgetHighlighter(
          tester,
          defaultHighlightColor: kMarketingHighlightColor,
        ).highlightWidget(
          find.byKey(const Key("SettingsScreen.ScrollSettings.ScrollSpeed")),
        );
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Scroll Speed Dialog",
      testCallback: (tester, binding) async {
        await tester.tap(
          find.byKey(const Key("SettingsScreen.ScrollSettings.ScrollSpeed")),
        );
        await tester.pumpAndSettle();
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Countdown Timer Highlight",
      testCallback: (tester, binding) async {
        await WidgetHighlighter(
          tester,
          defaultHighlightColor: kMarketingHighlightColor,
        ).highlightWidget(
          find.byKey(const Key("SettingsScreen.ScrollSettings.CountdownTimer")),
        );
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Countdown Timer Highlight",
      testCallback: (tester, binding) async {
        await tester.tap(
          find.byKey(const Key("SettingsScreen.ScrollSettings.CountdownTimer")),
        );
        await tester.pumpAndSettle();
      },
    ),
  );

  return harness;
}
