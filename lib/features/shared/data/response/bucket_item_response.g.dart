// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bucket_item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BucketItemResponse _$BucketItemResponseFromJson(Map<String, dynamic> json) =>
    _BucketItemResponse(
      id: (json['id'] as num).toInt(),
      connectionId: (json['connection_id'] as num).toInt(),
      createdBy: (json['created_by'] as num).toInt(),
      title: json['title'] as String,
      category: json['category'] as String? ?? 'other',
      completed: json['completed'] as bool? ?? false,
      completedAt: json['completed_at'] == null
          ? null
          : DateTime.parse(json['completed_at'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$BucketItemResponseToJson(_BucketItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'connection_id': instance.connectionId,
      'created_by': instance.createdBy,
      'title': instance.title,
      'category': instance.category,
      'completed': instance.completed,
      'completed_at': instance.completedAt?.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
    };
