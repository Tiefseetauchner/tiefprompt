import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tiefprompt/providers/banner_provider.dart';
import 'package:tiefprompt/providers/feature_provider.dart';
import 'package:tiefprompt/providers/feature_provider_foss.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/services/settings_storage_service.dart';
import 'package:tiefprompt/ui/screens/settings/settings_restore_screen.dart';
import 'package:tief_screen/tief_screen.dart';
import 'package:tief_test_harness/tief_test_harness.dart';

import '../constants.dart';
import '../harness_preparation.dart';

@RegisterHarness('MarketingTablet')
Future<ScenarioHarness> buildSettingsRestoreHarness() async {
  final harness = prepareScreenshotHarness(
    "Settings Restore Screen",
    screenshotManager: ScreenshotManager(serverPort: 3824),
    appContent: const SettingsRestoreScreen(),
  );

  harness.addScenario(
    Scenario(
      name: "Light Theme",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [featuresProvider.overrideWith(() => FeaturesFoss())],
        child: child,
      ),
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Saved Settings",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [featuresProvider.overrideWith(() => FeaturesFoss())],
        child: child,
      ),
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Save Highlight",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [featuresProvider.overrideWith(() => FeaturesFoss())],
        child: child,
      ),
      testCallback: (tester, binding) =>
          WidgetHighlighter(
            tester,
            defaultHighlightColor: kMarketingHighlightColor,
          ).highlightWidget(
            find.byKey(
              const Key("SettingsRestoreScreen.DialogAppSetting_Save"),
            ),
          ),
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Save Dialog",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [featuresProvider.overrideWith(() => FeaturesFoss())],
        child: child,
      ),
      testCallback: (tester, binding) async {
        await tester.tap(
          find.byKey(const Key("SettingsRestoreScreen.DialogAppSetting_Save")),
        );
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextField), "Podcast Recording");
        await tester.pumpAndSettle();
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Save Complete",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [featuresProvider.overrideWith(() => FeaturesFoss())],
        child: child,
      ),
      testCallback: (tester, binding) async {
        final context = tester.element(find.byType(SettingsRestoreScreen));
        final container = ProviderScope.containerOf(context);

        await container
            .read(settingsStorageServiceProvider.notifier)
            .save("Podcast Recording", SettingsState(), 0);
        container
            .read(bannerMessageProvider.notifier)
            .set(context.tr("SettingsScreen.SettingsRestore.SaveSuccess"));
        await tester.pumpAndSettle();
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Export Highlight",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [featuresProvider.overrideWith(() => FeaturesFoss())],
        child: child,
      ),
      testCallback: (tester, binding) =>
          WidgetHighlighter(
            tester,
            defaultHighlightColor: kMarketingHighlightColor,
          ).highlightWidget(
            find.descendant(
              of: find.widgetWithText(ListTile, "Interview Setup"),
              matching: find.byIcon(Icons.more_horiz),
            ),
            padding: 8,
          ),
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Export Dialog Highlight",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [featuresProvider.overrideWith(() => FeaturesFoss())],
        child: child,
      ),
      testCallback: (tester, binding) async {
        await tester.tap(
          find.descendant(
            of: find.widgetWithText(ListTile, "Interview Setup"),
            matching: find.byIcon(Icons.more_horiz),
          ),
        );
        await tester.pumpAndSettle();

        await WidgetHighlighter(
          tester,
          defaultHighlightColor: kMarketingHighlightColor,
        ).highlightWidget(
          find.byKey(
            const Key("SettingsRestoreScreen.OptionsDialog.ListTile_Export"),
          ),
        );
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Import Highlight",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [featuresProvider.overrideWith(() => FeaturesFoss())],
        child: child,
      ),
      testCallback: (tester, binding) =>
          WidgetHighlighter(
            tester,
            defaultHighlightColor: kMarketingHighlightColor,
          ).highlightWidget(
            find.byKey(
              const Key("SettingsRestoreScreen.DialogAppSetting_Import"),
            ),
          ),
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Import Dialog Highlight",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [featuresProvider.overrideWith(() => FeaturesFoss())],
        child: child,
      ),
      testCallback: (tester, binding) async {
        await tester.tap(
          find.byKey(
            const Key("SettingsRestoreScreen.DialogAppSetting_Import"),
          ),
        );
        await tester.pumpAndSettle();

        await WidgetHighlighter(
          tester,
          defaultHighlightColor: kMarketingHighlightColor,
        ).highlightWidget(
          find.byKey(const Key("ImportSettingsDialog.ElevatedButton_Import")),
        );
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Import Complete",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [featuresProvider.overrideWith(() => FeaturesFoss())],
        child: child,
      ),
      testCallback: (tester, binding) async {
        final context = tester.element(find.byType(SettingsRestoreScreen));
        final container = ProviderScope.containerOf(context);

        await container
            .read(settingsStorageServiceProvider.notifier)
            .save("Imported Setup", SettingsState(), 0);
        container
            .read(bannerMessageProvider.notifier)
            .set(context.tr("SettingsScreen.SettingsRestore.ImportSuccess"));
        await tester.pumpAndSettle();
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Restore Highlight",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [featuresProvider.overrideWith(() => FeaturesFoss())],
        child: child,
      ),
      testCallback: (tester, binding) async {
        await WidgetHighlighter(
          tester,
          defaultHighlightColor: kMarketingHighlightColor,
        ).highlightWidget(find.widgetWithText(ListTile, "Nachtmodus"));
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Restore Success",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [featuresProvider.overrideWith(() => FeaturesFoss())],
        child: child,
      ),
      testCallback: (tester, binding) async {
        await tester.tap(find.widgetWithText(ListTile, "Nachtmodus"));
        await tester.pumpAndSettle();
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Delete Highlight",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [featuresProvider.overrideWith(() => FeaturesFoss())],
        child: child,
      ),
      testCallback: (tester, binding) => WidgetHighlighter(
        tester,
        defaultHighlightColor: kMarketingHighlightColor,
      ).highlightWidget(
        find.descendant(
          of: find.widgetWithText(ListTile, "Peter"),
          matching: find.byIcon(Icons.delete),
        ),
        padding: 8,
      ),
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Delete Dialog Highlight",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [featuresProvider.overrideWith(() => FeaturesFoss())],
        child: child,
      ),
      testCallback: (tester, binding) async {
        await tester.tap(
          find.descendant(
            of: find.widgetWithText(ListTile, "Peter"),
            matching: find.byIcon(Icons.delete),
          ),
        );
        await tester.pumpAndSettle();

        await WidgetHighlighter(
          tester,
          defaultHighlightColor: kMarketingHighlightColor,
        ).highlightWidget(
          find.byKey(
            const Key(
              "SettingsRestoreScreen.DeleteDialog.ElevatedButton_Confirm",
            ),
          ),
        );
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Delete Complete",
      providerScopeBuilder: (child) async => ProviderScope(
        overrides: [featuresProvider.overrideWith(() => FeaturesFoss())],
        child: child,
      ),
      testCallback: (tester, binding) async {
        await tester.tap(
          find.descendant(
            of: find.widgetWithText(ListTile, "Peter"),
            matching: find.byIcon(Icons.delete),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(
          find.byKey(
            const Key(
              "SettingsRestoreScreen.DeleteDialog.ElevatedButton_Confirm",
            ),
          ),
        );
        await tester.pumpAndSettle();
      },
    ),
  );

  return harness;
}
