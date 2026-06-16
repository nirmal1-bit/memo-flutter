// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ConnectionResponse _$ConnectionResponseFromJson(Map<String, dynamic> json) =>
    _ConnectionResponse(
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      otherUserDetails: OtherUserDetails.fromJson(
        json['other_user_details'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ConnectionResponseToJson(_ConnectionResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'other_user_details': instance.otherUserDetails,
    };

_OtherUserDetails _$OtherUserDetailsFromJson(Map<String, dynamic> json) =>
    _OtherUserDetails(
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      name: json['name'] as String,
      email: json['email'] as String,
      activated: json['activated'] as bool,
      role: json['role'] as String,
      trialLeft: (json['trial_left'] as num).toInt(),
      isPremium: json['is_premium'] as bool,
      revenueId: json['revenue_id'] as String,
      profile: json['profile'] == null
          ? null
          : Profile.fromJson(json['profile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OtherUserDetailsToJson(_OtherUserDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'name': instance.name,
      'email': instance.email,
      'activated': instance.activated,
      'role': instance.role,
      'trial_left': instance.trialLeft,
      'is_premium': instance.isPremium,
      'revenue_id': instance.revenueId,
      'profile': instance.profile,
    };
