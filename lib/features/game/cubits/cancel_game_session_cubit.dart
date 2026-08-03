import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/errors/app_error.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/features/game/repository/think_alike_repository.dart';

@injectable
class CancelGameSessionCubit extends Cubit<BaseApiState<String>> {
  CancelGameSessionCubit(this.repository) : super(const BaseApiState.initial());
  final ThinkAlikeRepository repository;
  Future<void> cancel(int id) async {
    emit(const BaseApiState.loading());
    final r = await repository.cancel(id);
    emit(
      r.fold(
        (e) => e.when(
          serverError: (m) => BaseApiState.error(m),
          validationError: (e) => BaseApiState.validationError(e),
          noInternet: (_) => const BaseApiState.noInternet(),
        ),
        (v) => BaseApiState.success(v.data),
      ),
    );
  }
}
