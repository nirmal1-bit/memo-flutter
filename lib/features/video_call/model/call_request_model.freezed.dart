// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CallRequestModel {

 String get token; String get channel;@JsonKey(name: 'app_id') String get appId;@JsonKey(name: 'video_call_session_id') int get videoCallSessionId;
/// Create a copy of CallRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallRequestModelCopyWith<CallRequestModel> get copyWith => _$CallRequestModelCopyWithImpl<CallRequestModel>(this as CallRequestModel, _$identity);

  /// Serializes this CallRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallRequestModel&&(identical(other.token, token) || other.token == token)&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.appId, appId) || other.appId == appId)&&(identical(other.videoCallSessionId, videoCallSessionId) || other.videoCallSessionId == videoCallSessionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token,channel,appId,videoCallSessionId);

@override
String toString() {
  return 'CallRequestModel(token: $token, channel: $channel, appId: $appId, videoCallSessionId: $videoCallSessionId)';
}


}

/// @nodoc
abstract mixin class $CallRequestModelCopyWith<$Res>  {
  factory $CallRequestModelCopyWith(CallRequestModel value, $Res Function(CallRequestModel) _then) = _$CallRequestModelCopyWithImpl;
@useResult
$Res call({
 String token, String channel,@JsonKey(name: 'app_id') String appId,@JsonKey(name: 'video_call_session_id') int videoCallSessionId
});




}
/// @nodoc
class _$CallRequestModelCopyWithImpl<$Res>
    implements $CallRequestModelCopyWith<$Res> {
  _$CallRequestModelCopyWithImpl(this._self, this._then);

  final CallRequestModel _self;
  final $Res Function(CallRequestModel) _then;

/// Create a copy of CallRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? token = null,Object? channel = null,Object? appId = null,Object? videoCallSessionId = null,}) {
  return _then(_self.copyWith(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,channel: null == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as String,appId: null == appId ? _self.appId : appId // ignore: cast_nullable_to_non_nullable
as String,videoCallSessionId: null == videoCallSessionId ? _self.videoCallSessionId : videoCallSessionId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CallRequestModel].
extension CallRequestModelPatterns on CallRequestModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallRequestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallRequestModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallRequestModel value)  $default,){
final _that = this;
switch (_that) {
case _CallRequestModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallRequestModel value)?  $default,){
final _that = this;
switch (_that) {
case _CallRequestModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String token,  String channel, @JsonKey(name: 'app_id')  String appId, @JsonKey(name: 'video_call_session_id')  int videoCallSessionId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallRequestModel() when $default != null:
return $default(_that.token,_that.channel,_that.appId,_that.videoCallSessionId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String token,  String channel, @JsonKey(name: 'app_id')  String appId, @JsonKey(name: 'video_call_session_id')  int videoCallSessionId)  $default,) {final _that = this;
switch (_that) {
case _CallRequestModel():
return $default(_that.token,_that.channel,_that.appId,_that.videoCallSessionId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String token,  String channel, @JsonKey(name: 'app_id')  String appId, @JsonKey(name: 'video_call_session_id')  int videoCallSessionId)?  $default,) {final _that = this;
switch (_that) {
case _CallRequestModel() when $default != null:
return $default(_that.token,_that.channel,_that.appId,_that.videoCallSessionId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CallRequestModel implements CallRequestModel {
  const _CallRequestModel({required this.token, required this.channel, @JsonKey(name: 'app_id') required this.appId, @JsonKey(name: 'video_call_session_id') required this.videoCallSessionId});
  factory _CallRequestModel.fromJson(Map<String, dynamic> json) => _$CallRequestModelFromJson(json);

@override final  String token;
@override final  String channel;
@override@JsonKey(name: 'app_id') final  String appId;
@override@JsonKey(name: 'video_call_session_id') final  int videoCallSessionId;

/// Create a copy of CallRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallRequestModelCopyWith<_CallRequestModel> get copyWith => __$CallRequestModelCopyWithImpl<_CallRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallRequestModel&&(identical(other.token, token) || other.token == token)&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.appId, appId) || other.appId == appId)&&(identical(other.videoCallSessionId, videoCallSessionId) || other.videoCallSessionId == videoCallSessionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token,channel,appId,videoCallSessionId);

@override
String toString() {
  return 'CallRequestModel(token: $token, channel: $channel, appId: $appId, videoCallSessionId: $videoCallSessionId)';
}


}

/// @nodoc
abstract mixin class _$CallRequestModelCopyWith<$Res> implements $CallRequestModelCopyWith<$Res> {
  factory _$CallRequestModelCopyWith(_CallRequestModel value, $Res Function(_CallRequestModel) _then) = __$CallRequestModelCopyWithImpl;
@override @useResult
$Res call({
 String token, String channel,@JsonKey(name: 'app_id') String appId,@JsonKey(name: 'video_call_session_id') int videoCallSessionId
});




}
/// @nodoc
class __$CallRequestModelCopyWithImpl<$Res>
    implements _$CallRequestModelCopyWith<$Res> {
  __$CallRequestModelCopyWithImpl(this._self, this._then);

  final _CallRequestModel _self;
  final $Res Function(_CallRequestModel) _then;

/// Create a copy of CallRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? token = null,Object? channel = null,Object? appId = null,Object? videoCallSessionId = null,}) {
  return _then(_CallRequestModel(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,channel: null == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as String,appId: null == appId ? _self.appId : appId // ignore: cast_nullable_to_non_nullable
as String,videoCallSessionId: null == videoCallSessionId ? _self.videoCallSessionId : videoCallSessionId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
