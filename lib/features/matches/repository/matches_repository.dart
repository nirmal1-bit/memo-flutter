import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/api/base_api_response.dart';
import 'package:memo/core/constants/api_endpoints.dart';
import 'package:memo/core/response/base_api_response.dart';
import 'package:memo/core/typedef/typedef.dart';
import 'package:memo/features/matches/data/models/response/matches_response.dart';

abstract class MatchesRepository {
  EitherResponse<ApiResponseWithPagination<MatchesResponse>> getMatches();
}

@LazySingleton(as: MatchesRepository)
class MatchesRepositoryImpl extends BaseRemoteSource
    implements MatchesRepository {
  MatchesRepositoryImpl(super._dio, super._networkInfo);

  @override
  EitherResponse<ApiResponseWithPagination<MatchesResponse>> getMatches() {
    final response = networkRequest(
      request: (Dio dio) async {
        final response = await dio.get(ApiEndpoints.matches);
        final list = response.data["matches"] as List<dynamic>;
        return ApiResponseWithPagination(
          success: true,
          data: list.map((e) => MatchesResponse.fromJson(e)).toList(),
          message: "Success",
        );
      },
    );
    return response;
  }
}
