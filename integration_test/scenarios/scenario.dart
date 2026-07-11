import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:integration_test/integration_test.dart';
import 'screenshots_provider.dart';
import 'package:riverpod/riverpod.dart';
import '../mock_app.dart';
import '../marketing/constants.dart';

Future<void> highlightWidget(WidgetTester tester, Finder finder) async {
  final rect = tester.getRect(finder);

  Overlay.of(tester.element(finder)).insert(
    OverlayEntry(
      builder: (context) => Positioned.fromRect(
        rect: rect,
        child: CustomPaint(painter: _HighlightBorderPainter()),
      ),
    ),
  );
}

class _HighlightBorderPainter extends CustomPainter {
  static const _borderWidth = 3.0;
  static const _borderRadius = Radius.circular(8);

  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      _borderRadius,
    ).deflate(_borderWidth / 2);

    canvas.drawRRect(
      rrect.shift(Offset(_borderWidth / 2, _borderWidth)),
      Paint()
        ..color = Colors.black.withAlpha(100)
        ..style = PaintingStyle.stroke
        ..strokeWidth = _borderWidth
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2),
    );
    canvas.drawRRect(
      rrect,
      Paint()
        ..color = kMarketingHighlightColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = _borderWidth,
    );
  }

  @override
  bool shouldRepaint(covariant _HighlightBorderPainter oldDelegate) => false;
}

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
        final screenshotName = screenshot.$1;
        final screenshotBytes = screenshot.$2;
        final request = await client.post(
          serverIp,
          3824,
          "screenshots/$screenshotName.png",
        );
        request
          ..contentLength = screenshotBytes.length
          ..add(screenshotBytes);

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
  Future<void> Function(WidgetTester tester)? widgetHighlighter,
}) {
  testWidgets("Take screenshot of $scenarioName", (WidgetTester tester) async {
    final app = MockApp(
      locale: Locale("en", "US"),
      providerScopeBuilder: providerScopeBuilder,
      child: appContent,
    );

    await tester.pumpWidget(app);
    await tester.pumpAndSettle();

    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    await tester.pumpAndSettle();

    if (widgetHighlighter != null) await widgetHighlighter(tester);

    await generateScreenshot(tester, binding, ref, screenName, caseName);
  });
}
