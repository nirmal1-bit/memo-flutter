import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/errors/app_error.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/features/network/data/models/response/recent_image_response.dart';
import 'package:memo/features/network/domian/repository/recent_images_repository.dart';

@injectable
class GetRecentImagesCubit
    extends Cubit<BaseApiState<List<RecentImageResponse>>> {
  GetRecentImagesCubit(this.repository) : super(const BaseApiState.initial());

  final RecentImagesRepository repository;

  Future<void> getRecentImages(int userId) async {
    emit(const BaseApiState.loading());
    final response = await repository.getRecentImages(userId);
    emit(
      response.fold(
        (error) => error.validationErrorOrNull != null
            ? BaseApiState.validationError(error.validationErrorOrNull!)
            : BaseApiState.error(error.errorMessage),
        (result) => BaseApiState.success(result.data),
      ),
    );
  }
}
