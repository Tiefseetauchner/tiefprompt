// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:tief_test_harness/tief_test_harness.dart';
import 'home_screen/home_screen_harness.dart' as h0;
import 'prompter_screen/prompter_screen_harness.dart' as h1;
import 'select_script_screen/select_script_screen_harness.dart' as h2;
import 'settings_screens/main_settings_screen_harness.dart' as h3;

enum MarketingPhoneHarness {
  storeHome,
  storePrompter,
  storeSelectScript,
  storeSettings;

  String get harnessName => switch (this) {
    MarketingPhoneHarness.storeHome => 'Store Home',
    MarketingPhoneHarness.storePrompter => 'Store Prompter',
    MarketingPhoneHarness.storeSelectScript => 'Store Select Script',
    MarketingPhoneHarness.storeSettings => 'Store Settings',
  };

  static MarketingPhoneHarness fromHarnessName(String name) =>
      values.firstWhere(
        (harness) => harness.harnessName == name,
        orElse: () => throw ArgumentError.value(
          name,
          'name',
          'No MarketingPhoneHarness with this harness name.',
        ),
      );
}

class MarketingPhoneHarnessRegistry {
  const MarketingPhoneHarnessRegistry() : this._(null);
  const MarketingPhoneHarnessRegistry._(this._selected);

  final Set<MarketingPhoneHarness>? _selected;

  static const Map<MarketingPhoneHarness, Future<ScenarioHarness> Function()> _builders = {
    MarketingPhoneHarness.storeHome: h0.buildHomeScreenPhoneHarness,
    MarketingPhoneHarness.storePrompter: h1.buildPrompterScreenPhoneHarness,
    MarketingPhoneHarness.storeSelectScript: h2.buildSelectScriptScreenScreenPhoneHarness,
    MarketingPhoneHarness.storeSettings: h3.buildMainSettingsScreenPhoneHarness,
  };

  /// Restricts a subsequent [build] to just [harnesses].
  MarketingPhoneHarnessRegistry only(Set<MarketingPhoneHarness> harnesses) =>
      MarketingPhoneHarnessRegistry._(harnesses);

  /// Restricts a subsequent [build] to just the harnesses named [names].
  MarketingPhoneHarnessRegistry onlyNamed(Set<String> names) =>
      only(names.map(MarketingPhoneHarness.fromHarnessName).toSet());

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
