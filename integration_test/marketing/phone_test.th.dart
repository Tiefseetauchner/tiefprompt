// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:tief_test_harness/tief_test_harness.dart';
import 'home_screen/home_screen_harness.dart' as h0;
import 'prompter_screen/prompter_screen_harness.dart' as h1;
import 'select_script_screen/select_script_screen_harness.dart' as h2;
import 'settings_screens/main_settings_screen_harness.dart' as h3;

enum MarketingMetadataHarness {
  storeHome,
  storePrompter,
  storeSelectScript,
  storeSettings;

  String get harnessName => switch (this) {
    MarketingMetadataHarness.storeHome => 'Store Home',
    MarketingMetadataHarness.storePrompter => 'Store Prompter',
    MarketingMetadataHarness.storeSelectScript => 'Store Select Script',
    MarketingMetadataHarness.storeSettings => 'Store Settings',
  };

  static MarketingMetadataHarness fromHarnessName(String name) =>
      values.firstWhere(
        (harness) => harness.harnessName == name,
        orElse: () => throw ArgumentError.value(
          name,
          'name',
          'No MarketingMetadataHarness with this harness name.',
        ),
      );
}

class MarketingMetadataHarnessRegistry {
  const MarketingMetadataHarnessRegistry() : this._(null);
  const MarketingMetadataHarnessRegistry._(this._selected);

  final Set<MarketingMetadataHarness>? _selected;

  static const Map<MarketingMetadataHarness, Future<ScenarioHarness> Function()> _builders = {
    MarketingMetadataHarness.storeHome: h0.buildHomeScreenPhoneHarness,
    MarketingMetadataHarness.storePrompter: h1.buildPrompterScreenPhoneHarness,
    MarketingMetadataHarness.storeSelectScript: h2.buildSelectScriptScreenScreenPhoneHarness,
    MarketingMetadataHarness.storeSettings: h3.buildMainSettingsScreenPhoneHarness,
  };

  /// Restricts a subsequent [build] to just [harnesses].
  MarketingMetadataHarnessRegistry only(Set<MarketingMetadataHarness> harnesses) =>
      MarketingMetadataHarnessRegistry._(harnesses);

  /// Restricts a subsequent [build] to just the harnesses named [names].
  MarketingMetadataHarnessRegistry onlyNamed(Set<String> names) =>
      only(names.map(MarketingMetadataHarness.fromHarnessName).toSet());

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
