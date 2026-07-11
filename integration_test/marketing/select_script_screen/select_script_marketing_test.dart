import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tiefprompt/models/database.dart';
import 'package:tiefprompt/providers/database_provider.dart';
import 'package:tiefprompt/providers/feature_provider.dart';
import 'package:tiefprompt/providers/feature_provider_foss.dart';
import 'package:tiefprompt/ui/screens/open_file_screen.dart';

import '../../mock_database_managers.dart';
import '../../scenarios/scenario.dart';

Future<void> main() async {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  final ref = ProviderContainer();
  AppDatabase db = await createSeededDatabase();

  setUpAll(() async {
    await EasyLocalization.ensureInitialized();
  });

  runScenario(
    "Select Script Screen Foss",
    binding: binding,
    ref: ref,
    screenName: "select_script_screen_light",
    caseName: "foss",
    appContent: OpenFileScreen(),
    providerScopeBuilder: (child) async => ProviderScope(
      overrides: [
        featuresProvider.overrideWith(() => FeaturesFoss()),
        appDatabaseManagerProvider.overrideWith(
          () => MockAppDatabaseManager(db),
        ),
      ],
      child: child,
    ),
  );

  tearDownAll(() async {
    await uploadScreenshots(ref);
  });
}
