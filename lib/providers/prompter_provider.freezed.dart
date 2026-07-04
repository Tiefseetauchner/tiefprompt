// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prompter_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PrompterState {

 bool get isPlaying; bool get displayCountdown; PrompterConfiguration get config;
/// Create a copy of PrompterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrompterStateCopyWith<PrompterState> get copyWith => _$PrompterStateCopyWithImpl<PrompterState>(this as PrompterState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrompterState&&(identical(other.isPlaying, isPlaying) || other.isPlaying == isPlaying)&&(identical(other.displayCountdown, displayCountdown) || other.displayCountdown == displayCountdown)&&(identical(other.config, config) || other.config == config));
}


@override
int get hashCode => Object.hash(runtimeType,isPlaying,displayCountdown,config);

@override
String toString() {
  return 'PrompterState(isPlaying: $isPlaying, displayCountdown: $displayCountdown, config: $config)';
}


}

/// @nodoc
abstract mixin class $PrompterStateCopyWith<$Res>  {
  factory $PrompterStateCopyWith(PrompterState value, $Res Function(PrompterState) _then) = _$PrompterStateCopyWithImpl;
@useResult
$Res call({
 bool isPlaying, bool displayCountdown, PrompterConfiguration config
});


$PrompterConfigurationCopyWith<$Res> get config;

}
/// @nodoc
class _$PrompterStateCopyWithImpl<$Res>
    implements $PrompterStateCopyWith<$Res> {
  _$PrompterStateCopyWithImpl(this._self, this._then);

  final PrompterState _self;
  final $Res Function(PrompterState) _then;

/// Create a copy of PrompterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isPlaying = null,Object? displayCountdown = null,Object? config = null,}) {
  return _then(_self.copyWith(
isPlaying: null == isPlaying ? _self.isPlaying : isPlaying // ignore: cast_nullable_to_non_nullable
as bool,displayCountdown: null == displayCountdown ? _self.displayCountdown : displayCountdown // ignore: cast_nullable_to_non_nullable
as bool,config: null == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as PrompterConfiguration,
  ));
}
/// Create a copy of PrompterState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PrompterConfigurationCopyWith<$Res> get config {
  
  return $PrompterConfigurationCopyWith<$Res>(_self.config, (value) {
    return _then(_self.copyWith(config: value));
  });
}
}


/// Adds pattern-matching-related methods to [PrompterState].
extension PrompterStatePatterns on PrompterState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrompterState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrompterState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrompterState value)  $default,){
final _that = this;
switch (_that) {
case _PrompterState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrompterState value)?  $default,){
final _that = this;
switch (_that) {
case _PrompterState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isPlaying,  bool displayCountdown,  PrompterConfiguration config)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrompterState() when $default != null:
return $default(_that.isPlaying,_that.displayCountdown,_that.config);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isPlaying,  bool displayCountdown,  PrompterConfiguration config)  $default,) {final _that = this;
switch (_that) {
case _PrompterState():
return $default(_that.isPlaying,_that.displayCountdown,_that.config);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isPlaying,  bool displayCountdown,  PrompterConfiguration config)?  $default,) {final _that = this;
switch (_that) {
case _PrompterState() when $default != null:
return $default(_that.isPlaying,_that.displayCountdown,_that.config);case _:
  return null;

}
}

}

/// @nodoc


class _PrompterState implements PrompterState {
   _PrompterState({this.isPlaying = false, this.displayCountdown = false, this.config = const PrompterConfiguration()});
  

@override@JsonKey() final  bool isPlaying;
@override@JsonKey() final  bool displayCountdown;
@override@JsonKey() final  PrompterConfiguration config;

/// Create a copy of PrompterState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrompterStateCopyWith<_PrompterState> get copyWith => __$PrompterStateCopyWithImpl<_PrompterState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrompterState&&(identical(other.isPlaying, isPlaying) || other.isPlaying == isPlaying)&&(identical(other.displayCountdown, displayCountdown) || other.displayCountdown == displayCountdown)&&(identical(other.config, config) || other.config == config));
}


@override
int get hashCode => Object.hash(runtimeType,isPlaying,displayCountdown,config);

@override
String toString() {
  return 'PrompterState(isPlaying: $isPlaying, displayCountdown: $displayCountdown, config: $config)';
}


}

/// @nodoc
abstract mixin class _$PrompterStateCopyWith<$Res> implements $PrompterStateCopyWith<$Res> {
  factory _$PrompterStateCopyWith(_PrompterState value, $Res Function(_PrompterState) _then) = __$PrompterStateCopyWithImpl;
@override @useResult
$Res call({
 bool isPlaying, bool displayCountdown, PrompterConfiguration config
});


@override $PrompterConfigurationCopyWith<$Res> get config;

}
/// @nodoc
class __$PrompterStateCopyWithImpl<$Res>
    implements _$PrompterStateCopyWith<$Res> {
  __$PrompterStateCopyWithImpl(this._self, this._then);

  final _PrompterState _self;
  final $Res Function(_PrompterState) _then;

/// Create a copy of PrompterState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isPlaying = null,Object? displayCountdown = null,Object? config = null,}) {
  return _then(_PrompterState(
isPlaying: null == isPlaying ? _self.isPlaying : isPlaying // ignore: cast_nullable_to_non_nullable
as bool,displayCountdown: null == displayCountdown ? _self.displayCountdown : displayCountdown // ignore: cast_nullable_to_non_nullable
as bool,config: null == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as PrompterConfiguration,
  ));
}

/// Create a copy of PrompterState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PrompterConfigurationCopyWith<$Res> get config {
  
  return $PrompterConfigurationCopyWith<$Res>(_self.config, (value) {
    return _then(_self.copyWith(config: value));
  });
}
}

// dart format on
