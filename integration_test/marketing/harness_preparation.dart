import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tief_screen/tief_screen.dart';
import 'package:tief_test_harness/tief_test_harness.dart';

import '../screenshot_manager_provider.dart';

ScenarioHarness prepareScreenshotHarness({Widget? appContent}) {
  final harness = ScenarioHarness(
    appContent: appContent ?? const SizedBox.shrink(),
    beforeAll: (binding, ref, harnessName) async {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    },
    afterEach: (tester, binding, ref, harnessName, scenarioName) async {
      await ref
          .read(screenshotManagerStateProvider)!
          .pumpAndScreenshot(scenarioName, tester, binding);
    },
    afterAll: (binding, ref, harnessName) async {
      await ref
          .read(screenshotManagerStateProvider)!
          .uploadScreenshots("Marketing/$harnessName");
      ref.read(screenshotManagerStateProvider)!.clear();
    },
  );

  return harness;
}
