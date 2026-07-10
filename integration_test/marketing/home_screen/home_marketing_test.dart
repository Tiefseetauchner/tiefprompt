import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tiefprompt/models/database.dart';
import 'package:tiefprompt/providers/database_provider.dart';
import 'package:tiefprompt/providers/feature_provider.dart';
import 'package:tiefprompt/providers/feature_provider_foss.dart';
import 'package:tiefprompt/providers/script_provider.dart';
import 'package:tiefprompt/ui/screens/home_screen.dart';

import '../../fake_providers/features_fake_pro.dart';
import '../../fake_providers/script_fake.dart';
import '../../fake_providers/features_fake_free.dart';
import '../../mock_database_managers.dart';
import '../constants.dart';
import '../scenarios/scenario.dart';

Future<void> main() async {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  final ref = ProviderContainer();
  AppDatabase db = await createSeededDatabase();

  setUpAll(() async {
    await EasyLocalization.ensureInitialized();
  });

  runScenario(
    "Home Screen Foss Empty",
    binding: binding,
    ref: ref,
    screenName: "home_screen",
    caseName: "foss",
    appContent: HomeScreen(),
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

  runScenario(
    "Home Screen Freemium Free Empty",
    binding: binding,
    ref: ref,
    screenName: "home_screen",
    caseName: "freemium_free",
    appContent: HomeScreen(),
    providerScopeBuilder: (child) async => ProviderScope(
      overrides: [
        featuresProvider.overrideWith(() => FeaturesFakeFree()),
        appDatabaseManagerProvider.overrideWith(
          () => MockAppDatabaseManager(db),
        ),
      ],
      child: child,
    ),
  );

  runScenario(
    "Home Screen Freemium Pro Empty",
    binding: binding,
    ref: ref,
    screenName: "home_screen",
    caseName: "freemium_pro_empty",
    appContent: HomeScreen(),
    providerScopeBuilder: (child) async => ProviderScope(
      overrides: [
        featuresProvider.overrideWith(() => FeaturesFakePro()),
        appDatabaseManagerProvider.overrideWith(
          () => MockAppDatabaseManager(db),
        ),
      ],
      child: child,
    ),
  );

  runScenario(
    "Home Screen Foss Prefilled",
    binding: binding,
    ref: ref,
    screenName: "home_screen",
    caseName: "foss_prefilled",
    appContent: HomeScreen(),
    providerScopeBuilder: (child) async => ProviderScope(
      overrides: [
        scriptProvider.overrideWith(
          () => ScriptFake(kMarketingScriptName, kMarketingScriptContent),
        ),
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
