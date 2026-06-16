import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
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
import 'package:memo/features/network/presentation/widgets/user_profile/section_card.dart';
import 'package:memo/features/profile/data/request/profile_request_model.dart';
import 'package:qr_flutter/qr_flutter.dart';

// ─────────────────────────────────────────────
// SCREEN
// ─────────────────────────────────────────────

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
// PROFILE BODY
// ─────────────────────────────────────────────

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key, required this.user});

  final UserProfileResponse user;

  @override
  Widget build(BuildContext context) {
    final profile = user.profile;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ProfileHeaderCard(user: user),
          const SizedBox(height: 16),
          EditProfileButton(user: user),
          const SizedBox(height: 16),
          AccountInfoSection(user: user),
          if (profile != null) ...[
            const SizedBox(height: 16),
            AboutSection(profile: profile),
          ],
          if (profile != null && profile.interests.isNotEmpty) ...[
            const SizedBox(height: 16),
            InterestsSection(interests: profile.interests),
          ],
          const SizedBox(height: 16),
          QrSection(userId: user.id),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// PROFILE HEADER CARD
// ─────────────────────────────────────────────

class ProfileHeaderCard extends StatelessWidget {
  const ProfileHeaderCard({super.key, required this.user});

  final UserProfileResponse user;

  @override
  Widget build(BuildContext context) {
    final profile = user.profile;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          ProfileAvatar(imageUrl: profile?.profileUrl, size: 84),
          const SizedBox(height: 14),
          Text(
            user.name,
            textAlign: TextAlign.center,
            style: AppTextStyles.libre.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.softPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            textAlign: TextAlign.center,
            style: AppTextStyles.rubik.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.softPrimary.withOpacity(0.6),
            ),
          ),
          if (profile != null && profile.headline.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              profile.headline,
              textAlign: TextAlign.center,
              style: AppTextStyles.rubik.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ],
          const SizedBox(height: 14),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              RoleBadge(
                label: user.isPremium ? 'Premium' : 'Free Plan',
                icon: user.isPremium
                    ? Icons.workspace_premium_rounded
                    : Icons.person_outline_rounded,
                color: user.isPremium
                    ? AppColors.primary
                    : AppColors.softPrimary,
              ),
              if (user.activated)
                const RoleBadge(
                  label: 'Verified',
                  icon: Icons.verified_rounded,
                  color: Colors.green,
                ),
              if (!user.isPremium)
                RoleBadge(
                  label: '${user.trialLeft} trial left',
                  icon: Icons.timer_outlined,
                  color: AppColors.softPrimary,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// PROFILE AVATAR
// ─────────────────────────────────────────────

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key, this.imageUrl, this.size = 84});

  final String? imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    final hasImage = imageUrl != null && imageUrl!.isNotEmpty;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primary.withOpacity(0.10),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.20),
          width: 2,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: hasImage
          ? Image.network(
              imageUrl!,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => _placeholder(),
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return const Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
              },
            )
          : _placeholder(),
    );
  }

  Widget _placeholder() {
    return Icon(
      Icons.person_rounded,
      size: size * 0.5,
      color: AppColors.primary,
    );
  }
}

// ─────────────────────────────────────────────
// ROLE / STATUS BADGE
// ─────────────────────────────────────────────

class RoleBadge extends StatelessWidget {
  const RoleBadge({super.key, required this.label, this.icon, this.color});

  final String label;
  final IconData? icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final badgeColor = color ?? AppColors.primary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.10),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: badgeColor),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: AppTextStyles.rubik.copyWith(
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: badgeColor,
            ),
          ),
        ],
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
            location: profile?.location ?? '',
            gender: profile?.gender ?? '',
            age: profile?.age ?? 0,
            interests: profile?.interests ?? [],
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
// ACCOUNT INFO SECTION
// ─────────────────────────────────────────────

class AccountInfoSection extends StatelessWidget {
  const AccountInfoSection({super.key, required this.user});

  final UserProfileResponse user;

  @override
  Widget build(BuildContext context) {
    final memberSince = DateFormat('MMM d, yyyy').format(user.createdAt);

    final rows = <Widget>[
      IconRow(
        icon: Icons.calendar_today_outlined,
        label: 'Member since',
        value: memberSince,
      ),
      const Divider(color: AppColors.dividerColor, height: 20),
      IconRow(
        icon: user.isPremium
            ? Icons.workspace_premium_rounded
            : Icons.star_border_rounded,
        label: 'Plan',
        value: user.isPremium ? 'Premium' : 'Free',
      ),
    ];

    if (!user.isPremium) {
      rows.addAll([
        const Divider(color: AppColors.dividerColor, height: 20),
        IconRow(
          icon: Icons.timer_outlined,
          label: 'Trial remaining',
          value: '${user.trialLeft}',
        ),
      ]);
    }

    rows.addAll([
      const Divider(color: AppColors.dividerColor, height: 20),
      IconRow(
        icon: user.activated
            ? Icons.verified_outlined
            : Icons.error_outline_rounded,
        label: 'Account status',
        value: user.activated ? 'Activated' : 'Not activated',
      ),
    ]);

    return SectionCard(
      title: 'Account',
      child: Column(children: rows),
    );
  }
}

// ─────────────────────────────────────────────
// ABOUT SECTION
// ─────────────────────────────────────────────

class AboutSection extends StatelessWidget {
  const AboutSection({super.key, required this.profile});

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    final fields = <({String label, String value, IconData icon})>[
      if (profile.bio.isNotEmpty)
        (label: 'Bio', value: profile.bio, icon: Icons.person_outline_rounded),
      if (profile.location.isNotEmpty)
        (
          label: 'Location',
          value: profile.location,
          icon: Icons.location_on_outlined,
        ),
      if (profile.gender.isNotEmpty)
        (label: 'Gender', value: profile.gender, icon: Icons.wc_rounded),
      if (profile.age > 0)
        (
          label: 'Age',
          value: profile.age.toString(),
          icon: Icons.cake_outlined,
        ),
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

// ─────────────────────────────────────────────
// INTERESTS SECTION
// ─────────────────────────────────────────────

class InterestsSection extends StatelessWidget {
  const InterestsSection({super.key, required this.interests});

  final List<String> interests;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Interests',
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: interests
            .map(
              (interest) => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.brandBackground,
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: AppColors.dividerColor),
                ),
                child: Text(
                  _capitalize(interest),
                  style: AppTextStyles.rubik.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.softPrimary,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  String _capitalize(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1);
  }
}

// ─────────────────────────────────────────────
// QR SECTION
// ─────────────────────────────────────────────

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
