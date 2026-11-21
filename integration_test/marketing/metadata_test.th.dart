// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:tief_test_harness/tief_test_harness.dart';
import 'home_screen/home_screen_harness.dart' as h0;
import 'prompter_screen/prompter_screen_harness.dart' as h1;
import 'select_script_screen/select_script_screen_harness.dart' as h2;
import 'settings_screens/main_settings_screen_harness.dart' as h3;

enum MetadataHarness {
  storeHome,
  storePrompter,
  storeSelectScript,
  storeSettings;

  String get harnessName => switch (this) {
    MetadataHarness.storeHome => 'Store Home',
    MetadataHarness.storePrompter => 'Store Prompter',
    MetadataHarness.storeSelectScript => 'Store Select Script',
    MetadataHarness.storeSettings => 'Store Settings',
  };

  static MetadataHarness fromHarnessName(String name) =>
      values.firstWhere(
        (harness) => harness.harnessName == name,
        orElse: () => throw ArgumentError.value(
          name,
          'name',
          'No MetadataHarness with this harness name.',
        ),
      );
}

class MetadataHarnessRegistry {
  const MetadataHarnessRegistry() : this._(null);
  const MetadataHarnessRegistry._(this._selected);

  final Set<MetadataHarness>? _selected;

  static const Map<MetadataHarness, Future<ScenarioHarness> Function()> _builders = {
    MetadataHarness.storeHome: h0.buildHomeScreenPhoneHarness,
    MetadataHarness.storePrompter: h1.buildPrompterScreenPhoneHarness,
    MetadataHarness.storeSelectScript: h2.buildSelectScriptScreenScreenPhoneHarness,
    MetadataHarness.storeSettings: h3.buildMainSettingsScreenPhoneHarness,
  };

  /// Restricts a subsequent [build] to just [harnesses].
  MetadataHarnessRegistry only(Set<MetadataHarness> harnesses) =>
      MetadataHarnessRegistry._(harnesses);

  /// Restricts a subsequent [build] to just the harnesses named [names].
  MetadataHarnessRegistry onlyNamed(Set<String> names) =>
      only(names.map(MetadataHarness.fromHarnessName).toSet());

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
