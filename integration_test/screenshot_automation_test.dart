import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tiefprompt/providers/prompter_provider.dart';
import 'package:tiefprompt/providers/script_provider.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/ui/screens/home_screen.dart';
import 'package:tiefprompt/ui/screens/prompter_screen.dart';

import 'mock_app.dart';

Future<void> main() async {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final List<(String, List<int>)> screenshots = [];

  Future<void> generateScreenshot(WidgetTester tester,
      {String? screenName, String? caseName}) async {
    String platformName = '';

    if (Platform.isAndroid) {
      await binding.convertFlutterSurfaceToImage();
      platformName =
          "android${MediaQuery.of(tester.element(find.byType(HomeScreen))).devicePixelRatio}";
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

    screenshots.add((
      "$screenName${screenName == null ? "" : "_"}$caseName${caseName == null ? "" : "_"}$platformName",
      await binding.takeScreenshot("screenshot")
    ));
  }

  testWidgets("Take screenshot of home screen", (WidgetTester tester) async {
    await tester.pumpWidget(const MockApp(child: HomeScreen()));
    await tester.pumpAndSettle();

    await generateScreenshot(
      tester,
      screenName: "home_screen",
      caseName: "default",
    );
  });

  testWidgets("Take screenshot of teleprompter screen with Roboto font",
      (WidgetTester tester) async {
    await tester.pumpWidget(MockApp(child: PrompterScreen()));
    await tester.pumpAndSettle();

    final container = getProviderContainer(tester);
    setPrompterText(tester, container);
    setPrompterFont(tester, container, "Roboto");

    await generateScreenshot(
      tester,
      screenName: "prompter_screen",
      caseName: "roboto",
    );
  });

  testWidgets("Take screenshot of teleprompter screen with RobotoMono font",
      (WidgetTester tester) async {
    await tester.pumpWidget(MockApp(child: PrompterScreen()));
    await tester.pumpAndSettle();

    final container = getProviderContainer(tester);
    setPrompterText(tester, container);
    setPrompterFont(tester, container, "RobotoMono");

    await generateScreenshot(
      tester,
      screenName: "prompter_screen",
      caseName: "robotoMono",
    );
  });

  testWidgets("Take screenshot of teleprompter screen with RobotoSlab font",
      (WidgetTester tester) async {
    await tester.pumpWidget(MockApp(child: PrompterScreen()));
    await tester.pumpAndSettle();

    final container = getProviderContainer(tester);
    setPrompterText(tester, container);
    setPrompterFont(tester, container, "RobotoSlab");

    await generateScreenshot(
      tester,
      screenName: "prompter_screen",
      caseName: "robotoSlab",
    );
  });

  testWidgets("Take screenshot of teleprompter screen with OpenDyslexic font",
      (WidgetTester tester) async {
    await tester.pumpWidget(MockApp(child: PrompterScreen()));
    await tester.pumpAndSettle();

    final container = getProviderContainer(tester);
    clearPrompterState(tester, container);
    setPrompterText(tester, container);
    setPrompterFont(tester, container, "OpenDyslexic");

    await generateScreenshot(
      tester,
      screenName: "prompter_screen",
      caseName: "OpenDyslexic",
    );
  });

  tearDown(() async {
    for (var screenshot in screenshots) {
      final client = HttpClient();
      final request = await client.post(
          "localhost", 7384, "screenshots/${screenshot.$1}.png")
        ..headers.contentType = ContentType.parse("image/png")
        ..headers.contentLength = screenshot.$2.length
        ..write(screenshot.$2);

      final response = await request.close();

      if (response.statusCode != 200) {
        throw Exception("Failed to upload screenshot: ${response.statusCode}");
      }
    }
  });
}

ProviderContainer getProviderContainer(WidgetTester tester) {
  final element = tester.element(find.byType(PrompterScreen));
  return ProviderScope.containerOf(element);
}

void clearPrompterState(WidgetTester tester, ProviderContainer container) {
  container.read(prompterProvider.notifier).applySettings(SettingsState(
      scrollSpeed: 1.6,
      mirroredX: false,
      mirroredY: false,
      fontSize: 30,
      sideMargin: 10,
      fontFamily: "Roboto",
      alignment: TextAlign.left));
}

void setPrompterText(WidgetTester tester, ProviderContainer container) {
  container.read(prompterProvider.notifier).setFontFamily("Roboto Mono");
  container.read(scriptProvider.notifier).setText("Hello, world!\n"
      "The quick brown fox jumps over the lazy dog.\n"
      "And once the quick brown fox finished jumping over the lazy dog, it went back to sleep in its little fox bed."
      "But the lazy dog did not take kindly to the jumping of the quick brown fox, and booped the quick brown fox on the nose.");
}

void setPrompterFont(
    WidgetTester tester, ProviderContainer container, String s) {
  container.read(prompterProvider.notifier).setFontFamily(s);
}
