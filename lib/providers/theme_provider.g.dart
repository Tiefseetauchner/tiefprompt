// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$themesHash() => r'334184795a943068360272bdce433bd168fbd92e';

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
