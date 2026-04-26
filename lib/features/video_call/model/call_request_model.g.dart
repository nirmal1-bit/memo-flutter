// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CallRequestModel _$CallRequestModelFromJson(Map<String, dynamic> json) =>
    _CallRequestModel(
      token: json['token'] as String,
      channel: json['channel'] as String,
      appId: json['app_id'] as String,
      videoCallSessionId: (json['video_call_session_id'] as num).toInt(),
    );

Map<String, dynamic> _$CallRequestModelToJson(_CallRequestModel instance) =>
    <String, dynamic>{
      'token': instance.token,
      'channel': instance.channel,
      'app_id': instance.appId,
      'video_call_session_id': instance.videoCallSessionId,
    };
