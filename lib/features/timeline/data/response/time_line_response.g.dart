// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_line_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TimeLineResponse _$TimeLineResponseFromJson(Map<String, dynamic> json) =>
    _TimeLineResponse(
      id: (json['id'] as num).toInt(),
      connectionId: (json['connection_id'] as num).toInt(),
      initiatedByUserId: (json['initiated_by_user_id'] as num).toInt(),
      agoraChannelName: json['agora_channel_name'] as String,
      status: json['status'] as String,
      summary: json['summary'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$TimeLineResponseToJson(_TimeLineResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'connection_id': instance.connectionId,
      'initiated_by_user_id': instance.initiatedByUserId,
      'agora_channel_name': instance.agoraChannelName,
      'status': instance.status,
      'summary': instance.summary,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
