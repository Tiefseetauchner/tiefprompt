import 'package:tiefprompt/providers/settings_provider.dart';

class SettingsFake extends Settings {
  final SettingsState settings;

  SettingsFake(this.settings);

  @override
  Future<SettingsState> build() async => settings;
}
