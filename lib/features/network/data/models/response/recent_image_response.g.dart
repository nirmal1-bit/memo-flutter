// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_image_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RecentImageResponse _$RecentImageResponseFromJson(Map<String, dynamic> json) =>
    _RecentImageResponse(
      id: (json['id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      url: json['url'] as String,
      description: json['description'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$RecentImageResponseToJson(
  _RecentImageResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'url': instance.url,
  'description': instance.description,
  'created_at': instance.createdAt.toIso8601String(),
};
