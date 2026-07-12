// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:tief_test_harness/tief_test_harness.dart';
import 'prompter_screen/prompter_screen_harness.dart' as h0;

enum MarketingWideTabletHarness {
  prompterScreen;

  String get harnessName => switch (this) {
    MarketingWideTabletHarness.prompterScreen => 'Prompter Screen',
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
    MarketingWideTabletHarness.prompterScreen: h0.buildPrompterScreenHarness,
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
