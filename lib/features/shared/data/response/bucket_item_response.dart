import 'package:freezed_annotation/freezed_annotation.dart';

part 'bucket_item_response.freezed.dart';
part 'bucket_item_response.g.dart';

@freezed
abstract class BucketItemResponse with _$BucketItemResponse {
  const factory BucketItemResponse({
    required int id,
    @JsonKey(name: 'connection_id') required int connectionId,
    @JsonKey(name: 'created_by') required int createdBy,
    required String title,
    @Default('other') String category,
    @Default(false) bool completed,
    @JsonKey(name: 'completed_at') DateTime? completedAt,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _BucketItemResponse;

  factory BucketItemResponse.fromJson(Map<String, dynamic> json) =>
      _$BucketItemResponseFromJson(json);
}
