import 'package:injectable/injectable.dart';
import 'package:memo/core/api/base_api_response.dart';
import 'package:memo/core/constants/api_endpoints.dart';
import 'package:memo/core/response/base_api_response.dart';
import 'package:memo/core/typedef/typedef.dart';
import 'package:memo/features/timeline/data/request/memory_request.dart';
import 'package:memo/features/timeline/data/response/memory_response.dart';
import 'package:memo/features/timeline/data/response/time_line_response.dart';

abstract class TimelineRepository {
  EitherResponse<ApiResponseWithPagination<MemoryResponse>> getMemories(
    int connectionId,
  );

  EitherResponse<ApiResponse<MemoryResponse>> createMemory(
    MemoryRequest request,
  );

  EitherResponse<ApiResponseWithPagination<TimeLineResponse>> getTimeLine(
    int connectionId,
  );
}

@LazySingleton(as: TimelineRepository)
class TimelineRepositoryImpl extends BaseRemoteSource
    implements TimelineRepository {
  TimelineRepositoryImpl(super.dio, super.networkInfo);

  @override
  EitherResponse<ApiResponseWithPagination<MemoryResponse>> getMemories(
    int connectionId,
  ) async {
    final response = await networkRequest(
      request: (dio) async {
        final response = await dio.get(ApiEndpoints.memories(connectionId));
        final list = response.data["memories"] as List<dynamic>;
        return ApiResponseWithPagination(
          success: response.data["status"] ?? true,
          data: list.map((e) => MemoryResponse.fromJson(e)).toList(),
          message: (response.data["message"] ?? "success").toString(),
        );
      },
    );

    return response;
  }

  @override
  EitherResponse<ApiResponse<MemoryResponse>> createMemory(
    MemoryRequest request,
  ) async {
    final response = await networkRequest(
      request: (dio) async {
        final response = await dio.post(
          ApiEndpoints.createMemory,
          data: request.toJson(),
        );
        return ApiResponse(
          success: true,
          data: MemoryResponse.fromJson(response.data['memory']),
          message: "success",
        );
      },
    );

    return response;
  }

  @override
  EitherResponse<ApiResponseWithPagination<TimeLineResponse>> getTimeLine(
    int connectionId,
  ) async {
    final response = await networkRequest(
      request: (dio) async {
        final response = await dio.get(ApiEndpoints.timeline(connectionId));
        final list = response.data["timeline"] as List<dynamic>;
        return ApiResponseWithPagination(
          success: response.data["status"] ?? true,
          data: list.map((e) => TimeLineResponse.fromJson(e)).toList(),
          message: (response.data["message"] ?? "success").toString(),
        );
      },
    );

    return response;
  }
}
