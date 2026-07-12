import 'package:easy_localization/easy_localization.dart';
import 'package:tief_test_harness/tief_test_harness.dart';

import '../mock_app.dart';
import 'marketing_wide_tablet_test.th.dart';

@GenerateHarnessRegistry('Marketing Wide Tablet')
Future<void> main() async {
  final harnessRegistry = MarketingWideTabletHarnessRegistry();

  final harnessesFilter = const String.fromEnvironment("HARNESSES");
  if (harnessesFilter.isNotEmpty) {
    final harnessNames = harnessesFilter.split(",");
    harnessRegistry.onlyNamed(harnessNames.toSet());
  }

  final harnesses = await harnessRegistry.build();

  final harnessRunner = HarnessRunner(
    harnesses: harnesses,
    appBuilder: MockApp.new,
  );

  await harnessRunner.run(
    setUp: (binding, ref) async {
      await EasyLocalization.ensureInitialized();
    },
  );
}
