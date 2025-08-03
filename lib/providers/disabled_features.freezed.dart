// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'disabled_features.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DisabledFeatures {

 List<Feature> get features;
/// Create a copy of DisabledFeatures
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DisabledFeaturesCopyWith<DisabledFeatures> get copyWith => _$DisabledFeaturesCopyWithImpl<DisabledFeatures>(this as DisabledFeatures, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DisabledFeatures&&const DeepCollectionEquality().equals(other.features, features));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(features));

@override
String toString() {
  return 'DisabledFeatures(features: $features)';
}


}

/// @nodoc
abstract mixin class $DisabledFeaturesCopyWith<$Res>  {
  factory $DisabledFeaturesCopyWith(DisabledFeatures value, $Res Function(DisabledFeatures) _then) = _$DisabledFeaturesCopyWithImpl;
@useResult
$Res call({
 List<Feature> features
});




}
/// @nodoc
class _$DisabledFeaturesCopyWithImpl<$Res>
    implements $DisabledFeaturesCopyWith<$Res> {
  _$DisabledFeaturesCopyWithImpl(this._self, this._then);

  final DisabledFeatures _self;
  final $Res Function(DisabledFeatures) _then;

/// Create a copy of DisabledFeatures
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? features = null,}) {
  return _then(_self.copyWith(
features: null == features ? _self.features : features // ignore: cast_nullable_to_non_nullable
as List<Feature>,
  ));
}

}


/// Adds pattern-matching-related methods to [DisabledFeatures].
extension DisabledFeaturesPatterns on DisabledFeatures {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DisabledFeatures value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DisabledFeatures() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DisabledFeatures value)  $default,){
final _that = this;
switch (_that) {
case _DisabledFeatures():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DisabledFeatures value)?  $default,){
final _that = this;
switch (_that) {
case _DisabledFeatures() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Feature> features)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DisabledFeatures() when $default != null:
return $default(_that.features);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Feature> features)  $default,) {final _that = this;
switch (_that) {
case _DisabledFeatures():
return $default(_that.features);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Feature> features)?  $default,) {final _that = this;
switch (_that) {
case _DisabledFeatures() when $default != null:
return $default(_that.features);case _:
  return null;

}
}

}

/// @nodoc


class _DisabledFeatures implements DisabledFeatures {
   _DisabledFeatures(final  List<Feature> features): _features = features;
  

 final  List<Feature> _features;
@override List<Feature> get features {
  if (_features is EqualUnmodifiableListView) return _features;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_features);
}


/// Create a copy of DisabledFeatures
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DisabledFeaturesCopyWith<_DisabledFeatures> get copyWith => __$DisabledFeaturesCopyWithImpl<_DisabledFeatures>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DisabledFeatures&&const DeepCollectionEquality().equals(other._features, _features));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_features));

@override
String toString() {
  return 'DisabledFeatures(features: $features)';
}


}

/// @nodoc
abstract mixin class _$DisabledFeaturesCopyWith<$Res> implements $DisabledFeaturesCopyWith<$Res> {
  factory _$DisabledFeaturesCopyWith(_DisabledFeatures value, $Res Function(_DisabledFeatures) _then) = __$DisabledFeaturesCopyWithImpl;
@override @useResult
$Res call({
 List<Feature> features
});




}
/// @nodoc
class __$DisabledFeaturesCopyWithImpl<$Res>
    implements _$DisabledFeaturesCopyWith<$Res> {
  __$DisabledFeaturesCopyWithImpl(this._self, this._then);

  final _DisabledFeatures _self;
  final $Res Function(_DisabledFeatures) _then;

/// Create a copy of DisabledFeatures
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? features = null,}) {
  return _then(_DisabledFeatures(
null == features ? _self._features : features // ignore: cast_nullable_to_non_nullable
as List<Feature>,
  ));
}


}

// dart format on
