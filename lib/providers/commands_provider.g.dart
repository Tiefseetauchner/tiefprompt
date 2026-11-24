// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commands_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Command)
final commandProvider = CommandProvider._();

final class CommandProvider extends $NotifierProvider<Command, void> {
  CommandProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'commandProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$commandHash();

  @$internal
  @override
  Command create() => Command();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$commandHash() => r'ece3984c38a5868711ec45294e04d1de937080ed';

abstract class _$Command extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
