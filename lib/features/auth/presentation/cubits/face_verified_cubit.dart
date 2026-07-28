import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/errors/app_error.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/features/auth/data/models/request/login_request_model.dart';
import 'package:memo/features/auth/domain/repository/auth_repository.dart';

@injectable
class FaceVerifiedCubit extends Cubit<BaseApiState<bool>> {
  FaceVerifiedCubit(this.authRepository) : super(const BaseApiState.initial());
  final AuthRepository authRepository;

  Future<void> check(LoginRequestModel request) async {
    emit(const BaseApiState.loading());
    final response = await authRepository.getFaceVerificationStatus(request);

    emit(
      response.fold(
        (l) => l.when(
          serverError: (error) => BaseApiState.error(error),
          validationError: (validationError) =>
              BaseApiState.validationError(validationError),
          noInternet: (error) => BaseApiState.noInternet(),
        ),
        (r) {
          return BaseApiState.success(r.data);
        },
      ),
    );
  }
}
