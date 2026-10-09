// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voice_activation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VoiceActivation)
final voiceActivationProvider = VoiceActivationProvider._();

final class VoiceActivationProvider
    extends $AsyncNotifierProvider<VoiceActivation, double> {
  VoiceActivationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'voiceActivationProvider',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[settingsProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          VoiceActivationProvider.$allTransitiveDependencies0,
        ],
      );

  static final $allTransitiveDependencies0 = settingsProvider;

  @override
  String debugGetCreateSourceHash() => _$voiceActivationHash();

  @$internal
  @override
  VoiceActivation create() => VoiceActivation();
}

String _$voiceActivationHash() => r'478e6944b422820fbc3f2b0203cd5536c5b2dd55';

abstract class _$VoiceActivation extends $AsyncNotifier<double> {
  FutureOr<double> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<double>, double>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<double>, double>,
              AsyncValue<double>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
