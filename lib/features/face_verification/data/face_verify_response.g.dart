// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'face_verify_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FaceVerifyResponse _$FaceVerifyResponseFromJson(Map<String, dynamic> json) =>
    _FaceVerifyResponse(
      similarity: (json['similarity'] as num).toDouble(),
      verified: json['verified'] as bool,
    );

Map<String, dynamic> _$FaceVerifyResponseToJson(_FaceVerifyResponse instance) =>
    <String, dynamic>{
      'similarity': instance.similarity,
      'verified': instance.verified,
    };
