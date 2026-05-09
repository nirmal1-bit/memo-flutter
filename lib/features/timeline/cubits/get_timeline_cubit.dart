import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/errors/app_error.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/features/timeline/data/response/time_line_response.dart';
import 'package:memo/features/timeline/repository/timeline_repository.dart';

@injectable
class GetTimelineCubit extends Cubit<BaseApiState<List<TimeLineResponse>>> {
  GetTimelineCubit(this.timelineRepository)
    : super(const BaseApiState.initial());

  final TimelineRepository timelineRepository;

  Future<void> getTimeline(int connectionId) async {
    emit(const BaseApiState.loading());
    final response = await timelineRepository.getTimeLine(connectionId);
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
