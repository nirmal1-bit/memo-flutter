import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/errors/app_error.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/features/home/data/models/response/recent_image_response.dart';
import 'package:memo/features/home/domain/repository/recent_images_repository.dart';

@injectable
class CreateRecentImageCubit extends Cubit<BaseApiState<RecentImageResponse>> {
  CreateRecentImageCubit(this.repository) : super(const BaseApiState.initial());

  final RecentImagesRepository repository;

  Future<void> createRecentImage({
    required String url,
    required String description,
  }) async {
    emit(const BaseApiState.loading());
    final response = await repository.createRecentImage(
      url: url,
      description: description,
    );
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
