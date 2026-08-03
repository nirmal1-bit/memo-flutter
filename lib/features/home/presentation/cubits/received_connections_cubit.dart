import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/errors/app_error.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/features/home/data/models/response/connection_response.dart';
import 'package:memo/features/home/domain/repository/connections_repository.dart';

@injectable
class ReceivedConnectionsCubit
    extends Cubit<BaseApiState<List<ConnectionResponse>>> {
  ReceivedConnectionsCubit(this.networkRepository)
    : super(const BaseApiState.initial());

  final ConnectionsRepository networkRepository;

  List<ConnectionResponse> _allConnections = [];
  String _searchQuery = '';

  Future<void> listReceivedConnections() async {
    emit(const BaseApiState.loading());

    final response = await networkRepository.listReceivedConnections();

    emit(
      response.fold((l) => BaseApiState.error(l.errorMessage), (r) {
        _allConnections = r.data;
        return BaseApiState.success(_applyFilter());
      }),
    );
  }

  void filterReceivedConnectionsByName(String query) {
    _searchQuery = query.trim().toLowerCase();
    emit(BaseApiState.success(_applyFilter()));
  }

  List<ConnectionResponse> _applyFilter() {
    if (_searchQuery.isEmpty) return _allConnections;

    return _allConnections.where((c) {
      return c.userProfile.name.toLowerCase().contains(_searchQuery);
    }).toList();
  }
}
