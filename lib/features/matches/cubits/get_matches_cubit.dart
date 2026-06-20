import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/errors/app_error.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/features/matches/data/models/response/matches_response.dart';
import 'package:memo/features/matches/repository/matches_repository.dart';

@injectable
class GetMatchesCubit extends Cubit<BaseApiState<List<MatchesResponse>>> {
  // we are initilizing ourself the BaseApiState to
  //initial because we want to emit
  //a loading state before we make the api call,
  //so that listeners always see a state transition
  // positional parameter required by default
  GetMatchesCubit(this.matchRepository) : super(const BaseApiState.initial());
  final MatchesRepository matchRepository;

  void getMatches() async {
    emit(BaseApiState.loading());

    final response = await matchRepository.getMatches();

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
