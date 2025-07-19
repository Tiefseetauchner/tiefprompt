// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'combining_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$combinedAsyncDataHash() => r'7a5108dde816da771e7af7304118c9aaf4f2d6a9';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$CombinedAsyncData
    extends BuildlessAutoDisposeNotifier<AsyncValue<CombinedState>> {
  late final List<AsyncValue<Object>> states;

  AsyncValue<CombinedState> build(List<AsyncValue<Object>> states);
}

/// See also [CombinedAsyncData].
@ProviderFor(CombinedAsyncData)
const combinedAsyncDataProvider = CombinedAsyncDataFamily();

/// See also [CombinedAsyncData].
class CombinedAsyncDataFamily extends Family<AsyncValue<CombinedState>> {
  /// See also [CombinedAsyncData].
  const CombinedAsyncDataFamily();

  /// See also [CombinedAsyncData].
  CombinedAsyncDataProvider call(List<AsyncValue<Object>> states) {
    return CombinedAsyncDataProvider(states);
  }

  @override
  CombinedAsyncDataProvider getProviderOverride(
    covariant CombinedAsyncDataProvider provider,
  ) {
    return call(provider.states);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'combinedAsyncDataProvider';
}

/// See also [CombinedAsyncData].
class CombinedAsyncDataProvider
    extends
        AutoDisposeNotifierProviderImpl<
          CombinedAsyncData,
          AsyncValue<CombinedState>
        > {
  /// See also [CombinedAsyncData].
  CombinedAsyncDataProvider(List<AsyncValue<Object>> states)
    : this._internal(
        () => CombinedAsyncData()..states = states,
        from: combinedAsyncDataProvider,
        name: r'combinedAsyncDataProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$combinedAsyncDataHash,
        dependencies: CombinedAsyncDataFamily._dependencies,
        allTransitiveDependencies:
            CombinedAsyncDataFamily._allTransitiveDependencies,
        states: states,
      );

  CombinedAsyncDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.states,
  }) : super.internal();

  final List<AsyncValue<Object>> states;

  @override
  AsyncValue<CombinedState> runNotifierBuild(
    covariant CombinedAsyncData notifier,
  ) {
    return notifier.build(states);
  }

  @override
  Override overrideWith(CombinedAsyncData Function() create) {
    return ProviderOverride(
      origin: this,
      override: CombinedAsyncDataProvider._internal(
        () => create()..states = states,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        states: states,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<
    CombinedAsyncData,
    AsyncValue<CombinedState>
  >
  createElement() {
    return _CombinedAsyncDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CombinedAsyncDataProvider && other.states == states;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, states.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CombinedAsyncDataRef
    on AutoDisposeNotifierProviderRef<AsyncValue<CombinedState>> {
  /// The parameter `states` of this provider.
  List<AsyncValue<Object>> get states;
}

class _CombinedAsyncDataProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          CombinedAsyncData,
          AsyncValue<CombinedState>
        >
    with CombinedAsyncDataRef {
  _CombinedAsyncDataProviderElement(super.provider);

  @override
  List<AsyncValue<Object>> get states =>
      (origin as CombinedAsyncDataProvider).states;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
