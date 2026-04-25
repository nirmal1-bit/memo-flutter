import 'package:memo/core/api/base_api_response.dart';
import 'package:memo/core/response/base_api_response.dart';
import 'package:memo/core/typedef/typedef.dart';

abstract class NetworkRepository {
  EitherResponse<ApiResponse<String>> listConnections();
}

class NetworkRepositoryImpl extends BaseRemoteSource
    implements NetworkRepository {
  NetworkRepositoryImpl(super._dio, super._networkInfo);

  @override
  Future<EitherResponse<ApiResponse<String>>> listConnections() async {
    try {
      // Simulate a network call with a delay
      await Future.delayed(const Duration(seconds: 2));
      // Return a successful response with dummy data
      return Right(ApiResponse(data: "List of connections"));
    } catch (e) {
      // Return an error response in case of an exception
      return Left(AppError(errorMessage: e.toString()));
    }
  }
}
