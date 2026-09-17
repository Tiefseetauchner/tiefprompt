// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:tief_test_harness/tief_test_harness.dart';
import 'buy_pro_screen/buy_pro_screen_harness.dart' as h0;

enum MarketingTabletFreemiumHarness {
  buyProScreen;

  String get harnessName => switch (this) {
    MarketingTabletFreemiumHarness.buyProScreen => 'Buy Pro Screen',
  };

  static MarketingTabletFreemiumHarness fromHarnessName(String name) =>
      values.firstWhere(
        (harness) => harness.harnessName == name,
        orElse: () => throw ArgumentError.value(
          name,
          'name',
          'No MarketingTabletFreemiumHarness with this harness name.',
        ),
      );
}

class MarketingTabletFreemiumHarnessRegistry {
  const MarketingTabletFreemiumHarnessRegistry() : this._(null);
  const MarketingTabletFreemiumHarnessRegistry._(this._selected);

  final Set<MarketingTabletFreemiumHarness>? _selected;

  static const Map<MarketingTabletFreemiumHarness, Future<ScenarioHarness> Function()> _builders = {
    MarketingTabletFreemiumHarness.buyProScreen: h0.buildBuyProScreenHarness,
  };

  /// Restricts a subsequent [build] to just [harnesses].
  MarketingTabletFreemiumHarnessRegistry only(Set<MarketingTabletFreemiumHarness> harnesses) =>
      MarketingTabletFreemiumHarnessRegistry._(harnesses);

  /// Restricts a subsequent [build] to just the harnesses named [names].
  MarketingTabletFreemiumHarnessRegistry onlyNamed(Set<String> names) =>
      only(names.map(MarketingTabletFreemiumHarness.fromHarnessName).toSet());

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
