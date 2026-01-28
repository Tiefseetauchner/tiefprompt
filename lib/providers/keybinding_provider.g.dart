// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keybinding_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$keybindingsHash() => r'5b8108693b93713bcab735923ad5444f55d89977';

/// See also [Keybindings].
@ProviderFor(Keybindings)
final keybindingsProvider =
    AsyncNotifierProvider<Keybindings, KeybindingMap>.internal(
      Keybindings.new,
      name: r'keybindingsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$keybindingsHash,
      dependencies: <ProviderOrFamily>[settingsProvider],
      allTransitiveDependencies: <ProviderOrFamily>{
        settingsProvider,
        ...?settingsProvider.allTransitiveDependencies,
      },
    );

typedef _$Keybindings = AsyncNotifier<KeybindingMap>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
