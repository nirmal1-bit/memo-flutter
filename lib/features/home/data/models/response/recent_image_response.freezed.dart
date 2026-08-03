// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recent_image_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RecentImageResponse {

 int get id;@JsonKey(name: 'user_id') int get userId; String get url; String? get description;@JsonKey(name: 'created_at') DateTime get createdAt;
/// Create a copy of RecentImageResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecentImageResponseCopyWith<RecentImageResponse> get copyWith => _$RecentImageResponseCopyWithImpl<RecentImageResponse>(this as RecentImageResponse, _$identity);

  /// Serializes this RecentImageResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecentImageResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.url, url) || other.url == url)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,url,description,createdAt);

@override
String toString() {
  return 'RecentImageResponse(id: $id, userId: $userId, url: $url, description: $description, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $RecentImageResponseCopyWith<$Res>  {
  factory $RecentImageResponseCopyWith(RecentImageResponse value, $Res Function(RecentImageResponse) _then) = _$RecentImageResponseCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'user_id') int userId, String url, String? description,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class _$RecentImageResponseCopyWithImpl<$Res>
    implements $RecentImageResponseCopyWith<$Res> {
  _$RecentImageResponseCopyWithImpl(this._self, this._then);

  final RecentImageResponse _self;
  final $Res Function(RecentImageResponse) _then;

/// Create a copy of RecentImageResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? url = null,Object? description = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [RecentImageResponse].
extension RecentImageResponsePatterns on RecentImageResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecentImageResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecentImageResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecentImageResponse value)  $default,){
final _that = this;
switch (_that) {
case _RecentImageResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecentImageResponse value)?  $default,){
final _that = this;
switch (_that) {
case _RecentImageResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'user_id')  int userId,  String url,  String? description, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecentImageResponse() when $default != null:
return $default(_that.id,_that.userId,_that.url,_that.description,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'user_id')  int userId,  String url,  String? description, @JsonKey(name: 'created_at')  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _RecentImageResponse():
return $default(_that.id,_that.userId,_that.url,_that.description,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'user_id')  int userId,  String url,  String? description, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _RecentImageResponse() when $default != null:
return $default(_that.id,_that.userId,_that.url,_that.description,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RecentImageResponse implements RecentImageResponse {
  const _RecentImageResponse({required this.id, @JsonKey(name: 'user_id') required this.userId, required this.url, required this.description, @JsonKey(name: 'created_at') required this.createdAt});
  factory _RecentImageResponse.fromJson(Map<String, dynamic> json) => _$RecentImageResponseFromJson(json);

@override final  int id;
@override@JsonKey(name: 'user_id') final  int userId;
@override final  String url;
@override final  String? description;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;

/// Create a copy of RecentImageResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecentImageResponseCopyWith<_RecentImageResponse> get copyWith => __$RecentImageResponseCopyWithImpl<_RecentImageResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecentImageResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecentImageResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.url, url) || other.url == url)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,url,description,createdAt);

@override
String toString() {
  return 'RecentImageResponse(id: $id, userId: $userId, url: $url, description: $description, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$RecentImageResponseCopyWith<$Res> implements $RecentImageResponseCopyWith<$Res> {
  factory _$RecentImageResponseCopyWith(_RecentImageResponse value, $Res Function(_RecentImageResponse) _then) = __$RecentImageResponseCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'user_id') int userId, String url, String? description,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class __$RecentImageResponseCopyWithImpl<$Res>
    implements _$RecentImageResponseCopyWith<$Res> {
  __$RecentImageResponseCopyWithImpl(this._self, this._then);

  final _RecentImageResponse _self;
  final $Res Function(_RecentImageResponse) _then;

/// Create a copy of RecentImageResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? url = null,Object? description = freezed,Object? createdAt = null,}) {
  return _then(_RecentImageResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
