import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:tief_test_harness/tief_test_harness.dart';

import '../screenshot_manager_provider.dart';

ScenarioHarness prepareScreenshotHarness({Widget? appContent, Device? device}) {
  final harness = ScenarioHarness(
    appContent: appContent ?? const SizedBox.shrink(),
    beforeAll: harnessBeforeAll,
    beforeEach: (tester, binding, ref, harnessName, scenarioName) async {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    },
    afterEach: harnessAfterEach,
    afterAll: harnessAfterAll(device),
  );

  return harness;
}

ScenarioHarness prepareLandscapeScreenshotHarness({
  Widget? appContent,
  Device? device,
}) {
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
    afterAll: harnessAfterAll(device),
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

Future<void> Function(
  IntegrationTestWidgetsFlutterBinding binding,
  ProviderContainer ref,
  String harnessName,
)
harnessAfterAll(Device? device) {
  return (binding, ref, harnessName) async {
    await ref
        .read(screenshotManagerStateProvider)!
        .uploadScreenshots("Marketing/$harnessName/${device?.name}/");
    ref.read(screenshotManagerStateProvider)!.clear();
  };
}

Future<Null> Function(
  WidgetTester tester,
  IntegrationTestWidgetsFlutterBinding binding,
)
getLocaleSetter<T extends Widget>(Locale locale) {
  return (
    WidgetTester tester,
    IntegrationTestWidgetsFlutterBinding binding,
  ) async {
    final context = tester.element(find.byType(T));
    await context.setLocale(locale);
  };
}

enum Device { phone, sevenInchTablet, tenInchTablet }

Device getDeviceInfo() {
  final envDevice = const String.fromEnvironment("DEVICE");

  if (envDevice == "sevenInchTablet") {
    return Device.sevenInchTablet;
  } else if (envDevice == "tenInchTablet") {
    return Device.tenInchTablet;
  } else if (envDevice == "phone") {
    return Device.phone;
  } else {
    throw Exception("Unknown device: $envDevice");
  }
}
