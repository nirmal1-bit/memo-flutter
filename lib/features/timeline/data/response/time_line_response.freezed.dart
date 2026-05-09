// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'time_line_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TimeLineResponse {

@JsonKey(name: 'id') int get id;@JsonKey(name: 'connection_id') int get connectionId;@JsonKey(name: 'initiated_by_user_id') int get initiatedByUserId;@JsonKey(name: 'agora_channel_name') String get agoraChannelName;@JsonKey(name: 'status') String get status;@JsonKey(name: 'summary') String? get summary;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'updated_at') DateTime get updatedAt;
/// Create a copy of TimeLineResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimeLineResponseCopyWith<TimeLineResponse> get copyWith => _$TimeLineResponseCopyWithImpl<TimeLineResponse>(this as TimeLineResponse, _$identity);

  /// Serializes this TimeLineResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimeLineResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.connectionId, connectionId) || other.connectionId == connectionId)&&(identical(other.initiatedByUserId, initiatedByUserId) || other.initiatedByUserId == initiatedByUserId)&&(identical(other.agoraChannelName, agoraChannelName) || other.agoraChannelName == agoraChannelName)&&(identical(other.status, status) || other.status == status)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,connectionId,initiatedByUserId,agoraChannelName,status,summary,createdAt,updatedAt);

@override
String toString() {
  return 'TimeLineResponse(id: $id, connectionId: $connectionId, initiatedByUserId: $initiatedByUserId, agoraChannelName: $agoraChannelName, status: $status, summary: $summary, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $TimeLineResponseCopyWith<$Res>  {
  factory $TimeLineResponseCopyWith(TimeLineResponse value, $Res Function(TimeLineResponse) _then) = _$TimeLineResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') int id,@JsonKey(name: 'connection_id') int connectionId,@JsonKey(name: 'initiated_by_user_id') int initiatedByUserId,@JsonKey(name: 'agora_channel_name') String agoraChannelName,@JsonKey(name: 'status') String status,@JsonKey(name: 'summary') String? summary,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt
});




}
/// @nodoc
class _$TimeLineResponseCopyWithImpl<$Res>
    implements $TimeLineResponseCopyWith<$Res> {
  _$TimeLineResponseCopyWithImpl(this._self, this._then);

  final TimeLineResponse _self;
  final $Res Function(TimeLineResponse) _then;

/// Create a copy of TimeLineResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? connectionId = null,Object? initiatedByUserId = null,Object? agoraChannelName = null,Object? status = null,Object? summary = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,connectionId: null == connectionId ? _self.connectionId : connectionId // ignore: cast_nullable_to_non_nullable
as int,initiatedByUserId: null == initiatedByUserId ? _self.initiatedByUserId : initiatedByUserId // ignore: cast_nullable_to_non_nullable
as int,agoraChannelName: null == agoraChannelName ? _self.agoraChannelName : agoraChannelName // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [TimeLineResponse].
extension TimeLineResponsePatterns on TimeLineResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TimeLineResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TimeLineResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TimeLineResponse value)  $default,){
final _that = this;
switch (_that) {
case _TimeLineResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TimeLineResponse value)?  $default,){
final _that = this;
switch (_that) {
case _TimeLineResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  int id, @JsonKey(name: 'connection_id')  int connectionId, @JsonKey(name: 'initiated_by_user_id')  int initiatedByUserId, @JsonKey(name: 'agora_channel_name')  String agoraChannelName, @JsonKey(name: 'status')  String status, @JsonKey(name: 'summary')  String? summary, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TimeLineResponse() when $default != null:
return $default(_that.id,_that.connectionId,_that.initiatedByUserId,_that.agoraChannelName,_that.status,_that.summary,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  int id, @JsonKey(name: 'connection_id')  int connectionId, @JsonKey(name: 'initiated_by_user_id')  int initiatedByUserId, @JsonKey(name: 'agora_channel_name')  String agoraChannelName, @JsonKey(name: 'status')  String status, @JsonKey(name: 'summary')  String? summary, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _TimeLineResponse():
return $default(_that.id,_that.connectionId,_that.initiatedByUserId,_that.agoraChannelName,_that.status,_that.summary,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  int id, @JsonKey(name: 'connection_id')  int connectionId, @JsonKey(name: 'initiated_by_user_id')  int initiatedByUserId, @JsonKey(name: 'agora_channel_name')  String agoraChannelName, @JsonKey(name: 'status')  String status, @JsonKey(name: 'summary')  String? summary, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _TimeLineResponse() when $default != null:
return $default(_that.id,_that.connectionId,_that.initiatedByUserId,_that.agoraChannelName,_that.status,_that.summary,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TimeLineResponse implements TimeLineResponse {
  const _TimeLineResponse({@JsonKey(name: 'id') required this.id, @JsonKey(name: 'connection_id') required this.connectionId, @JsonKey(name: 'initiated_by_user_id') required this.initiatedByUserId, @JsonKey(name: 'agora_channel_name') required this.agoraChannelName, @JsonKey(name: 'status') required this.status, @JsonKey(name: 'summary') this.summary, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt});
  factory _TimeLineResponse.fromJson(Map<String, dynamic> json) => _$TimeLineResponseFromJson(json);

@override@JsonKey(name: 'id') final  int id;
@override@JsonKey(name: 'connection_id') final  int connectionId;
@override@JsonKey(name: 'initiated_by_user_id') final  int initiatedByUserId;
@override@JsonKey(name: 'agora_channel_name') final  String agoraChannelName;
@override@JsonKey(name: 'status') final  String status;
@override@JsonKey(name: 'summary') final  String? summary;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime updatedAt;

/// Create a copy of TimeLineResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimeLineResponseCopyWith<_TimeLineResponse> get copyWith => __$TimeLineResponseCopyWithImpl<_TimeLineResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TimeLineResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimeLineResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.connectionId, connectionId) || other.connectionId == connectionId)&&(identical(other.initiatedByUserId, initiatedByUserId) || other.initiatedByUserId == initiatedByUserId)&&(identical(other.agoraChannelName, agoraChannelName) || other.agoraChannelName == agoraChannelName)&&(identical(other.status, status) || other.status == status)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,connectionId,initiatedByUserId,agoraChannelName,status,summary,createdAt,updatedAt);

@override
String toString() {
  return 'TimeLineResponse(id: $id, connectionId: $connectionId, initiatedByUserId: $initiatedByUserId, agoraChannelName: $agoraChannelName, status: $status, summary: $summary, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$TimeLineResponseCopyWith<$Res> implements $TimeLineResponseCopyWith<$Res> {
  factory _$TimeLineResponseCopyWith(_TimeLineResponse value, $Res Function(_TimeLineResponse) _then) = __$TimeLineResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') int id,@JsonKey(name: 'connection_id') int connectionId,@JsonKey(name: 'initiated_by_user_id') int initiatedByUserId,@JsonKey(name: 'agora_channel_name') String agoraChannelName,@JsonKey(name: 'status') String status,@JsonKey(name: 'summary') String? summary,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt
});




}
/// @nodoc
class __$TimeLineResponseCopyWithImpl<$Res>
    implements _$TimeLineResponseCopyWith<$Res> {
  __$TimeLineResponseCopyWithImpl(this._self, this._then);

  final _TimeLineResponse _self;
  final $Res Function(_TimeLineResponse) _then;

/// Create a copy of TimeLineResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? connectionId = null,Object? initiatedByUserId = null,Object? agoraChannelName = null,Object? status = null,Object? summary = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_TimeLineResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,connectionId: null == connectionId ? _self.connectionId : connectionId // ignore: cast_nullable_to_non_nullable
as int,initiatedByUserId: null == initiatedByUserId ? _self.initiatedByUserId : initiatedByUserId // ignore: cast_nullable_to_non_nullable
as int,agoraChannelName: null == agoraChannelName ? _self.agoraChannelName : agoraChannelName // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
