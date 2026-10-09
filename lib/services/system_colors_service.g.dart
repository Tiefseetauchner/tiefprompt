// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_colors_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(systemColorSchemes)
final systemColorSchemesProvider = SystemColorSchemesProvider._();

final class SystemColorSchemesProvider
    extends
        $FunctionalProvider<
          AsyncValue<SystemColorSchemes?>,
          SystemColorSchemes?,
          FutureOr<SystemColorSchemes?>
        >
    with
        $FutureModifier<SystemColorSchemes?>,
        $FutureProvider<SystemColorSchemes?> {
  SystemColorSchemesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'systemColorSchemesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$systemColorSchemesHash();

  @$internal
  @override
  $FutureProviderElement<SystemColorSchemes?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SystemColorSchemes?> create(Ref ref) {
    return systemColorSchemes(ref);
  }
}

String _$systemColorSchemesHash() =>
    r'daea4de82c14c14164ca99158b4a0004df4197c6';
