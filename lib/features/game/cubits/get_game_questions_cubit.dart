import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/errors/app_error.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/features/game/data/think_alike_models.dart';
import 'package:memo/features/game/repository/think_alike_repository.dart';

@injectable
class GetGameQuestionsCubit extends Cubit<BaseApiState<ThinkAlikeQuestion>> {
  GetGameQuestionsCubit(this.repository) : super(const BaseApiState.initial());
  final ThinkAlikeRepository repository;

  Future<void> getQuestion() async {
    if (isClosed) return;
    emit(const BaseApiState.loading());
    final response = await repository.questions();
    if (isClosed) return;
    emit(
      response.fold(
        (error) => error.when(
          serverError: (message) => BaseApiState.error(message),
          validationError: (error) => BaseApiState.validationError(error),
          noInternet: (_) => const BaseApiState.noInternet(),
        ),
        (result) => BaseApiState.success(result.data),
      ),
    );
  }
}
