import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/errors/app_error.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/features/shared_album/repository/shared_album_repository.dart';

@injectable
class FavoriteSharedImageCubit extends Cubit<BaseApiState<String>> {
  FavoriteSharedImageCubit(this.sharedAlbumRepository) : super(const BaseApiState.initial());
  final SharedAlbumRepository sharedAlbumRepository;
  Future<void> favoriteSharedImage(int connectionId, int imageId) async {
    emit(const BaseApiState.loading());
    final response = await sharedAlbumRepository.favoriteSharedImage(connectionId, imageId);
    emit(response.fold((l) => l.when(serverError: (error) => BaseApiState.error(error), validationError: (error) => BaseApiState.validationError(error), noInternet: (error) => BaseApiState.noInternet()), (r) => BaseApiState.success(r.data)));
  }
}
