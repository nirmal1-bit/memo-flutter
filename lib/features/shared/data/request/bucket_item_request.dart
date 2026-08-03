import 'package:freezed_annotation/freezed_annotation.dart';

part 'bucket_item_request.freezed.dart';
part 'bucket_item_request.g.dart';

@freezed
abstract class BucketItemRequest with _$BucketItemRequest {
  const factory BucketItemRequest({
    required String title,
    required String category,
  }) = _BucketItemRequest;

  factory BucketItemRequest.fromJson(Map<String, dynamic> json) =>
      _$BucketItemRequestFromJson(json);
}
