import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:integration_test/integration_test.dart';
import 'screenshots_provider.dart';
import 'package:riverpod/riverpod.dart';
import '../../mock_app.dart';

Future<void> generateScreenshot(
  WidgetTester tester,
  IntegrationTestWidgetsFlutterBinding binding,
  ProviderContainer ref,
  String screenName,
  String caseName,
) async {
  String platformName = 'Marketing';

  await binding.convertFlutterSurfaceToImage();
  await tester.pumpAndSettle();

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await tester.pumpAndSettle();
  final screenshotBytes = await binding.takeScreenshot("screenshot");
  var screenshotName = '$platformName/${screenName}_$caseName';

  ref
      .read(screenshotsProvider.notifier)
      .addScreenshot(screenshotName, screenshotBytes);
}

Future<void> uploadScreenshots(ProviderContainer ref) async {
  final screenshots = ref.read(screenshotsProvider);
  final serverIp = const String.fromEnvironment("SERVER_IP");
  final client = HttpClient();

  try {
    await Future.wait(
      screenshots.map((screenshot) async {
        final request = await client.post(
          serverIp,
          3824,
          "screenshots/${screenshot.$1}.png",
        );
        request
          ..contentLength = screenshot.$2.length
          ..add(screenshot.$2);

        final response = await request.close();
        await response.drain();

        if (response.statusCode != 200) {
          throw Exception(
            "Failed to upload screenshot: ${response.statusCode}",
          );
        }
      }),
    );
  } catch (e) {
    throw Exception("Error uploading screenshots: $e");
  } finally {
    client.close();
  }
}

void runScenario(
  String scenarioName, {
  required String screenName,
  required String caseName,
  required Widget appContent,
  required IntegrationTestWidgetsFlutterBinding binding,
  required ProviderContainer ref,
  ProviderScopeBuilder? providerScopeBuilder,
}) {
  testWidgets("Take screenshot of $scenarioName", (WidgetTester tester) async {
    final app = MockApp(
      locale: Locale("en", "US"),
      providerScopeBuilder: providerScopeBuilder,
      child: appContent,
    );

    await tester.pumpWidget(app);
    await tester.pumpAndSettle();

    // We have to wait for the providers to be initialized before taking the screenshot
    await Future.delayed(Duration(seconds: 2));

    await generateScreenshot(tester, binding, ref, screenName, caseName);
  });
}
