import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/errors/app_error.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/features/game/data/think_alike_models.dart';
import 'package:memo/features/game/repository/think_alike_repository.dart';

@injectable
class CreateGameSessionCubit extends Cubit<BaseApiState<ThinkAlikeSession>> {
  CreateGameSessionCubit(this.repository) : super(const BaseApiState.initial());
  final ThinkAlikeRepository repository;
  Future<void> createSession({
    required int questionId,
    required int partnerId,
  }) async {
    emit(const BaseApiState.loading());
    final response = await repository.createSession(questionId, partnerId);
    emit(response.fold(_error, (result) => BaseApiState.success(result.data)));
  }

  BaseApiState<ThinkAlikeSession> _error(AppError error) => error.when(
    serverError: (message) => BaseApiState.error(message),
    validationError: (error) => BaseApiState.validationError(error),
    noInternet: (_) => const BaseApiState.noInternet(),
  );
}
