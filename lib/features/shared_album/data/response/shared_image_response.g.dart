// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_image_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SharedImageResponse _$SharedImageResponseFromJson(Map<String, dynamic> json) =>
    _SharedImageResponse(
      id: (json['id'] as num).toInt(),
      connectionId: (json['connection_id'] as num).toInt(),
      uploadedBy: (json['uploaded_by'] as num).toInt(),
      imageUrl: json['image_url'] as String,
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? 'other',
      isFavorite: json['is_favorite'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$SharedImageResponseToJson(
  _SharedImageResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'connection_id': instance.connectionId,
  'uploaded_by': instance.uploadedBy,
  'image_url': instance.imageUrl,
  'description': instance.description,
  'category': instance.category,
  'is_favorite': instance.isFavorite,
  'created_at': instance.createdAt.toIso8601String(),
};
