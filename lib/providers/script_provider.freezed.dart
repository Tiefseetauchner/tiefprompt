// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'script_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ScriptState {
  String get text => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;

  /// Create a copy of ScriptState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScriptStateCopyWith<ScriptState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScriptStateCopyWith<$Res> {
  factory $ScriptStateCopyWith(
          ScriptState value, $Res Function(ScriptState) then) =
      _$ScriptStateCopyWithImpl<$Res, ScriptState>;
  @useResult
  $Res call({String text, String title});
}

/// @nodoc
class _$ScriptStateCopyWithImpl<$Res, $Val extends ScriptState>
    implements $ScriptStateCopyWith<$Res> {
  _$ScriptStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScriptState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? title = null,
  }) {
    return _then(_value.copyWith(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScriptStateImplCopyWith<$Res>
    implements $ScriptStateCopyWith<$Res> {
  factory _$$ScriptStateImplCopyWith(
          _$ScriptStateImpl value, $Res Function(_$ScriptStateImpl) then) =
      __$$ScriptStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, String title});
}

/// @nodoc
class __$$ScriptStateImplCopyWithImpl<$Res>
    extends _$ScriptStateCopyWithImpl<$Res, _$ScriptStateImpl>
    implements _$$ScriptStateImplCopyWith<$Res> {
  __$$ScriptStateImplCopyWithImpl(
      _$ScriptStateImpl _value, $Res Function(_$ScriptStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ScriptState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? title = null,
  }) {
    return _then(_$ScriptStateImpl(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ScriptStateImpl implements _ScriptState {
  _$ScriptStateImpl({required this.text, required this.title});

  @override
  final String text;
  @override
  final String title;

  @override
  String toString() {
    return 'ScriptState(text: $text, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScriptStateImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.title, title) || other.title == title));
  }

  @override
  int get hashCode => Object.hash(runtimeType, text, title);

  /// Create a copy of ScriptState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScriptStateImplCopyWith<_$ScriptStateImpl> get copyWith =>
      __$$ScriptStateImplCopyWithImpl<_$ScriptStateImpl>(this, _$identity);
}

abstract class _ScriptState implements ScriptState {
  factory _ScriptState(
      {required final String text,
      required final String title}) = _$ScriptStateImpl;

  @override
  String get text;
  @override
  String get title;

  /// Create a copy of ScriptState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScriptStateImplCopyWith<_$ScriptStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
