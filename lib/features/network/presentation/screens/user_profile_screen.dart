import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/di/injector.dart';
import 'package:memo/core/routes/app_routes.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/features/common/shimmer.dart';
import 'package:memo/features/network/data/models/response/user_profile_response.dart';
import 'package:memo/features/network/presentation/cubits/get_user_profile_cubit.dart';
import 'package:memo/features/profile/data/request/profile_request_model.dart';
import 'package:qr_flutter/qr_flutter.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<GetUserProfileCubit>()..getUserProfile(),
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        appBar: AppBar(
          backgroundColor: AppColors.scaffoldBackground,
          elevation: 0,
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
        body:
            BlocBuilder<GetUserProfileCubit, BaseApiState<UserProfileResponse>>(
              builder: (context, state) {
                return state.when(
                  initial: () => const _LoadingState(),
                  loading: () => const ProductDetailShimmer(),
                  success: (user) => _ProfileBody(user: user),
                  error: (message) => _StateMessage(
                    icon: Icons.error_outline_rounded,
                    title: 'Unable to load profile',
                    message: message,
                  ),
                  noInternet: () => const _StateMessage(
                    icon: Icons.wifi_off_rounded,
                    title: 'No internet connection',
                    message: 'Check your connection and try again.',
                  ),
                  validationError: (validationError) => _StateMessage(
                    icon: Icons.warning_amber_rounded,
                    title: validationError.message,
                    message: validationError.errors.isNotEmpty
                        ? validationError.errors.values.first.toString()
                        : '',
                  ),
                );
              },
            ),
      ),
    );
  }
}

class _ProfileBody extends StatelessWidget {
  const _ProfileBody({required this.user});

  final UserProfileResponse user;

  @override
  Widget build(BuildContext context) {
    final profile = user.profile;
    final initials = _buildInitials(user.name);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: AppColors.dividerColor),
              boxShadow: [
                BoxShadow(
                  color: AppColors.softBlack.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 68,
                    height: 68,
                    color: AppColors.brandBackground,
                    child: profile?.avatarUrl.isNotEmpty ?? false
                        ? Image.network(
                            profile!.avatarUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) => CircleAvatar(
                              radius: 34,
                              backgroundColor: AppColors.primary,
                              child: Text(
                                initials,
                                style: AppTextStyles.rubik.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          )
                        : CircleAvatar(
                            radius: 34,
                            backgroundColor: AppColors.primary,
                            child: Text(
                              initials,
                              style: AppTextStyles.rubik.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: AppTextStyles.libre.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: AppColors.softPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user.email,
                        style: AppTextStyles.rubik.copyWith(
                          fontSize: 13.5,
                          color: AppColors.softTextGrey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          user.role,
                          style: AppTextStyles.rubik.copyWith(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
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
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  label: 'Trial Left',
                  value: user.trialLeft.toString(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  label: 'Premium',
                  value: user.isPremium ? 'Yes' : 'No',
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const SizedBox(height: 20),
          _DetailCard(
            title: 'About',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _DetailRow(
                  label: 'Activated',
                  value: user.activated ? 'Yes' : 'No',
                ),
                _DetailRow(label: 'Revenue ID', value: user.revenueId),
                _DetailRow(label: 'Joined', value: user.createdAt.toString()),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _DetailCard(
            title: 'Profile',
            child: profile == null
                ? Text(
                    'No profile details available yet.',
                    style: AppTextStyles.rubik.copyWith(
                      fontSize: 13.5,
                      color: AppColors.softTextGrey,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _DetailRow(label: 'Headline', value: profile.headline),
                      _DetailRow(label: 'Bio', value: profile.bio),
                      _DetailRow(label: 'Company', value: profile.companyName),
                      _DetailRow(label: 'Location', value: profile.location),
                      _DetailRow(label: 'Website', value: profile.website),
                    ],
                  ),
          ),
          SizedBox(height: 20),
          _QrCard(userId: user.id),
        ],
      ),
    );
  }

  String _buildInitials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) {
      return 'U';
    }

    final first = parts.first.isNotEmpty ? parts.first[0] : 'U';
    final second = parts.length > 1 && parts[1].isNotEmpty ? parts[1][0] : '';
    return (first + second).toUpperCase();
  }
}

class _DetailCard extends StatelessWidget {
  const _DetailCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.libre.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.softPrimary,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.rubik.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.ironGrey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTextStyles.rubik.copyWith(
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
              color: AppColors.softBlack,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.rubik.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.ironGrey,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: AppTextStyles.libre.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.softPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _QrCard extends StatelessWidget {
  const _QrCard({required this.userId});

  final int userId;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.dividerColor),
        boxShadow: [
          BoxShadow(
            color: AppColors.softBlack.withOpacity(0.04),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.brandBackground,
            borderRadius: BorderRadius.circular(20),
          ),
          child: QrImageView(
            data: userId.toString(),
            version: QrVersions.auto,
            backgroundColor: AppColors.white,
            padding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 40),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}

class _StateMessage extends StatelessWidget {
  const _StateMessage({
    required this.icon,
    required this.title,
    required this.message,
  });

  final IconData icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.dividerColor),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: 40),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.libre.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.softPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.rubik.copyWith(
                fontSize: 13.5,
                color: AppColors.softTextGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
