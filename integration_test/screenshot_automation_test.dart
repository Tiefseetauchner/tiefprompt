import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tiefprompt/main.dart';

Future<void> main() async {
  final IntegrationTestWidgetsFlutterBinding binding =
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Take screenshot of home screen", (WidgetTester tester) async {
    await tester.pumpWidget(const TeleprompterApp());
    await tester.pumpAndSettle();

    String platformName = '';

    if (Platform.isAndroid) {
      await binding.convertFlutterSurfaceToImage();
      platformName = "android";
    } else if (Platform.isLinux) {
      platformName = "linux";
    } else if (Platform.isMacOS) {
      platformName = "macos";
    } else if (Platform.isWindows) {
      platformName = "windows";
    } else {
      throw UnsupportedError(
          "Unsupported platform: ${Platform.operatingSystem}");
    }

    await tester.pumpAndSettle();

    await binding.takeScreenshot("screenshot-$platformName");
  });
}
