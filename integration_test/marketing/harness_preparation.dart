import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:tief_test_harness/tief_test_harness.dart';

import '../screenshot_manager_provider.dart';

ScenarioHarness prepareScreenshotHarness({Widget? appContent}) {
  final harness = ScenarioHarness(
    appContent: appContent ?? const SizedBox.shrink(),
    beforeAll: harnessBeforeAll,
    beforeEach: (tester, binding, ref, harnessName, scenarioName) async {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    },
    afterEach: harnessAfterEach,
    afterAll: harnessAfterAll,
  );

  return harness;
}

ScenarioHarness prepareLandscapeScreenshotHarness({Widget? appContent}) {
  final harness = ScenarioHarness(
    appContent: appContent ?? const SizedBox.shrink(),
    beforeAll: harnessBeforeAll,
    beforeEach: (tester, binding, ref, harnessName, scenarioName) async {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    },
    afterEach: harnessAfterEach,
    afterAll: harnessAfterAll,
  );

  return harness;
}

Future<void> harnessBeforeAll(
  IntegrationTestWidgetsFlutterBinding binding,
  ProviderContainer ref,
  String harnessName,
) async {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
}

Future<void> harnessAfterEach(
  WidgetTester tester,
  IntegrationTestWidgetsFlutterBinding binding,
  ProviderContainer ref,
  String harnessName,
  String scenarioName,
) async {
  await ref
      .read(screenshotManagerStateProvider)!
      .pumpAndScreenshot(scenarioName, tester, binding);
}

Future<void> harnessAfterAll(
  IntegrationTestWidgetsFlutterBinding binding,
  ProviderContainer ref,
  String harnessName,
) async {
  await ref
      .read(screenshotManagerStateProvider)!
      .uploadScreenshots("Marketing/$harnessName");
  ref.read(screenshotManagerStateProvider)!.clear();
}
