import 'package:freezed_annotation/freezed_annotation.dart';

part 'notifications_response.freezed.dart';
part 'notifications_response.g.dart';

@freezed
abstract class NotificationsResponse with _$NotificationsResponse {
  const factory NotificationsResponse({
    required int id,

    @JsonKey(name: 'sender_id') required int senderId,

    @JsonKey(name: 'receiver_id') required int receiverId,

    required String type,
    required String title,
    required String body,

    @JsonKey(name: 'is_read') required bool isRead,

    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _NotificationsResponse;

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationsResponseFromJson(json);
}
