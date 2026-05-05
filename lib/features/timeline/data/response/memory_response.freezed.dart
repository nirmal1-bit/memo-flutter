// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'memory_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MemoryResponse {

 int get id;@JsonKey(name: 'connection_id') int get connectionId;@JsonKey(name: 'person_id') int get personId; String get content; String get type;@JsonKey(name: 'created_at') DateTime get createdAt;
/// Create a copy of MemoryResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemoryResponseCopyWith<MemoryResponse> get copyWith => _$MemoryResponseCopyWithImpl<MemoryResponse>(this as MemoryResponse, _$identity);

  /// Serializes this MemoryResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemoryResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.connectionId, connectionId) || other.connectionId == connectionId)&&(identical(other.personId, personId) || other.personId == personId)&&(identical(other.content, content) || other.content == content)&&(identical(other.type, type) || other.type == type)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,connectionId,personId,content,type,createdAt);

@override
String toString() {
  return 'MemoryResponse(id: $id, connectionId: $connectionId, personId: $personId, content: $content, type: $type, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $MemoryResponseCopyWith<$Res>  {
  factory $MemoryResponseCopyWith(MemoryResponse value, $Res Function(MemoryResponse) _then) = _$MemoryResponseCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'connection_id') int connectionId,@JsonKey(name: 'person_id') int personId, String content, String type,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class _$MemoryResponseCopyWithImpl<$Res>
    implements $MemoryResponseCopyWith<$Res> {
  _$MemoryResponseCopyWithImpl(this._self, this._then);

  final MemoryResponse _self;
  final $Res Function(MemoryResponse) _then;

/// Create a copy of MemoryResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? connectionId = null,Object? personId = null,Object? content = null,Object? type = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,connectionId: null == connectionId ? _self.connectionId : connectionId // ignore: cast_nullable_to_non_nullable
as int,personId: null == personId ? _self.personId : personId // ignore: cast_nullable_to_non_nullable
as int,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [MemoryResponse].
extension MemoryResponsePatterns on MemoryResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemoryResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemoryResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemoryResponse value)  $default,){
final _that = this;
switch (_that) {
case _MemoryResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemoryResponse value)?  $default,){
final _that = this;
switch (_that) {
case _MemoryResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'connection_id')  int connectionId, @JsonKey(name: 'person_id')  int personId,  String content,  String type, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemoryResponse() when $default != null:
return $default(_that.id,_that.connectionId,_that.personId,_that.content,_that.type,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'connection_id')  int connectionId, @JsonKey(name: 'person_id')  int personId,  String content,  String type, @JsonKey(name: 'created_at')  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _MemoryResponse():
return $default(_that.id,_that.connectionId,_that.personId,_that.content,_that.type,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'connection_id')  int connectionId, @JsonKey(name: 'person_id')  int personId,  String content,  String type, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _MemoryResponse() when $default != null:
return $default(_that.id,_that.connectionId,_that.personId,_that.content,_that.type,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MemoryResponse implements MemoryResponse {
  const _MemoryResponse({required this.id, @JsonKey(name: 'connection_id') required this.connectionId, @JsonKey(name: 'person_id') required this.personId, required this.content, required this.type, @JsonKey(name: 'created_at') required this.createdAt});
  factory _MemoryResponse.fromJson(Map<String, dynamic> json) => _$MemoryResponseFromJson(json);

@override final  int id;
@override@JsonKey(name: 'connection_id') final  int connectionId;
@override@JsonKey(name: 'person_id') final  int personId;
@override final  String content;
@override final  String type;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;

/// Create a copy of MemoryResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemoryResponseCopyWith<_MemoryResponse> get copyWith => __$MemoryResponseCopyWithImpl<_MemoryResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MemoryResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemoryResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.connectionId, connectionId) || other.connectionId == connectionId)&&(identical(other.personId, personId) || other.personId == personId)&&(identical(other.content, content) || other.content == content)&&(identical(other.type, type) || other.type == type)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,connectionId,personId,content,type,createdAt);

@override
String toString() {
  return 'MemoryResponse(id: $id, connectionId: $connectionId, personId: $personId, content: $content, type: $type, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$MemoryResponseCopyWith<$Res> implements $MemoryResponseCopyWith<$Res> {
  factory _$MemoryResponseCopyWith(_MemoryResponse value, $Res Function(_MemoryResponse) _then) = __$MemoryResponseCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'connection_id') int connectionId,@JsonKey(name: 'person_id') int personId, String content, String type,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class __$MemoryResponseCopyWithImpl<$Res>
    implements _$MemoryResponseCopyWith<$Res> {
  __$MemoryResponseCopyWithImpl(this._self, this._then);

  final _MemoryResponse _self;
  final $Res Function(_MemoryResponse) _then;

/// Create a copy of MemoryResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? connectionId = null,Object? personId = null,Object? content = null,Object? type = null,Object? createdAt = null,}) {
  return _then(_MemoryResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,connectionId: null == connectionId ? _self.connectionId : connectionId // ignore: cast_nullable_to_non_nullable
as int,personId: null == personId ? _self.personId : personId // ignore: cast_nullable_to_non_nullable
as int,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
