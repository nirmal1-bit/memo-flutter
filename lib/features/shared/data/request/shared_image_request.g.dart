// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_image_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SharedImageRequest _$SharedImageRequestFromJson(Map<String, dynamic> json) =>
    _SharedImageRequest(
      imageUrl: json['image_url'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
    );

Map<String, dynamic> _$SharedImageRequestToJson(_SharedImageRequest instance) =>
    <String, dynamic>{
      'image_url': instance.imageUrl,
      'description': instance.description,
      'category': instance.category,
    };
