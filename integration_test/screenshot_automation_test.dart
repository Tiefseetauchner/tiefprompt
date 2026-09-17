import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tief_screen/tief_screen.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/providers/prompter_provider.dart';
import 'package:tiefprompt/providers/script_provider.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/ui/screens/home_screen.dart';
import 'package:tiefprompt/ui/screens/open_file_screen.dart';
import 'package:tiefprompt/ui/screens/prompter_screen.dart';
import 'package:tiefprompt/ui/screens/settings/display_settings_screen.dart';
import 'package:tiefprompt/ui/widgets/prompter_theme_scope.dart';

import 'mock_app.dart';

Future<void> main() async {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late ScreenshotManager screenshotManager;

  for (var locale in kSupportedLocales) {
    group("Screenshots for ${locale.$2}", () {
      setUpAll(() async {
        await EasyLocalization.ensureInitialized();
        screenshotManager = ScreenshotManager(
          host: const String.fromEnvironment("SERVER_IP"),
          port: 3824,
        );
      });

      testWidgets("Take screenshot of home screen", (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          MockApp(locale: locale.$2, child: HomeScreen()),
        );
        await tester.pumpAndSettle();

        await generateScreenshot(
          tester,
          screenshotManager: screenshotManager,
          binding: binding,
          screenName: "home_screen",
          caseName: "default",
        );
      });

      testWidgets("Take screenshot of home screen in dark mode", (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          MockApp(
            locale: locale.$2,
            settings: SettingsState(themeMode: ThemeMode.dark),
            child: HomeScreen(),
          ),
        );
        await tester.pumpAndSettle();

        await generateScreenshot(
          tester,
          screenshotManager: screenshotManager,
          binding: binding,
          screenName: "home_screen",
          caseName: "dark",
        );
      });

      testWidgets("Take screenshot of settings screen", (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          MockApp(locale: locale.$2, child: DisplaySettingsScreen()),
        );
        await tester.pumpAndSettle();

        await generateScreenshot(
          tester,
          screenshotManager: screenshotManager,
          binding: binding,
          screenName: "settings_screen",
          caseName: "default",
        );
      });

      testWidgets("Take screenshot of load script screen", (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          MockApp(locale: locale.$2, child: OpenFileScreen()),
        );
        await tester.pumpAndSettle();

        await generateScreenshot(
          tester,
          screenshotManager: screenshotManager,
          binding: binding,
          screenName: "load_script",
          caseName: "default",
        );
      });

      testWidgets("Take screenshot of teleprompter screen with Roboto font", (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          MockApp(
            locale: locale.$2,
            child: const PrompterThemeScope(child: PrompterScreen()),
          ),
        );
        await tester.pumpAndSettle();

        final container = getProviderContainer(tester);
        clearPrompterState(tester, container);
        setPrompterText(tester, container);
        setPrompterFont(tester, container, "Roboto");

        await generateScreenshot(
          tester,
          screenshotManager: screenshotManager,
          binding: binding,
          screenName: "prompter_screen",
          caseName: "roboto",
        );
      });

      testWidgets(
        "Take screenshot of teleprompter screen with OpenDyslexic font",
        (WidgetTester tester) async {
          await tester.pumpWidget(
            MockApp(
              locale: locale.$2,
              settings: SettingsState(
                prompterBackgroundColor: const Color.fromARGB(255, 53, 0, 94),
                prompterTextColor: const Color.fromARGB(255, 17, 255, 0),
              ),
              child: const PrompterThemeScope(child: PrompterScreen()),
            ),
          );
          await tester.pumpAndSettle();

          final container = getProviderContainer(tester);
          clearPrompterState(tester, container);
          setPrompterText(tester, container);
          setPrompterFont(tester, container, "OpenDyslexic");

          await generateScreenshot(
            tester,
            screenshotManager: screenshotManager,
            binding: binding,
            screenName: "prompter_screen",
            caseName: "OpenDyslexic",
          );
        },
      );

      tearDownAll(() async {
        await screenshotManager.uploadScreenshots(locale.$2.languageCode);
      });
    });
  }
}

ProviderContainer getProviderContainer(WidgetTester tester) {
  final element = tester.element(find.byType(PrompterScreen));
  return ProviderScope.containerOf(element);
}

void clearPrompterState(WidgetTester tester, ProviderContainer container) {
  container.read(prompterProvider.notifier).applySettings(SettingsState());
}

void setPrompterText(WidgetTester tester, ProviderContainer container) {
  container.read(prompterProvider.notifier).setFontFamily("Roboto Mono");
  container
      .read(scriptProvider.notifier)
      .setText(
        "Hello, world!\n"
        "The quick brown fox jumps over the lazy dog.\n"
        "And once the quick brown fox finished jumping over the lazy dog, it went back to sleep in its little fox bed."
        "But the lazy dog did not take kindly to the jumping of the quick brown fox, and booped the quick brown fox on the nose.",
      );
}

void setPrompterFont(
  WidgetTester tester,
  ProviderContainer container,
  String s,
) {
  container.read(prompterProvider.notifier).setFontFamily(s);
}

Future<void> generateScreenshot(
  WidgetTester tester, {
  required ScreenshotManager screenshotManager,
  required IntegrationTestWidgetsFlutterBinding binding,
  String? screenName,
  String? caseName,
}) async {
  String platformName = '';

  if (Platform.isAndroid) {
    platformName =
        "android${MediaQuery.of(tester.element(find.byType(MaterialApp))).devicePixelRatio.toStringAsFixed(1)}";
  } else if (Platform.isLinux) {
    platformName = "linux";
  } else if (Platform.isMacOS) {
    platformName = "macos";
  } else if (Platform.isIOS) {
    platformName = "ios${Platform.localHostname}";
  } else if (Platform.isWindows) {
    platformName = "windows";
  } else {
    throw UnsupportedError("Unsupported platform: ${Platform.operatingSystem}");
  }

  await screenshotManager.pumpAndScreenshot(
    "$platformName/${screenName}_$caseName",
    tester,
    binding,
  );
}
