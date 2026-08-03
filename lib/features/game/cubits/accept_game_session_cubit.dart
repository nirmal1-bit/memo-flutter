import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/errors/app_error.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/features/game/data/think_alike_models.dart';
import 'package:memo/features/game/repository/think_alike_repository.dart';

@injectable
class AcceptGameSessionCubit extends Cubit<BaseApiState<ThinkAlikeSession>> {
  AcceptGameSessionCubit(this.repository) : super(const BaseApiState.initial());
  final ThinkAlikeRepository repository;
  Future<void> accept(int id) async {
    emit(const BaseApiState.loading());
    final r = await repository.accept(id);
    emit(r.fold(_error, (v) => BaseApiState.success(v.data)));
  }

  BaseApiState<ThinkAlikeSession> _error(AppError e) => e.when(
    serverError: (m) => BaseApiState.error(m),
    validationError: (e) => BaseApiState.validationError(e),
    noInternet: (_) => const BaseApiState.noInternet(),
  );
}
