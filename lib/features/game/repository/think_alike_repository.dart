import 'package:injectable/injectable.dart';
import 'package:memo/core/api/base_api_response.dart';
import 'package:memo/core/constants/api_endpoints.dart';
import 'package:memo/core/response/base_api_response.dart';
import 'package:memo/core/typedef/typedef.dart';
import 'package:memo/features/game/data/think_alike_models.dart';

abstract class ThinkAlikeRepository {
  EitherResponse<ApiResponse<ThinkAlikeQuestion>> questions();
  EitherResponse<ApiResponse<ThinkAlikeSession>> createSession(
    int questionId,
    int partnerId,
  );
  EitherResponse<ApiResponse<ThinkAlikeSession>> getSession(int id);
  EitherResponse<ApiResponse<ThinkAlikeSession>> accept(int id);
  EitherResponse<ApiResponse<ThinkAlikeSession>> answer(int id, String answer);
  EitherResponse<ApiResponse<ThinkAlikeSession>> reveal(int id);
  EitherResponse<ApiResponse<String>> cancel(int id);
}

@LazySingleton(as: ThinkAlikeRepository)
class ThinkAlikeRepositoryImpl extends BaseRemoteSource
    implements ThinkAlikeRepository {
  ThinkAlikeRepositoryImpl(super.dio, super.networkInfo);
  @override
  EitherResponse<ApiResponse<ThinkAlikeQuestion>> questions() => networkRequest(
    request: (d) async {
      final r = await d.get(ApiEndpoints.randomQuestion);
      return ApiResponse(
        success: r.data['status'] ?? true,
        data: ThinkAlikeQuestion.fromJson(r.data['think_alike_question']),
        message: 'success',
      );
    },
  );
  Future<ApiResponse<ThinkAlikeSession>> _s(dynamic r) async => ApiResponse(
    success: r.data['status'] ?? true,
    data: ThinkAlikeSession.fromJson(r.data['think_alike_session']),
    message: 'success',
  );
  @override
  EitherResponse<ApiResponse<ThinkAlikeSession>> createSession(int q, int p) =>
      networkRequest(
        request: (d) async => _s(
          await d.post(
            ApiEndpoints.thinkAlikeSessions,
            data: {'question_id': q, 'partner_id': p},
          ),
        ),
      );
  @override
  EitherResponse<ApiResponse<ThinkAlikeSession>> getSession(int id) =>
      networkRequest(
        request: (d) async =>
            _s(await d.get(ApiEndpoints.thinkAlikeSession(id))),
      );
  @override
  EitherResponse<ApiResponse<ThinkAlikeSession>> accept(int id) =>
      networkRequest(
        request: (d) async =>
            _s(await d.patch(ApiEndpoints.acceptThinkAlikeSession(id))),
      );
  @override
  EitherResponse<ApiResponse<ThinkAlikeSession>> answer(int id, String a) =>
      networkRequest(
        request: (d) async => _s(
          await d.post(
            ApiEndpoints.answerThinkAlikeSession(id),
            data: {'answer': a},
          ),
        ),
      );
  @override
  EitherResponse<ApiResponse<ThinkAlikeSession>> reveal(int id) =>
      networkRequest(
        request: (d) async =>
            _s(await d.post(ApiEndpoints.revealThinkAlikeSession(id))),
      );
  @override
  EitherResponse<ApiResponse<String>> cancel(int id) => networkRequest(
    request: (d) async {
      final r = await d.post(ApiEndpoints.cancelThinkAlikeSession(id));
      return ApiResponse(
        success: r.data['status'] ?? true,
        data: '${r.data['message'] ?? 'success'}',
        message: 'success',
      );
    },
  );
}
