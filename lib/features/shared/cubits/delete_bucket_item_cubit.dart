import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/errors/app_error.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/features/shared/repository/shared_bucket_list_repository.dart';

@injectable
class DeleteBucketItemCubit extends Cubit<BaseApiState<String>> {
  DeleteBucketItemCubit(this.repository) : super(const BaseApiState.initial());
  final SharedBucketListRepository repository;

  Future<void> deleteBucketItem(int connectionId, int itemId) async {
    emit(const BaseApiState.loading());
    final response = await repository.deleteBucketItem(connectionId, itemId);
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
