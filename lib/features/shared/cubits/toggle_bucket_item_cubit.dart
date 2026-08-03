import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/errors/app_error.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/features/shared/repository/shared_bucket_list_repository.dart';

@injectable
class ToggleBucketItemCubit extends Cubit<BaseApiState<String>> {
  ToggleBucketItemCubit(this.repository) : super(const BaseApiState.initial());
  final SharedBucketListRepository repository;

  Future<void> toggleBucketItem(int connectionId, int itemId) async {
    if (isClosed) return;
    emit(const BaseApiState.loading());
    final response = await repository.toggleBucketItem(connectionId, itemId);
    if (isClosed) return;
    emit(
      response.fold(
        (l) => l.when(
          serverError: (error) => BaseApiState.error(error),
          validationError: (error) => BaseApiState.validationError(error),
          noInternet: (error) => BaseApiState.noInternet(),
        ),
        (r) => BaseApiState.success(r.data),
      ),
    );
  }
}
