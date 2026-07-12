// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:tief_test_harness/tief_test_harness.dart';
import 'settings_screens/display_settings_screen_harness.dart' as h0;
import 'home_screen/home_screen_harness.dart' as h1;
import 'home_screen/home_screen_harness.dart' as h2;
import 'settings_screens/keybindings_settings_screen_harness.dart' as h3;
import 'settings_screens/main_settings_screen_harness.dart' as h4;
import 'prompter_screen/prompter_screen_harness.dart' as h5;
import 'select_script_screen/select_script_screen_harness.dart' as h6;
import 'settings_screens/settings_restore_screen_harness.dart' as h7;
import 'settings_screens/text_settings_screen_harness.dart' as h8;

enum MarketingTabletHarness {
  displaySettingsScreen,
  homeScreen,
  homeScreenHighlights,
  keybindingsSettingsScreen,
  mainSettingsScreen,
  prompterScreenNarrow,
  selectScriptScreen,
  settingsRestoreScreen,
  textSettingsScreen;

  String get harnessName => switch (this) {
    MarketingTabletHarness.displaySettingsScreen => 'Display Settings Screen',
    MarketingTabletHarness.homeScreen => 'Home Screen',
    MarketingTabletHarness.homeScreenHighlights => 'Home Screen Highlights',
    MarketingTabletHarness.keybindingsSettingsScreen => 'Keybindings Settings Screen',
    MarketingTabletHarness.mainSettingsScreen => 'Main Settings Screen',
    MarketingTabletHarness.prompterScreenNarrow => 'Prompter Screen Narrow',
    MarketingTabletHarness.selectScriptScreen => 'Select Script Screen',
    MarketingTabletHarness.settingsRestoreScreen => 'Settings Restore Screen',
    MarketingTabletHarness.textSettingsScreen => 'Text Settings Screen',
  };

  static MarketingTabletHarness fromHarnessName(String name) =>
      values.firstWhere(
        (harness) => harness.harnessName == name,
        orElse: () => throw ArgumentError.value(
          name,
          'name',
          'No MarketingTabletHarness with this harness name.',
        ),
      );
}

class MarketingTabletHarnessRegistry {
  const MarketingTabletHarnessRegistry() : this._(null);
  const MarketingTabletHarnessRegistry._(this._selected);

  final Set<MarketingTabletHarness>? _selected;

  static const Map<MarketingTabletHarness, Future<ScenarioHarness> Function()> _builders = {
    MarketingTabletHarness.displaySettingsScreen: h0.buildDisplaySettingsHarness,
    MarketingTabletHarness.homeScreen: h1.buildHomeScreenHarness,
    MarketingTabletHarness.homeScreenHighlights: h2.buildHomeScreenWithHighlightsHarness,
    MarketingTabletHarness.keybindingsSettingsScreen: h3.buildKeybindingsSettingsHarness,
    MarketingTabletHarness.mainSettingsScreen: h4.buildSettingsHarness,
    MarketingTabletHarness.prompterScreenNarrow: h5.buildPrompterScreenNarrowHarness,
    MarketingTabletHarness.selectScriptScreen: h6.buildSelectScriptScreenHarness,
    MarketingTabletHarness.settingsRestoreScreen: h7.buildSettingsRestoreHarness,
    MarketingTabletHarness.textSettingsScreen: h8.buildTextSettingsHarness,
  };

  /// Restricts a subsequent [build] to just [harnesses].
  MarketingTabletHarnessRegistry only(Set<MarketingTabletHarness> harnesses) =>
      MarketingTabletHarnessRegistry._(harnesses);

  /// Restricts a subsequent [build] to just the harnesses named [names].
  MarketingTabletHarnessRegistry onlyNamed(Set<String> names) =>
      only(names.map(MarketingTabletHarness.fromHarnessName).toSet());

  /// Calls every selected builder and awaits the results, keyed by harness name.
  Future<Map<String, ScenarioHarness>> build() async {
    final selected = _selected == null
        ? _builders.entries
        : _builders.entries.where((entry) => _selected.contains(entry.key));

    final resolved = await Future.wait(
      selected.map((entry) async => MapEntry(entry.key.harnessName, await entry.value())),
    );

    return Map.fromEntries(resolved);
  }
}
