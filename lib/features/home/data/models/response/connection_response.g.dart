// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ConnectionResponse _$ConnectionResponseFromJson(Map<String, dynamic> json) =>
    _ConnectionResponse(
      id: (json['id'] as num).toInt(),
      userProfile: UserProfile.fromJson(
        json['user_profile'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ConnectionResponseToJson(_ConnectionResponse instance) =>
    <String, dynamic>{'id': instance.id, 'user_profile': instance.userProfile};

_UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => _UserProfile(
  id: (json['id'] as num).toInt(),
  userId: (json['user_id'] as num).toInt(),
  name: json['name'] as String,
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
);

Map<String, dynamic> _$UserProfileToJson(_UserProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'name': instance.name,
      'headline': instance.headline,
      'bio': instance.bio,
      'profile_url': instance.profileUrl,
      'location': instance.location,
      'age': instance.age,
      'gender': instance.gender,
      'interests': instance.interests,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
