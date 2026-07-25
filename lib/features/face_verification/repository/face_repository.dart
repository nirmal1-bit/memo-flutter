import 'package:injectable/injectable.dart';
import 'package:memo/core/api/base_api_response.dart';

abstract class FaceRepository {}

@LazySingleton(as: FaceRepository)
class FaceRepositoryImpl extends BaseRemoteSource implements FaceRepository {
  FaceRepositoryImpl(super._dio, super._networkInfo);
}
