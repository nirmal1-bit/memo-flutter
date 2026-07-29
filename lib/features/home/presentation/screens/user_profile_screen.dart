import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/di/injector.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/features/common/custom_app_bar.dart';
import 'package:memo/features/common/feed_back_state_widget.dart';
import 'package:memo/features/common/loading_animation.dart';
import 'package:memo/features/common/shimmer.dart';
import 'package:memo/features/home/data/models/response/user_profile_response.dart';
import 'package:memo/features/home/presentation/cubits/get_user_profile_cubit.dart';
import 'package:memo/features/home/presentation/widgets/profile/profile_body.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<GetUserProfileCubit>()..getUserProfile(),
      child: const _ProfileScaffold(),
    );
  }
}

class _ProfileScaffold extends StatelessWidget {
  const _ProfileScaffold();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: CustomAppBar(title: 'Profile'),
      body: BlocBuilder<GetUserProfileCubit, BaseApiState<UserProfileResponse>>(
        builder: (context, state) => state.when(
          initial: () => const AppLoadingWidget.small(),
          loading: () => const ProductDetailShimmer(),
          success: (user) => ProfileBody(user: user),
          error: (message) => FeedbackState(
            icon: Icons.error_outline_rounded,
            title: 'Unable to load profile',
            message: message,
          ),
          noInternet: () => const FeedbackState(
            icon: Icons.wifi_off_rounded,
            title: 'No internet connection',
            message: 'Check your connection and try again.',
          ),
          validationError: (validationError) => FeedbackState(
            icon: Icons.warning_amber_rounded,
            title: validationError.message,
            message: validationError.errors.isNotEmpty
                ? validationError.errors.values.first.toString()
                : '',
          ),
        ),
      ),
    );
  }
}
