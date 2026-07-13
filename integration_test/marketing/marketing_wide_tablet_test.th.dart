// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:tief_test_harness/tief_test_harness.dart';
import 'home_screen/home_screen_harness.dart' as h0;
import 'settings_screens/keybindings_settings_screen_harness.dart' as h1;
import 'prompter_screen/prompter_screen_harness.dart' as h2;
import 'select_script_screen/select_script_screen_harness.dart' as h3;
import 'settings_screens/settings_restore_screen_harness.dart' as h4;

enum MarketingWideTabletHarness {
  homeScreenWide,
  keybindingsSettingsScreen,
  prompterScreen,
  selectScriptScreenWide,
  settingsRestoreScreen;

  String get harnessName => switch (this) {
    MarketingWideTabletHarness.homeScreenWide => 'Home Screen Wide',
    MarketingWideTabletHarness.keybindingsSettingsScreen => 'Keybindings Settings Screen',
    MarketingWideTabletHarness.prompterScreen => 'Prompter Screen',
    MarketingWideTabletHarness.selectScriptScreenWide => 'Select Script Screen Wide',
    MarketingWideTabletHarness.settingsRestoreScreen => 'Settings Restore Screen',
  };

  static MarketingWideTabletHarness fromHarnessName(String name) =>
      values.firstWhere(
        (harness) => harness.harnessName == name,
        orElse: () => throw ArgumentError.value(
          name,
          'name',
          'No MarketingWideTabletHarness with this harness name.',
        ),
      );
}

class MarketingWideTabletHarnessRegistry {
  const MarketingWideTabletHarnessRegistry() : this._(null);
  const MarketingWideTabletHarnessRegistry._(this._selected);

  final Set<MarketingWideTabletHarness>? _selected;

  static const Map<MarketingWideTabletHarness, Future<ScenarioHarness> Function()> _builders = {
    MarketingWideTabletHarness.homeScreenWide: h0.buildHomeScreenWideHarness,
    MarketingWideTabletHarness.keybindingsSettingsScreen: h1.buildKeybindingsSettingsWideHarness,
    MarketingWideTabletHarness.prompterScreen: h2.buildPrompterScreenHarness,
    MarketingWideTabletHarness.selectScriptScreenWide: h3.buildSelectScriptScreenWideHarness,
    MarketingWideTabletHarness.settingsRestoreScreen: h4.buildSettingsRestoreWideHarness,
  };

  /// Restricts a subsequent [build] to just [harnesses].
  MarketingWideTabletHarnessRegistry only(Set<MarketingWideTabletHarness> harnesses) =>
      MarketingWideTabletHarnessRegistry._(harnesses);

  /// Restricts a subsequent [build] to just the harnesses named [names].
  MarketingWideTabletHarnessRegistry onlyNamed(Set<String> names) =>
      only(names.map(MarketingWideTabletHarness.fromHarnessName).toSet());

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
