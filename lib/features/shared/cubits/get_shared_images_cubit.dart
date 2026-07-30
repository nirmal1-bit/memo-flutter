import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/errors/app_error.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/features/shared/data/response/shared_image_response.dart';
import 'package:memo/features/shared/repository/shared_album_repository.dart';

@injectable
class GetSharedImagesCubit
    extends Cubit<BaseApiState<List<SharedImageResponse>>> {
  GetSharedImagesCubit(this.sharedAlbumRepository)
    : super(const BaseApiState.initial());
  final SharedAlbumRepository sharedAlbumRepository;
  Future<void> getSharedImages(int connectionId) async {
    emit(const BaseApiState.loading());
    final response = await sharedAlbumRepository.getSharedImages(connectionId);
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
