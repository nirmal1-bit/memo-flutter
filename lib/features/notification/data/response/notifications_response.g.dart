// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationsResponse _$NotificationsResponseFromJson(
  Map<String, dynamic> json,
) => _NotificationsResponse(
  id: (json['id'] as num).toInt(),
  senderId: (json['sender_id'] as num).toInt(),
  receiverId: (json['receiver_id'] as num).toInt(),
  type: json['type'] as String,
  title: json['title'] as String,
  body: json['body'] as String,
  isRead: json['is_read'] as bool,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$NotificationsResponseToJson(
  _NotificationsResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'sender_id': instance.senderId,
  'receiver_id': instance.receiverId,
  'type': instance.type,
  'title': instance.title,
  'body': instance.body,
  'is_read': instance.isRead,
  'created_at': instance.createdAt.toIso8601String(),
};
