// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'combining_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CombinedState {

 List<Object> get states;
/// Create a copy of CombinedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CombinedStateCopyWith<CombinedState> get copyWith => _$CombinedStateCopyWithImpl<CombinedState>(this as CombinedState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CombinedState&&const DeepCollectionEquality().equals(other.states, states));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(states));

@override
String toString() {
  return 'CombinedState(states: $states)';
}


}

/// @nodoc
abstract mixin class $CombinedStateCopyWith<$Res>  {
  factory $CombinedStateCopyWith(CombinedState value, $Res Function(CombinedState) _then) = _$CombinedStateCopyWithImpl;
@useResult
$Res call({
 List<Object> states
});




}
/// @nodoc
class _$CombinedStateCopyWithImpl<$Res>
    implements $CombinedStateCopyWith<$Res> {
  _$CombinedStateCopyWithImpl(this._self, this._then);

  final CombinedState _self;
  final $Res Function(CombinedState) _then;

/// Create a copy of CombinedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? states = null,}) {
  return _then(_self.copyWith(
states: null == states ? _self.states : states // ignore: cast_nullable_to_non_nullable
as List<Object>,
  ));
}

}


/// Adds pattern-matching-related methods to [CombinedState].
extension CombinedStatePatterns on CombinedState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CombinedState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CombinedState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CombinedState value)  $default,){
final _that = this;
switch (_that) {
case _CombinedState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CombinedState value)?  $default,){
final _that = this;
switch (_that) {
case _CombinedState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Object> states)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CombinedState() when $default != null:
return $default(_that.states);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Object> states)  $default,) {final _that = this;
switch (_that) {
case _CombinedState():
return $default(_that.states);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Object> states)?  $default,) {final _that = this;
switch (_that) {
case _CombinedState() when $default != null:
return $default(_that.states);case _:
  return null;

}
}

}

/// @nodoc


class _CombinedState implements CombinedState {
   _CombinedState(final  List<Object> states): _states = states;
  

 final  List<Object> _states;
@override List<Object> get states {
  if (_states is EqualUnmodifiableListView) return _states;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_states);
}


/// Create a copy of CombinedState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CombinedStateCopyWith<_CombinedState> get copyWith => __$CombinedStateCopyWithImpl<_CombinedState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CombinedState&&const DeepCollectionEquality().equals(other._states, _states));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_states));

@override
String toString() {
  return 'CombinedState(states: $states)';
}


}

/// @nodoc
abstract mixin class _$CombinedStateCopyWith<$Res> implements $CombinedStateCopyWith<$Res> {
  factory _$CombinedStateCopyWith(_CombinedState value, $Res Function(_CombinedState) _then) = __$CombinedStateCopyWithImpl;
@override @useResult
$Res call({
 List<Object> states
});




}
/// @nodoc
class __$CombinedStateCopyWithImpl<$Res>
    implements _$CombinedStateCopyWith<$Res> {
  __$CombinedStateCopyWithImpl(this._self, this._then);

  final _CombinedState _self;
  final $Res Function(_CombinedState) _then;

/// Create a copy of CombinedState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? states = null,}) {
  return _then(_CombinedState(
null == states ? _self._states : states // ignore: cast_nullable_to_non_nullable
as List<Object>,
  ));
}


}

// dart format on
