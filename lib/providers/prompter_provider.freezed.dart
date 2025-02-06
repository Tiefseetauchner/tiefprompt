// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prompter_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PrompterState {
  double get speed => throw _privateConstructorUsedError;
  bool get isPlaying => throw _privateConstructorUsedError;

  /// Create a copy of PrompterState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PrompterStateCopyWith<PrompterState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrompterStateCopyWith<$Res> {
  factory $PrompterStateCopyWith(
          PrompterState value, $Res Function(PrompterState) then) =
      _$PrompterStateCopyWithImpl<$Res, PrompterState>;
  @useResult
  $Res call({double speed, bool isPlaying});
}

/// @nodoc
class _$PrompterStateCopyWithImpl<$Res, $Val extends PrompterState>
    implements $PrompterStateCopyWith<$Res> {
  _$PrompterStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PrompterState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? speed = null,
    Object? isPlaying = null,
  }) {
    return _then(_value.copyWith(
      speed: null == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double,
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PrompterStateImplCopyWith<$Res>
    implements $PrompterStateCopyWith<$Res> {
  factory _$$PrompterStateImplCopyWith(
          _$PrompterStateImpl value, $Res Function(_$PrompterStateImpl) then) =
      __$$PrompterStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double speed, bool isPlaying});
}

/// @nodoc
class __$$PrompterStateImplCopyWithImpl<$Res>
    extends _$PrompterStateCopyWithImpl<$Res, _$PrompterStateImpl>
    implements _$$PrompterStateImplCopyWith<$Res> {
  __$$PrompterStateImplCopyWithImpl(
      _$PrompterStateImpl _value, $Res Function(_$PrompterStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of PrompterState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? speed = null,
    Object? isPlaying = null,
  }) {
    return _then(_$PrompterStateImpl(
      speed: null == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double,
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$PrompterStateImpl implements _PrompterState {
  _$PrompterStateImpl({this.speed = 2.0, this.isPlaying = false});

  @override
  @JsonKey()
  final double speed;
  @override
  @JsonKey()
  final bool isPlaying;

  @override
  String toString() {
    return 'PrompterState(speed: $speed, isPlaying: $isPlaying)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrompterStateImpl &&
            (identical(other.speed, speed) || other.speed == speed) &&
            (identical(other.isPlaying, isPlaying) ||
                other.isPlaying == isPlaying));
  }

  @override
  int get hashCode => Object.hash(runtimeType, speed, isPlaying);

  /// Create a copy of PrompterState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PrompterStateImplCopyWith<_$PrompterStateImpl> get copyWith =>
      __$$PrompterStateImplCopyWithImpl<_$PrompterStateImpl>(this, _$identity);
}

abstract class _PrompterState implements PrompterState {
  factory _PrompterState({final double speed, final bool isPlaying}) =
      _$PrompterStateImpl;

  @override
  double get speed;
  @override
  bool get isPlaying;

  /// Create a copy of PrompterState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PrompterStateImplCopyWith<_$PrompterStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
