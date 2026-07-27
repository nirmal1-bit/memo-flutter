// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'face_verify_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FaceVerifyResponse {

 double get similarity; bool get verified;
/// Create a copy of FaceVerifyResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FaceVerifyResponseCopyWith<FaceVerifyResponse> get copyWith => _$FaceVerifyResponseCopyWithImpl<FaceVerifyResponse>(this as FaceVerifyResponse, _$identity);

  /// Serializes this FaceVerifyResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FaceVerifyResponse&&(identical(other.similarity, similarity) || other.similarity == similarity)&&(identical(other.verified, verified) || other.verified == verified));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,similarity,verified);

@override
String toString() {
  return 'FaceVerifyResponse(similarity: $similarity, verified: $verified)';
}


}

/// @nodoc
abstract mixin class $FaceVerifyResponseCopyWith<$Res>  {
  factory $FaceVerifyResponseCopyWith(FaceVerifyResponse value, $Res Function(FaceVerifyResponse) _then) = _$FaceVerifyResponseCopyWithImpl;
@useResult
$Res call({
 double similarity, bool verified
});




}
/// @nodoc
class _$FaceVerifyResponseCopyWithImpl<$Res>
    implements $FaceVerifyResponseCopyWith<$Res> {
  _$FaceVerifyResponseCopyWithImpl(this._self, this._then);

  final FaceVerifyResponse _self;
  final $Res Function(FaceVerifyResponse) _then;

/// Create a copy of FaceVerifyResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? similarity = null,Object? verified = null,}) {
  return _then(_self.copyWith(
similarity: null == similarity ? _self.similarity : similarity // ignore: cast_nullable_to_non_nullable
as double,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [FaceVerifyResponse].
extension FaceVerifyResponsePatterns on FaceVerifyResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FaceVerifyResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FaceVerifyResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FaceVerifyResponse value)  $default,){
final _that = this;
switch (_that) {
case _FaceVerifyResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FaceVerifyResponse value)?  $default,){
final _that = this;
switch (_that) {
case _FaceVerifyResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double similarity,  bool verified)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FaceVerifyResponse() when $default != null:
return $default(_that.similarity,_that.verified);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double similarity,  bool verified)  $default,) {final _that = this;
switch (_that) {
case _FaceVerifyResponse():
return $default(_that.similarity,_that.verified);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double similarity,  bool verified)?  $default,) {final _that = this;
switch (_that) {
case _FaceVerifyResponse() when $default != null:
return $default(_that.similarity,_that.verified);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FaceVerifyResponse implements FaceVerifyResponse {
  const _FaceVerifyResponse({required this.similarity, required this.verified});
  factory _FaceVerifyResponse.fromJson(Map<String, dynamic> json) => _$FaceVerifyResponseFromJson(json);

@override final  double similarity;
@override final  bool verified;

/// Create a copy of FaceVerifyResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FaceVerifyResponseCopyWith<_FaceVerifyResponse> get copyWith => __$FaceVerifyResponseCopyWithImpl<_FaceVerifyResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FaceVerifyResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FaceVerifyResponse&&(identical(other.similarity, similarity) || other.similarity == similarity)&&(identical(other.verified, verified) || other.verified == verified));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,similarity,verified);

@override
String toString() {
  return 'FaceVerifyResponse(similarity: $similarity, verified: $verified)';
}


}

/// @nodoc
abstract mixin class _$FaceVerifyResponseCopyWith<$Res> implements $FaceVerifyResponseCopyWith<$Res> {
  factory _$FaceVerifyResponseCopyWith(_FaceVerifyResponse value, $Res Function(_FaceVerifyResponse) _then) = __$FaceVerifyResponseCopyWithImpl;
@override @useResult
$Res call({
 double similarity, bool verified
});




}
/// @nodoc
class __$FaceVerifyResponseCopyWithImpl<$Res>
    implements _$FaceVerifyResponseCopyWith<$Res> {
  __$FaceVerifyResponseCopyWithImpl(this._self, this._then);

  final _FaceVerifyResponse _self;
  final $Res Function(_FaceVerifyResponse) _then;

/// Create a copy of FaceVerifyResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? similarity = null,Object? verified = null,}) {
  return _then(_FaceVerifyResponse(
similarity: null == similarity ? _self.similarity : similarity // ignore: cast_nullable_to_non_nullable
as double,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
