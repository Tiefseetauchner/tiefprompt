// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keybinding_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Keybindings)
final keybindingsProvider = KeybindingsProvider._();

final class KeybindingsProvider
    extends $AsyncNotifierProvider<Keybindings, KeybindingMap> {
  KeybindingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'keybindingsProvider',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[settingsProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          KeybindingsProvider.$allTransitiveDependencies0,
        ],
      );

  static final $allTransitiveDependencies0 = settingsProvider;

  @override
  String debugGetCreateSourceHash() => _$keybindingsHash();

  @$internal
  @override
  Keybindings create() => Keybindings();
}

String _$keybindingsHash() => r'036c3b1e7195c7f68cedba89008c4f6b8c10b6b1';

abstract class _$Keybindings extends $AsyncNotifier<KeybindingMap> {
  FutureOr<KeybindingMap> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<KeybindingMap>, KeybindingMap>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<KeybindingMap>, KeybindingMap>,
              AsyncValue<KeybindingMap>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
