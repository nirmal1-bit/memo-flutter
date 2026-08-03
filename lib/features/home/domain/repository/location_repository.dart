import 'package:injectable/injectable.dart';
import 'package:memo/core/api/base_api_response.dart';
import 'package:memo/core/constants/api_endpoints.dart';
import 'package:memo/core/response/base_api_response.dart';
import 'package:memo/core/typedef/typedef.dart';

abstract class LocationRepository {
  EitherResponse<ApiResponse<String>> sendLocation({
    required double latitude,
    required double longitude,
  });
}

@LazySingleton(as: LocationRepository)
class LocationRepositoryImpl extends BaseRemoteSource
    implements LocationRepository {
  LocationRepositoryImpl(super._dio, super._networkInfo);

  @override
  EitherResponse<ApiResponse<String>> sendLocation({
    required double latitude,
    required double longitude,
  }) async {
    return networkRequest(
      request: (dio) async {
        final response = await dio.post(
          ApiEndpoints.location,
          data: {'lat': latitude, 'long': longitude},
        );

        return ApiResponse(
          success: response.data['status'] ?? true,
          data: (response.data['message'] ?? 'success').toString(),
          message: (response.data['message'] ?? 'success').toString(),
        );
      },
    );
  }
}
