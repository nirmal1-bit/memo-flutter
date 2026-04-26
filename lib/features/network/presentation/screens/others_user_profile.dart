import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/features/network/data/models/response/connection_response.dart';

class OtherUserProfileArguments {
  const OtherUserProfileArguments({
    required this.details,
    this.isFromReceived = false,
    this.isFromSent = false,
  });

  final OtherUserDetails details;
  final bool isFromReceived;
  final bool isFromSent;
}

class OthersUserProfileScreen extends StatelessWidget {
  const OthersUserProfileScreen({
    super.key,
    required this.otherUserProfileArgs,
  });

  final OtherUserProfileArguments otherUserProfileArgs;

  @override
  Widget build(BuildContext context) {
    final user = otherUserProfileArgs.details;

    return Scaffold(
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _HeaderCard(
                user: user,
                isFromReceived: otherUserProfileArgs.isFromReceived,
                isFromSent: otherUserProfileArgs.isFromSent,
              ),
              const SizedBox(height: 16),
              if (otherUserProfileArgs.isFromReceived) ...[
                _RequestActionRow(
                  primaryLabel: 'Accept',
                  primaryIcon: Icons.check_rounded,
                  primaryFilled: true,
                  onPrimaryPressed: () => _showFeedback(
                    context,
                    'Accepted request from ${user.name}',
                  ),
                  secondaryLabel: 'Decline',
                  secondaryIcon: Icons.close_rounded,
                  secondaryFilled: false,
                  onSecondaryPressed: () => _showFeedback(
                    context,
                    'Declined request from ${user.name}',
                  ),
                ),
                const SizedBox(height: 16),
              ] else if (otherUserProfileArgs.isFromSent) ...[
                SizedBox(
                  width: double.infinity,
                  child: _ActionButton(
                    label: 'Cancel',
                    icon: Icons.cancel_outlined,
                    filled: false,
                    onPressed: () => _showFeedback(
                      context,
                      'Cancelled request to ${user.name}',
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
              _DetailCard(
                title: 'About',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _DetailRow(label: 'Email', value: user.email),
                    _DetailRow(
                      label: 'Activated',
                      value: user.activated ? 'Yes' : 'No',
                    ),
                    _DetailRow(
                      label: 'Joined',
                      value: _formatDate(user.createdAt),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _DetailCard(
                title: 'Profile',
                child: user.profile == null
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
                          _DetailRow(
                            label: 'Headline',
                            value: user.profile!.headline,
                          ),
                          _DetailRow(label: 'Bio', value: user.profile!.bio),
                          _DetailRow(
                            label: 'Company',
                            value: user.profile!.companyName,
                          ),
                          _DetailRow(
                            label: 'Location',
                            value: user.profile!.location,
                          ),
                          _DetailRow(
                            label: 'Website',
                            value: user.profile!.website,
                          ),
                          _DetailRow(
                            label: 'Profile Link',
                            value: user.profile!.profileUrl,
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFeedback(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({
    required this.user,
    required this.isFromReceived,
    required this.isFromSent,
  });

  final OtherUserDetails user;
  final bool isFromReceived;
  final bool isFromSent;

  @override
  Widget build(BuildContext context) {
    final profile = user.profile;
    final initials = _buildInitials(user.name);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.dividerColor),
        boxShadow: [
          BoxShadow(
            color: AppColors.softBlack.withValues(alpha: 0.05),
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
                      errorBuilder: (context, error, stackTrace) =>
                          CircleAvatar(
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
                  user.role,
                  style: AppTextStyles.rubik.copyWith(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w500,
                    color: AppColors.softTextGrey,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _InfoChip(text: user.activated ? 'Active' : 'Pending'),
                    _InfoChip(text: user.isPremium ? 'Premium' : 'Standard'),
                    if (isFromReceived)
                      const _InfoChip(text: 'Request received')
                    else if (isFromSent)
                      const _InfoChip(text: 'Request sent'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _buildInitials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) {
      return 'U';
    }

    final first = parts.first[0];
    final second = parts.length > 1 && parts[1].isNotEmpty ? parts[1][0] : '';
    return (first + second).toUpperCase();
  }
}

class _RequestActionRow extends StatelessWidget {
  const _RequestActionRow({
    required this.primaryLabel,
    required this.primaryIcon,
    required this.primaryFilled,
    required this.onPrimaryPressed,
    required this.secondaryLabel,
    required this.secondaryIcon,
    required this.secondaryFilled,
    required this.onSecondaryPressed,
  });

  final String primaryLabel;
  final IconData primaryIcon;
  final bool primaryFilled;
  final VoidCallback onPrimaryPressed;
  final String secondaryLabel;
  final IconData secondaryIcon;
  final bool secondaryFilled;
  final VoidCallback onSecondaryPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ActionButton(
            label: primaryLabel,
            icon: primaryIcon,
            filled: primaryFilled,
            onPressed: onPrimaryPressed,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _ActionButton(
            label: secondaryLabel,
            icon: secondaryIcon,
            filled: secondaryFilled,
            onPressed: onSecondaryPressed,
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.icon,
    required this.filled,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final bool filled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: filled ? AppColors.primary : AppColors.white,
          foregroundColor: filled ? AppColors.white : AppColors.primary,
          side: BorderSide(
            color: filled ? AppColors.primary : AppColors.brandBackgroundLight,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.rubik.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: filled ? AppColors.white : AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
      padding: const EdgeInsets.all(18),
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
              fontWeight: FontWeight.w800,
              color: AppColors.softPrimary,
            ),
          ),
          const SizedBox(height: 14),
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
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 96,
            child: Text(
              label,
              style: AppTextStyles.rubik.copyWith(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: AppColors.softTextGrey,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.rubik.copyWith(
                fontSize: 13.5,
                color: AppColors.softBlack,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: AppTextStyles.rubik.copyWith(
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
          color: AppColors.primary,
        ),
      ),
    );
  }
}

class _MissingUserState extends StatelessWidget {
  const _MissingUserState({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.person_off_rounded, size: 56),
            const SizedBox(height: 12),
            Text(
              'User profile not available.',
              style: AppTextStyles.rubik.copyWith(
                fontSize: 14,
                color: AppColors.softTextGrey,
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton(onPressed: onBack, child: const Text('Go back')),
          ],
        ),
      ),
    );
  }
}

String _formatDate(DateTime dateTime) {
  final month = dateTime.month.toString().padLeft(2, '0');
  final day = dateTime.day.toString().padLeft(2, '0');
  return '${dateTime.year}-$month-$day';
}
