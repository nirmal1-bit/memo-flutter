import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/errors/app_error.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/features/home/data/models/response/connection_response.dart';
import 'package:memo/features/home/domain/repository/connections_repository.dart';

@injectable
class ConnectionsCubit extends Cubit<BaseApiState<List<ConnectionResponse>>> {
  ConnectionsCubit(this.networkRepository)
    : super(const BaseApiState.initial());

  final ConnectionsRepository networkRepository;

  Future<void> listConnections() async {
    emit(const BaseApiState.loading());
    final response = await networkRepository.listConnections();

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
