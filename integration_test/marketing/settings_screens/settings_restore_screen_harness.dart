import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tiefprompt/providers/banner_provider.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/services/settings_storage_service.dart';
import 'package:tiefprompt/ui/screens/settings/settings_restore_screen.dart';
import 'package:tief_screen/tief_screen.dart';
import 'package:tief_test_harness/tief_test_harness.dart';

import '../../constants.dart';
import '../harness_preparation.dart';

@RegisterHarness('Marketing Tablet', name: "Settings Restore Screen")
Future<ScenarioHarness> buildSettingsRestoreHarness() async {
  final harness = prepareScreenshotHarness(
    appContent: const SettingsRestoreScreen(),
  );

  harness.addScenario(Scenario(name: "Light Theme"));

  harness.addScenario(Scenario(name: "Saved Settings"));

  harness.addScenario(
    Scenario(
      name: "Save Highlight",
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
      testCallback: (tester, binding) async {
        await tester.tap(find.widgetWithText(ListTile, "Nachtmodus"));
        await tester.pumpAndSettle();
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Delete Highlight",
      testCallback: (tester, binding) =>
          WidgetHighlighter(
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

@RegisterHarness('Marketing Wide Tablet', name: "Settings Restore Screen Wide")
Future<ScenarioHarness> buildSettingsRestoreWideHarness() async {
  final harness = prepareLandscapeScreenshotHarness(
    appContent: const SettingsRestoreScreen(),
  );

  harness.addScenario(Scenario(name: "Saved Settings"));

  return harness;
}
