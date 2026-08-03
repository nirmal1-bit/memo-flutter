import 'package:injectable/injectable.dart';
import 'package:memo/core/api/base_api_response.dart';
import 'package:memo/core/constants/api_endpoints.dart';
import 'package:memo/core/response/base_api_response.dart';
import 'package:memo/core/typedef/typedef.dart';
import 'package:memo/features/shared/data/request/shared_image_request.dart';
import 'package:memo/features/shared/data/response/shared_image_response.dart';

abstract class SharedAlbumRepository {
  EitherResponse<ApiResponse<List<SharedImageResponse>>> getSharedImages(
    int id,
  );
  EitherResponse<ApiResponse<SharedImageResponse>> createSharedImage(
    int id,
    SharedImageRequest request,
  );
  EitherResponse<ApiResponse<String>> favoriteSharedImage(int id, int imageId);
  EitherResponse<ApiResponse<String>> deleteSharedImage(int id, int imageId);
}

@LazySingleton(as: SharedAlbumRepository)
class SharedAlbumRepositoryImpl extends BaseRemoteSource
    implements SharedAlbumRepository {
  SharedAlbumRepositoryImpl(super.dio, super.networkInfo);

  @override
  EitherResponse<ApiResponse<List<SharedImageResponse>>> getSharedImages(
    int id,
  ) async {
    final response = await networkRequest(
      request: (dio) async {
        final result = await dio.get(ApiEndpoints.sharedAlbum(id));
        final list = result.data['shared_images'] as List<dynamic>;
        return ApiResponse(
          success: result.data['status'] ?? true,
          data: list.map((e) => SharedImageResponse.fromJson(e)).toList(),
          message: (result.data['message'] ?? 'success').toString(),
        );
      },
    );
    return response;
  }

  @override
  EitherResponse<ApiResponse<SharedImageResponse>> createSharedImage(
    int id,
    SharedImageRequest request,
  ) async {
    final response = await networkRequest(
      request: (dio) async {
        final result = await dio.post(
          ApiEndpoints.sharedAlbum(id),
          data: request.toJson(),
        );
        return ApiResponse(
          success: result.data['status'] ?? true,
          data: SharedImageResponse.fromJson(result.data['shared_image']),
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
  EitherResponse<ApiResponse<String>> favoriteSharedImage(
    int id,
    int imageId,
  ) => _action(
    (dio) => dio.patch(ApiEndpoints.sharedAlbumFavoriteImage(id, imageId)),
  );

  @override
  EitherResponse<ApiResponse<String>> deleteSharedImage(int id, int imageId) =>
      _action(
        (dio) => dio.delete(ApiEndpoints.deleteSharedAlbumImage(id, imageId)),
      );
}
