// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$themesHash() => r'68b689ce09a4cc1bba3bc6ed0cf1891b05b5ed9d';

/// See also [Themes].
@ProviderFor(Themes)
final themesProvider =
    AutoDisposeAsyncNotifierProvider<Themes, ThemesState>.internal(
      Themes.new,
      name: r'themesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$themesHash,
      dependencies: <ProviderOrFamily>[settingsProvider],
      allTransitiveDependencies: <ProviderOrFamily>{
        settingsProvider,
        ...?settingsProvider.allTransitiveDependencies,
      },
    );

typedef _$Themes = AutoDisposeAsyncNotifier<ThemesState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
