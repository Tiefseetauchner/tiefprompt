import 'package:easy_localization/easy_localization.dart';
import 'package:tief_test_harness/tief_test_harness.dart';

import '../mock_app.dart';
import '../screenshot_manager_provider.dart';
import 'marketing_tablet_freemium_test.th.dart';

@GenerateHarnessRegistry('Marketing Tablet Freemium')
Future<void> main() async {
  final harnessRegistry = MarketingTabletFreemiumHarnessRegistry();

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

  final serverIp = const String.fromEnvironment("SERVER_IP");
  await harnessRunner.run(
    setUp: (binding, ref) async {
      await EasyLocalization.ensureInitialized();
      ref
          .read(screenshotManagerStateProvider.notifier)
          .initialize(serverIp, 3824);
    },
    tearDown: (binding, ref) async =>
        ref.read(screenshotManagerStateProvider)!.dispose(),
  );
}
