import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/errors/app_error.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/features/shared/data/request/shared_image_request.dart';
import 'package:memo/features/shared/data/response/shared_image_response.dart';
import 'package:memo/features/shared/repository/shared_album_repository.dart';

@injectable
class CreateSharedImageCubit extends Cubit<BaseApiState<SharedImageResponse>> {
  CreateSharedImageCubit(this.sharedAlbumRepository)
    : super(const BaseApiState.initial());
  final SharedAlbumRepository sharedAlbumRepository;
  Future<void> createSharedImage(
    int connectionId,
    SharedImageRequest request,
  ) async {
    if (isClosed) return;
    emit(const BaseApiState.loading());
    final response = await sharedAlbumRepository.createSharedImage(
      connectionId,
      request,
    );
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
