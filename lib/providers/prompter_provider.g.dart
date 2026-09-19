// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prompter_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Prompter)
final prompterProvider = PrompterProvider._();

final class PrompterProvider
    extends $NotifierProvider<Prompter, PrompterState> {
  PrompterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'prompterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$prompterHash();

  @$internal
  @override
  Prompter create() => Prompter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PrompterState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PrompterState>(value),
    );
  }
}

String _$prompterHash() => r'65670f2dff1811c60cca469539f7bcd4fd2c0d6a';

abstract class _$Prompter extends $Notifier<PrompterState> {
  PrompterState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<PrompterState, PrompterState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PrompterState, PrompterState>,
              PrompterState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
