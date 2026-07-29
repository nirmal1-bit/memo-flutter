import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/errors/app_error.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/features/network/data/models/response/user_profile_response.dart';
import 'package:memo/features/network/domian/repository/network_respotory.dart';

@injectable
class GetUserProfileCubit extends Cubit<BaseApiState<UserProfileResponse>> {
  GetUserProfileCubit(this.networkRepository)
    : super(const BaseApiState.initial());

  final NetworkRepository networkRepository;

  Future<void> getUserProfile() async {
    emit(const BaseApiState.loading());
    final response = await networkRepository.getUserProfile();

    emit(
      response.fold(
        (l) => l.validationErrorOrNull != null
            ? BaseApiState.validationError(l.validationErrorOrNull!)
            : BaseApiState.error(l.errorMessage),
        (r) => BaseApiState.success(r.data),
      ),
    );
  }
}
