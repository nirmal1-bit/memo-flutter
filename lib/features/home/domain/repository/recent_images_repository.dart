import 'package:injectable/injectable.dart';
import 'package:memo/core/api/base_api_response.dart';
import 'package:memo/core/constants/api_endpoints.dart';
import 'package:memo/core/response/base_api_response.dart';
import 'package:memo/core/typedef/typedef.dart';
import 'package:memo/features/home/data/models/response/recent_image_response.dart';

abstract class RecentImagesRepository {
  EitherResponse<ApiResponse<List<RecentImageResponse>>> getRecentImages(
    int userId,
  );

  EitherResponse<ApiResponse<RecentImageResponse>> createRecentImage({
    required String url,
    required String description,
  });

  EitherResponse<ApiResponse<String>> deleteRecentImage(int id);
}

@LazySingleton(as: RecentImagesRepository)
class RecentImagesRepositoryImpl extends BaseRemoteSource
    implements RecentImagesRepository {
  RecentImagesRepositoryImpl(super._dio, super._networkInfo);

  @override
  EitherResponse<ApiResponse<List<RecentImageResponse>>> getRecentImages(
    int userId,
  ) async {
    return networkRequest(
      request: (dio) async {
        final response = await dio.get(
          ApiEndpoints.recentImageByPersonId(userId),
        );

        final list = response.data["recent_images"] as List<dynamic>;

        return ApiResponse(
          success: response.data['status'] ?? true,
          data: list
              .map(
                (item) =>
                    RecentImageResponse.fromJson(item as Map<String, dynamic>),
              )
              .toList(),
          message: "Success",
        );
      },
    );
  }

  @override
  EitherResponse<ApiResponse<RecentImageResponse>> createRecentImage({
    required String url,
    required String description,
  }) async {
    return networkRequest(
      request: (dio) async {
        final response = await dio.post(
          ApiEndpoints.recentImages,
          data: {'url': url, 'description': description},
        );

        return ApiResponse(
          success: response.data['status'] ?? true,
          data: RecentImageResponse.fromJson(response.data['recent_image']),
          message: (response.data['message'] ?? 'success').toString(),
        );
      },
    );
  }

  @override
  EitherResponse<ApiResponse<String>> deleteRecentImage(int id) async {
    return networkRequest(
      request: (dio) async {
        final response = await dio.delete(ApiEndpoints.recentImage(id));

        return ApiResponse(
          success: response.data['status'] ?? true,
          data: (response.data['message'] ?? 'success').toString(),
          message: (response.data['message'] ?? 'success').toString(),
        );
      },
    );
  }
}
