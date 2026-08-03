import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/errors/app_error.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/features/home/domain/repository/recent_images_repository.dart';

@injectable
class DeleteRecentImageCubit extends Cubit<BaseApiState<String>> {
  DeleteRecentImageCubit(this.repository) : super(const BaseApiState.initial());

  final RecentImagesRepository repository;

  Future<void> deleteRecentImage(int id) async {
    emit(const BaseApiState.loading());
    final response = await repository.deleteRecentImage(id);
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
