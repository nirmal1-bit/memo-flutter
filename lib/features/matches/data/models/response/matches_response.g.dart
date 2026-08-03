// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matches_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MatchesResponse _$MatchesResponseFromJson(Map<String, dynamic> json) =>
    _MatchesResponse(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      userId: (json['user_id'] as num).toInt(),
      headline: json['headline'] as String,
      bio: json['bio'] as String,
      profileUrl: json['profile_url'] as String,
      location: json['location'] as String,
      age: (json['age'] as num).toInt(),
      gender: json['gender'] as String,
      interests: (json['interests'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      similarity: (json['similarity'] as num).toDouble(),
      distance: (json['distance'] as num).toDouble(),
    );

Map<String, dynamic> _$MatchesResponseToJson(_MatchesResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'user_id': instance.userId,
      'headline': instance.headline,
      'bio': instance.bio,
      'profile_url': instance.profileUrl,
      'location': instance.location,
      'age': instance.age,
      'gender': instance.gender,
      'interests': instance.interests,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'similarity': instance.similarity,
      'distance': instance.distance,
    };
