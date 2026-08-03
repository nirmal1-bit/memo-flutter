import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/errors/app_error.dart';
import 'package:memo/core/helpers/location_helper.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/features/home/domain/repository/location_repository.dart';

@injectable
class SendLocationCubit extends Cubit<BaseApiState<String>> {
  SendLocationCubit(this.locationRepository)
    : super(const BaseApiState.initial());

  final LocationRepository locationRepository;

  Future<void> sendLocation() async {
    final location = await LocationHelper.getCurrentLocation();
    final latitude = double.tryParse(location['latitude'] ?? '');
    final longitude = double.tryParse(location['longitude'] ?? '');

    if (latitude == null || longitude == null) return;

    emit(const BaseApiState.loading());
    final response = await locationRepository.sendLocation(
      latitude: latitude,
      longitude: longitude,
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
