import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/errors/app_error.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/features/shared/data/request/bucket_item_request.dart';
import 'package:memo/features/shared/data/response/bucket_item_response.dart';
import 'package:memo/features/shared/repository/shared_bucket_list_repository.dart';

@injectable
class CreateBucketItemCubit extends Cubit<BaseApiState<BucketItemResponse>> {
  CreateBucketItemCubit(this.repository) : super(const BaseApiState.initial());
  final SharedBucketListRepository repository;

  Future<void> createBucketItem(
    int connectionId,
    BucketItemRequest request,
  ) async {
    emit(const BaseApiState.loading());
    final response = await repository.createBucketItem(connectionId, request);
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
