import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/errors/app_error.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/features/timeline/data/request/memory_request.dart';
import 'package:memo/features/timeline/data/response/memory_response.dart';
import 'package:memo/features/timeline/repository/timeline_repository.dart';

@injectable
class CreateMemoriesCubit extends Cubit<BaseApiState<MemoryResponse>> {
  CreateMemoriesCubit(this.timelineRepository)
    : super(const BaseApiState.initial());

  final TimelineRepository timelineRepository;

  Future<void> createMemory(MemoryRequest request) async {
    emit(const BaseApiState.loading());
    final response = await timelineRepository.createMemory(request);
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
