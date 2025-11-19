// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'in_app_purchase_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InAppPurchaseDataState {

 List<ProductDetails> get products; Set<String> get owned;
/// Create a copy of InAppPurchaseDataState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InAppPurchaseDataStateCopyWith<InAppPurchaseDataState> get copyWith => _$InAppPurchaseDataStateCopyWithImpl<InAppPurchaseDataState>(this as InAppPurchaseDataState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InAppPurchaseDataState&&const DeepCollectionEquality().equals(other.products, products)&&const DeepCollectionEquality().equals(other.owned, owned));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(products),const DeepCollectionEquality().hash(owned));

@override
String toString() {
  return 'InAppPurchaseDataState(products: $products, owned: $owned)';
}


}

/// @nodoc
abstract mixin class $InAppPurchaseDataStateCopyWith<$Res>  {
  factory $InAppPurchaseDataStateCopyWith(InAppPurchaseDataState value, $Res Function(InAppPurchaseDataState) _then) = _$InAppPurchaseDataStateCopyWithImpl;
@useResult
$Res call({
 List<ProductDetails> products, Set<String> owned
});




}
/// @nodoc
class _$InAppPurchaseDataStateCopyWithImpl<$Res>
    implements $InAppPurchaseDataStateCopyWith<$Res> {
  _$InAppPurchaseDataStateCopyWithImpl(this._self, this._then);

  final InAppPurchaseDataState _self;
  final $Res Function(InAppPurchaseDataState) _then;

/// Create a copy of InAppPurchaseDataState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? products = null,Object? owned = null,}) {
  return _then(_self.copyWith(
products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as List<ProductDetails>,owned: null == owned ? _self.owned : owned // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [InAppPurchaseDataState].
extension InAppPurchaseDataStatePatterns on InAppPurchaseDataState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InAppPurchaseDataState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InAppPurchaseDataState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InAppPurchaseDataState value)  $default,){
final _that = this;
switch (_that) {
case _InAppPurchaseDataState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InAppPurchaseDataState value)?  $default,){
final _that = this;
switch (_that) {
case _InAppPurchaseDataState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ProductDetails> products,  Set<String> owned)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InAppPurchaseDataState() when $default != null:
return $default(_that.products,_that.owned);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ProductDetails> products,  Set<String> owned)  $default,) {final _that = this;
switch (_that) {
case _InAppPurchaseDataState():
return $default(_that.products,_that.owned);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ProductDetails> products,  Set<String> owned)?  $default,) {final _that = this;
switch (_that) {
case _InAppPurchaseDataState() when $default != null:
return $default(_that.products,_that.owned);case _:
  return null;

}
}

}

/// @nodoc


class _InAppPurchaseDataState implements InAppPurchaseDataState {
   _InAppPurchaseDataState({required final  List<ProductDetails> products, required final  Set<String> owned}): _products = products,_owned = owned;
  

 final  List<ProductDetails> _products;
@override List<ProductDetails> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}

 final  Set<String> _owned;
@override Set<String> get owned {
  if (_owned is EqualUnmodifiableSetView) return _owned;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_owned);
}


/// Create a copy of InAppPurchaseDataState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InAppPurchaseDataStateCopyWith<_InAppPurchaseDataState> get copyWith => __$InAppPurchaseDataStateCopyWithImpl<_InAppPurchaseDataState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InAppPurchaseDataState&&const DeepCollectionEquality().equals(other._products, _products)&&const DeepCollectionEquality().equals(other._owned, _owned));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_products),const DeepCollectionEquality().hash(_owned));

@override
String toString() {
  return 'InAppPurchaseDataState(products: $products, owned: $owned)';
}


}

/// @nodoc
abstract mixin class _$InAppPurchaseDataStateCopyWith<$Res> implements $InAppPurchaseDataStateCopyWith<$Res> {
  factory _$InAppPurchaseDataStateCopyWith(_InAppPurchaseDataState value, $Res Function(_InAppPurchaseDataState) _then) = __$InAppPurchaseDataStateCopyWithImpl;
@override @useResult
$Res call({
 List<ProductDetails> products, Set<String> owned
});




}
/// @nodoc
class __$InAppPurchaseDataStateCopyWithImpl<$Res>
    implements _$InAppPurchaseDataStateCopyWith<$Res> {
  __$InAppPurchaseDataStateCopyWithImpl(this._self, this._then);

  final _InAppPurchaseDataState _self;
  final $Res Function(_InAppPurchaseDataState) _then;

/// Create a copy of InAppPurchaseDataState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? products = null,Object? owned = null,}) {
  return _then(_InAppPurchaseDataState(
products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<ProductDetails>,owned: null == owned ? _self._owned : owned // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}


}

// dart format on
