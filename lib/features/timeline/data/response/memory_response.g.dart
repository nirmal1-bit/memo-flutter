// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memory_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MemoryResponse _$MemoryResponseFromJson(Map<String, dynamic> json) =>
    _MemoryResponse(
      id: (json['id'] as num).toInt(),
      connectionId: (json['connection_id'] as num).toInt(),
      personId: (json['person_id'] as num).toInt(),
      content: json['content'] as String,
      type: json['type'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$MemoryResponseToJson(_MemoryResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'connection_id': instance.connectionId,
      'person_id': instance.personId,
      'content': instance.content,
      'type': instance.type,
      'created_at': instance.createdAt.toIso8601String(),
    };
