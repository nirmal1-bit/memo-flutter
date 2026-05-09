import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/errors/app_error.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/features/timeline/data/response/memory_response.dart';
import 'package:memo/features/timeline/repository/timeline_repository.dart';

@injectable
class GetMemoriesCubit extends Cubit<BaseApiState<List<MemoryResponse>>> {
  GetMemoriesCubit(this.timelineRepository)
    : super(const BaseApiState.initial());

  final TimelineRepository timelineRepository;

  List<MemoryResponse> get memories => state.maybeWhen(
    success: (data) => data,
    orElse: () => const <MemoryResponse>[],
  );

  List<MemoryResponse> get personalMemories => memoriesByType('personal');

  List<MemoryResponse> get workMemories => memoriesByType('work');

  List<MemoryResponse> get behavioralMemories => memoriesByType('behavioral');

  List<MemoryResponse> get eventMemories => memoriesByType('event');

  List<MemoryResponse> get reminderMemories => memoriesByType('reminder');

  List<MemoryResponse> memoriesByType(String type) => memories
      .where((memory) => _normalizeType(memory.type) == _normalizeType(type))
      .toList();

  void updateMemory(MemoryResponse memory) {
    final hasLoadedMemories = state.maybeWhen(
      success: (_) => true,
      orElse: () => false,
    );

    if (!hasLoadedMemories) {
      return;
    }

    final currentMemories = memories;
    final memoryIndex = currentMemories.indexWhere(
      (item) => item.id == memory.id,
    );
    final updatedMemories = List<MemoryResponse>.from(currentMemories);

    if (memoryIndex == -1) {
      updatedMemories.insert(0, memory);
    } else {
      updatedMemories[memoryIndex] = memory;
    }

    emit(BaseApiState.success(updatedMemories));
  }

  Future<void> getMemories(int connectionId) async {
    if (connectionId <= 0) {
      emit(const BaseApiState.error('Invalid connection id'));
      return;
    }

    emit(const BaseApiState.loading());
    final response = await timelineRepository.getMemories(connectionId);
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

  String _normalizeType(String type) => type.toLowerCase().trim();
}
