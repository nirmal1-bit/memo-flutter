// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bucket_item_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BucketItemRequest {

 String get title; String get category;
/// Create a copy of BucketItemRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BucketItemRequestCopyWith<BucketItemRequest> get copyWith => _$BucketItemRequestCopyWithImpl<BucketItemRequest>(this as BucketItemRequest, _$identity);

  /// Serializes this BucketItemRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BucketItemRequest&&(identical(other.title, title) || other.title == title)&&(identical(other.category, category) || other.category == category));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,category);

@override
String toString() {
  return 'BucketItemRequest(title: $title, category: $category)';
}


}

/// @nodoc
abstract mixin class $BucketItemRequestCopyWith<$Res>  {
  factory $BucketItemRequestCopyWith(BucketItemRequest value, $Res Function(BucketItemRequest) _then) = _$BucketItemRequestCopyWithImpl;
@useResult
$Res call({
 String title, String category
});




}
/// @nodoc
class _$BucketItemRequestCopyWithImpl<$Res>
    implements $BucketItemRequestCopyWith<$Res> {
  _$BucketItemRequestCopyWithImpl(this._self, this._then);

  final BucketItemRequest _self;
  final $Res Function(BucketItemRequest) _then;

/// Create a copy of BucketItemRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? category = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BucketItemRequest].
extension BucketItemRequestPatterns on BucketItemRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BucketItemRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BucketItemRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BucketItemRequest value)  $default,){
final _that = this;
switch (_that) {
case _BucketItemRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BucketItemRequest value)?  $default,){
final _that = this;
switch (_that) {
case _BucketItemRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String category)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BucketItemRequest() when $default != null:
return $default(_that.title,_that.category);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String category)  $default,) {final _that = this;
switch (_that) {
case _BucketItemRequest():
return $default(_that.title,_that.category);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String category)?  $default,) {final _that = this;
switch (_that) {
case _BucketItemRequest() when $default != null:
return $default(_that.title,_that.category);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BucketItemRequest implements BucketItemRequest {
  const _BucketItemRequest({required this.title, required this.category});
  factory _BucketItemRequest.fromJson(Map<String, dynamic> json) => _$BucketItemRequestFromJson(json);

@override final  String title;
@override final  String category;

/// Create a copy of BucketItemRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BucketItemRequestCopyWith<_BucketItemRequest> get copyWith => __$BucketItemRequestCopyWithImpl<_BucketItemRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BucketItemRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BucketItemRequest&&(identical(other.title, title) || other.title == title)&&(identical(other.category, category) || other.category == category));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,category);

@override
String toString() {
  return 'BucketItemRequest(title: $title, category: $category)';
}


}

/// @nodoc
abstract mixin class _$BucketItemRequestCopyWith<$Res> implements $BucketItemRequestCopyWith<$Res> {
  factory _$BucketItemRequestCopyWith(_BucketItemRequest value, $Res Function(_BucketItemRequest) _then) = __$BucketItemRequestCopyWithImpl;
@override @useResult
$Res call({
 String title, String category
});




}
/// @nodoc
class __$BucketItemRequestCopyWithImpl<$Res>
    implements _$BucketItemRequestCopyWith<$Res> {
  __$BucketItemRequestCopyWithImpl(this._self, this._then);

  final _BucketItemRequest _self;
  final $Res Function(_BucketItemRequest) _then;

/// Create a copy of BucketItemRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? category = null,}) {
  return _then(_BucketItemRequest(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
