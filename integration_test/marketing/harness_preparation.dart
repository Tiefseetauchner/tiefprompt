import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tief_screen/tief_screen.dart';
import 'package:tief_test_harness/tief_test_harness.dart';

ScenarioHarness prepareScreenshotHarness(
  String harnessName, {
  required ScreenshotManager screenshotManager,
  Widget? appContent,
}) {
  final harness = ScenarioHarness(
    harnessName,
    appContent: appContent ?? const SizedBox.shrink(),
    afterEach: (tester, binding, ref, harnessName, scenarioName) async {
      await screenshotManager.generateScreenshot(
        scenarioName,
        ref,
        tester,
        binding,
      );
    },
    beforeAll: (binding, ref, harnessName) async {
      ref.read(screenshotsProvider.notifier).clearScreenshots();
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    },
    afterAll: (binding, ref, harnessName) async => await screenshotManager
        .uploadScreenshots(ref, "Marketing/$harnessName"),
  );

  return harness;
}
