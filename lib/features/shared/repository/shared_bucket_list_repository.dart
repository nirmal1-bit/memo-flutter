import 'package:injectable/injectable.dart';
import 'package:memo/core/api/base_api_response.dart';
import 'package:memo/core/constants/api_endpoints.dart';
import 'package:memo/core/response/base_api_response.dart';
import 'package:memo/core/typedef/typedef.dart';
import 'package:memo/features/shared/data/request/bucket_item_request.dart';
import 'package:memo/features/shared/data/response/bucket_item_response.dart';

abstract class SharedBucketListRepository {
  EitherResponse<ApiResponse<List<BucketItemResponse>>> getBucketItems(int id);
  EitherResponse<ApiResponse<BucketItemResponse>> createBucketItem(
    int id,
    BucketItemRequest request,
  );
  EitherResponse<ApiResponse<String>> toggleBucketItem(int id, int itemId);
  EitherResponse<ApiResponse<String>> deleteBucketItem(int id, int itemId);
}

@LazySingleton(as: SharedBucketListRepository)
class SharedBucketListRepositoryImpl extends BaseRemoteSource
    implements SharedBucketListRepository {
  SharedBucketListRepositoryImpl(super.dio, super.networkInfo);

  @override
  EitherResponse<ApiResponse<List<BucketItemResponse>>> getBucketItems(
    int id,
  ) async {
    final response = await networkRequest(
      request: (dio) async {
        final result = await dio.get(ApiEndpoints.sharedBucketList(id));
        final list = result.data['shared_bucket_list'] as List<dynamic>;
        return ApiResponse(
          success: result.data['status'] ?? true,
          data: list.map((e) => BucketItemResponse.fromJson(e)).toList(),
          message: (result.data['message'] ?? 'success').toString(),
        );
      },
    );
    return response;
  }

  @override
  EitherResponse<ApiResponse<BucketItemResponse>> createBucketItem(
    int id,
    BucketItemRequest request,
  ) async {
    final response = await networkRequest(
      request: (dio) async {
        final result = await dio.post(
          ApiEndpoints.sharedBucketList(id),
          data: request.toJson(),
        );
        return ApiResponse(
          success: result.data['status'] ?? true,
          data: BucketItemResponse.fromJson(
            (result.data['shared_bucket_item']),
          ),
          message: 'success',
        );
      },
    );
    return response;
  }

  EitherResponse<ApiResponse<String>> _action(
    Future<dynamic> Function(dynamic dio) call,
  ) => networkRequest(
    request: (dio) async {
      final result = await call(dio);
      final message = (result.data['message'] ?? 'success').toString();
      return ApiResponse(
        success: result.data['status'] ?? true,
        data: message,
        message: message,
      );
    },
  );

  @override
  EitherResponse<ApiResponse<String>> toggleBucketItem(int id, int itemId) =>
      _action((dio) => dio.patch(ApiEndpoints.toggleBucketItem(id, itemId)));

  @override
  EitherResponse<ApiResponse<String>> deleteBucketItem(int id, int itemId) =>
      _action((dio) => dio.delete(ApiEndpoints.deleteBucketItem(id, itemId)));
}
