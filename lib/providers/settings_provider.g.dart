// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SettingsState _$SettingsStateFromJson(Map<String, dynamic> json) =>
    _SettingsState(
      themeMode: json['themeMode'] == null
          ? ThemeMode.system
          : const ThemeModeConverter().fromJson(json['themeMode'] as String),
      appPrimaryColor: json['appPrimaryColor'] == null
          ? kBrandTeal
          : const ColorConverter().fromJson(
              (json['appPrimaryColor'] as num).toInt(),
            ),
      prompterBackgroundColor: json['prompterBackgroundColor'] == null
          ? Colors.black
          : const ColorConverter().fromJson(
              (json['prompterBackgroundColor'] as num).toInt(),
            ),
      prompterTextColor: json['prompterTextColor'] == null
          ? Colors.white
          : const ColorConverter().fromJson(
              (json['prompterTextColor'] as num).toInt(),
            ),
      keybindingsMapId: (json['keybindingsMapId'] as num?)?.toInt() ?? 0,
      config: json['config'] == null
          ? const PrompterConfiguration()
          : PrompterConfiguration.fromJson(
              json['config'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$SettingsStateToJson(
  _SettingsState instance,
) => <String, dynamic>{
  'themeMode': const ThemeModeConverter().toJson(instance.themeMode),
  'appPrimaryColor': const ColorConverter().toJson(instance.appPrimaryColor),
  'prompterBackgroundColor': const ColorConverter().toJson(
    instance.prompterBackgroundColor,
  ),
  'prompterTextColor': const ColorConverter().toJson(
    instance.prompterTextColor,
  ),
  'keybindingsMapId': instance.keybindingsMapId,
  'config': instance.config,
};

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Settings)
final settingsProvider = SettingsProvider._();

final class SettingsProvider
    extends $AsyncNotifierProvider<Settings, SettingsState> {
  SettingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsProvider',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[],
        $allTransitiveDependencies: <ProviderOrFamily>[],
      );

  @override
  String debugGetCreateSourceHash() => _$settingsHash();

  @$internal
  @override
  Settings create() => Settings();
}

String _$settingsHash() => r'2452f264c68a7a124c98c72b4e8625707818ca9c';

abstract class _$Settings extends $AsyncNotifier<SettingsState> {
  FutureOr<SettingsState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<SettingsState>, SettingsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SettingsState>, SettingsState>,
              AsyncValue<SettingsState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
