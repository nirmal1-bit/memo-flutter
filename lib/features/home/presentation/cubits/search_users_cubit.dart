import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/errors/app_error.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/features/home/data/models/response/user_profile_response.dart';
import 'package:memo/features/home/domain/repository/connections_repository.dart';

@injectable
class SearchUsersCubit extends Cubit<BaseApiState<List<Profile>>> {
  SearchUsersCubit(this.networkRepository)
    : super(const BaseApiState.initial());

  final ConnectionsRepository networkRepository;

  Future<void> searchUsers(String query) async {
    final normalizedQuery = query.trim();
    if (normalizedQuery.isEmpty) {
      emit(const BaseApiState.success(<Profile>[]));
      return;
    }

    emit(const BaseApiState.loading());
    final response = await networkRepository.searchUser(normalizedQuery);

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
