import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/errors/app_error.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/features/shared/repository/shared_album_repository.dart';

@injectable
class DeleteSharedImageCubit extends Cubit<BaseApiState<String>> {
  DeleteSharedImageCubit(this.sharedAlbumRepository)
    : super(const BaseApiState.initial());
  final SharedAlbumRepository sharedAlbumRepository;
  Future<void> deleteSharedImage(int connectionId, int imageId) async {
    emit(const BaseApiState.loading());
    final response = await sharedAlbumRepository.deleteSharedImage(
      connectionId,
      imageId,
    );
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
