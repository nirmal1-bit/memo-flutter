import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/errors/app_error.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/features/home/data/models/response/chat_history_response.dart';
import 'package:memo/features/home/domain/repository/connections_repository.dart';

@injectable
class GetChatHistoryCubit
    extends Cubit<BaseApiState<List<ChatHistoryResponse>>> {
  GetChatHistoryCubit(this.repository) : super(const BaseApiState.initial());

  final ConnectionsRepository repository;
  final List<ChatHistoryResponse> _messages = [];
  ChatHistoryPagination? _pagination;
  bool _isLoadingMore = false;

  Future<void> getChatHistory(
    int connectionId, {
    int page = 1,
    int pageSize = 10,
  }) async {
    if (page == 1) {
      emit(const BaseApiState.loading());
      _messages.clear();
      _pagination = null;
    }

    final response = await repository.getChatHistory(
      connectionId,
      page: page,
      pageSize: pageSize,
    );

    response.fold(
      (error) {
        _isLoadingMore = false;
        emit(BaseApiState.error(error.errorMessage));
      },
      (result) {
        final pageData = result.data;

        // The API returns every page newest-first. ChatPanel also uses a
        // reversed ListView, so index 0 must remain the newest message.
        // Older pages therefore belong after the messages already loaded.
        if (page == 1) {
          _messages.addAll(pageData.items);
        } else {
          _messages.addAll(pageData.items);
        }
        _pagination = pageData.pagination;
        _isLoadingMore = false;
        emit(BaseApiState.success(List.unmodifiable(_messages)));
      },
    );
  }

  Future<void> loadNextPage(int connectionId) async {
    if (_isLoadingMore || !hasNext) return;
    _isLoadingMore = true;
    emit(BaseApiState.success(List.unmodifiable(_messages)));
    await getChatHistory(
      connectionId,
      page: currentPage + 1,
      pageSize: pageSize,
    );
  }

  bool get isLoadingMore => _isLoadingMore;
  int get currentPage => _pagination?.currentPage ?? 1;
  int get pageSize => _pagination?.pageSize ?? 10;
  int get lastPage => _pagination?.lastPage ?? 1;
  bool get hasNext => currentPage < lastPage;
}
