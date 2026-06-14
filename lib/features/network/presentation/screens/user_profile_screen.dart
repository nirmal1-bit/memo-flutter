import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/di/injector.dart';
import 'package:memo/core/routes/app_routes.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/features/common/feed_back_state_widget.dart';
import 'package:memo/features/common/loading_animation.dart';
import 'package:memo/features/common/shimmer.dart';
import 'package:memo/features/network/data/models/response/user_profile_response.dart';
import 'package:memo/features/network/presentation/cubits/get_user_profile_cubit.dart';
import 'package:memo/features/network/presentation/widgets/user_profile/icon_row.dart';
import 'package:memo/features/network/presentation/widgets/user_profile/profile_body.dart';
import 'package:memo/features/network/presentation/widgets/user_profile/section_card.dart';
import 'package:memo/features/profile/data/request/profile_request_model.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        foregroundColor: AppColors.softPrimary,
        title: Text(
          'Profile',
          style: AppTextStyles.libre.copyWith(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: AppColors.softPrimary,
          ),
        ),
      ),
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

// ─────────────────────────────────────────────
// HERO CARD
// ─────────────────────────────────────────────

// ─────────────────────────────────────────────
// ROLE BADGE
// ─────────────────────────────────────────────

class RoleBadge extends StatelessWidget {
  const RoleBadge({super.key, required this.role});

  final String role;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.10),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        role,
        style: AppTextStyles.rubik.copyWith(
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
          color: AppColors.primary,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// EDIT PROFILE BUTTON
// ─────────────────────────────────────────────

class EditProfileButton extends StatelessWidget {
  const EditProfileButton({super.key, required this.user});

  final UserProfileResponse user;

  @override
  Widget build(BuildContext context) {
    final profile = user.profile;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => context.push(
          AppRoutes.setProfile,
          extra: ProfileRequestModel(
            headline: profile?.headline ?? '',
            bio: profile?.bio ?? '',
            profileUrl: profile?.profileUrl ?? '',
            avatarUrl: profile?.avatarUrl ?? '',
            website: profile?.website ?? '',
            location: profile?.location ?? '',
            companyName: profile?.companyName ?? '',
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          elevation: 0,
        ),
        icon: const Icon(Icons.edit_outlined, size: 18),
        label: Text(
          profile == null ? 'Set up profile' : 'Edit profile',
          style: AppTextStyles.rubik.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// ABOUT SECTION
// ─────────────────────────────────────────────

class AboutSection extends StatelessWidget {
  const AboutSection({super.key, required this.profile});

  final dynamic profile; // your profile model type

  @override
  Widget build(BuildContext context) {
    final fields = <({String label, String value, IconData icon})>[
      if (profile.bio.isNotEmpty)
        (label: 'Bio', value: profile.bio, icon: Icons.person_outline_rounded),
      if (profile.companyName.isNotEmpty)
        (
          label: 'Company',
          value: profile.companyName,
          icon: Icons.business_outlined,
        ),
      if (profile.location.isNotEmpty)
        (
          label: 'Location',
          value: profile.location,
          icon: Icons.location_on_outlined,
        ),
      if (profile.website.isNotEmpty)
        (label: 'Website', value: profile.website, icon: Icons.link_rounded),
    ];

    if (fields.isEmpty) return const SizedBox.shrink();

    return SectionCard(
      title: 'About',
      child: Column(
        children: [
          for (int i = 0; i < fields.length; i++) ...[
            IconRow(
              icon: fields[i].icon,
              label: fields[i].label,
              value: fields[i].value,
            ),
            if (i < fields.length - 1)
              const Divider(color: AppColors.dividerColor, height: 20),
          ],
        ],
      ),
    );
  }
}

class QrSection extends StatelessWidget {
  const QrSection({super.key, required this.userId});

  final int userId;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'My QR Code',
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.brandBackground,
            borderRadius: BorderRadius.circular(20),
          ),
          child: QrImageView(
            data: userId.toString(),
            version: QrVersions.auto,
            size: 160,
            backgroundColor: AppColors.white,
            padding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }
}
