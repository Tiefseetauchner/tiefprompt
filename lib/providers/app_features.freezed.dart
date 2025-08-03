// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_features.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppFeatures {

 List<Feature> get features; FeatureKind get featureKind; String? get featureError;
/// Create a copy of AppFeatures
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppFeaturesCopyWith<AppFeatures> get copyWith => _$AppFeaturesCopyWithImpl<AppFeatures>(this as AppFeatures, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppFeatures&&const DeepCollectionEquality().equals(other.features, features)&&(identical(other.featureKind, featureKind) || other.featureKind == featureKind)&&(identical(other.featureError, featureError) || other.featureError == featureError));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(features),featureKind,featureError);

@override
String toString() {
  return 'AppFeatures(features: $features, featureKind: $featureKind, featureError: $featureError)';
}


}

/// @nodoc
abstract mixin class $AppFeaturesCopyWith<$Res>  {
  factory $AppFeaturesCopyWith(AppFeatures value, $Res Function(AppFeatures) _then) = _$AppFeaturesCopyWithImpl;
@useResult
$Res call({
 List<Feature> features, FeatureKind featureKind, String? featureError
});




}
/// @nodoc
class _$AppFeaturesCopyWithImpl<$Res>
    implements $AppFeaturesCopyWith<$Res> {
  _$AppFeaturesCopyWithImpl(this._self, this._then);

  final AppFeatures _self;
  final $Res Function(AppFeatures) _then;

/// Create a copy of AppFeatures
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? features = null,Object? featureKind = null,Object? featureError = freezed,}) {
  return _then(_self.copyWith(
features: null == features ? _self.features : features // ignore: cast_nullable_to_non_nullable
as List<Feature>,featureKind: null == featureKind ? _self.featureKind : featureKind // ignore: cast_nullable_to_non_nullable
as FeatureKind,featureError: freezed == featureError ? _self.featureError : featureError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AppFeatures].
extension AppFeaturesPatterns on AppFeatures {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppFeatures value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppFeatures() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppFeatures value)  $default,){
final _that = this;
switch (_that) {
case _AppFeatures():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppFeatures value)?  $default,){
final _that = this;
switch (_that) {
case _AppFeatures() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Feature> features,  FeatureKind featureKind,  String? featureError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppFeatures() when $default != null:
return $default(_that.features,_that.featureKind,_that.featureError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Feature> features,  FeatureKind featureKind,  String? featureError)  $default,) {final _that = this;
switch (_that) {
case _AppFeatures():
return $default(_that.features,_that.featureKind,_that.featureError);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Feature> features,  FeatureKind featureKind,  String? featureError)?  $default,) {final _that = this;
switch (_that) {
case _AppFeatures() when $default != null:
return $default(_that.features,_that.featureKind,_that.featureError);case _:
  return null;

}
}

}

/// @nodoc


class _AppFeatures implements AppFeatures {
   _AppFeatures(final  List<Feature> features, this.featureKind, this.featureError): _features = features;
  

 final  List<Feature> _features;
@override List<Feature> get features {
  if (_features is EqualUnmodifiableListView) return _features;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_features);
}

@override final  FeatureKind featureKind;
@override final  String? featureError;

/// Create a copy of AppFeatures
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppFeaturesCopyWith<_AppFeatures> get copyWith => __$AppFeaturesCopyWithImpl<_AppFeatures>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppFeatures&&const DeepCollectionEquality().equals(other._features, _features)&&(identical(other.featureKind, featureKind) || other.featureKind == featureKind)&&(identical(other.featureError, featureError) || other.featureError == featureError));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_features),featureKind,featureError);

@override
String toString() {
  return 'AppFeatures(features: $features, featureKind: $featureKind, featureError: $featureError)';
}


}

/// @nodoc
abstract mixin class _$AppFeaturesCopyWith<$Res> implements $AppFeaturesCopyWith<$Res> {
  factory _$AppFeaturesCopyWith(_AppFeatures value, $Res Function(_AppFeatures) _then) = __$AppFeaturesCopyWithImpl;
@override @useResult
$Res call({
 List<Feature> features, FeatureKind featureKind, String? featureError
});




}
/// @nodoc
class __$AppFeaturesCopyWithImpl<$Res>
    implements _$AppFeaturesCopyWith<$Res> {
  __$AppFeaturesCopyWithImpl(this._self, this._then);

  final _AppFeatures _self;
  final $Res Function(_AppFeatures) _then;

/// Create a copy of AppFeatures
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? features = null,Object? featureKind = null,Object? featureError = freezed,}) {
  return _then(_AppFeatures(
null == features ? _self._features : features // ignore: cast_nullable_to_non_nullable
as List<Feature>,null == featureKind ? _self.featureKind : featureKind // ignore: cast_nullable_to_non_nullable
as FeatureKind,freezed == featureError ? _self.featureError : featureError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
