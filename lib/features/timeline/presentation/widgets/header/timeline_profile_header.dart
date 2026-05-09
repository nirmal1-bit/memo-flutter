import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/features/network/data/models/response/connection_response.dart';
import 'package:memo/features/network/presentation/screens/other_user_profile.dart';

class TimelineProfileSliverHeader extends StatelessWidget {
  const TimelineProfileSliverHeader({
    super.key,
    required this.tabController,
    required this.innerBoxIsScrolled,
    required this.otherUserProfileArgs,
  });

  final TabController tabController;
  final bool innerBoxIsScrolled;
  final OtherUserProfileArguments otherUserProfileArgs;

  @override
  Widget build(BuildContext context) {
    final user = otherUserProfileArgs.details;

    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: 210,
      pinned: true,
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.softPrimary,
      elevation: innerBoxIsScrolled ? 1 : 0,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: _TimelineProfileHeroCard(user: user),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(
          color: AppColors.white,
          child: TabBar(
            controller: tabController,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textGrey,
            indicatorColor: AppColors.primary,
            indicatorWeight: 2.5,
            labelStyle: const TextStyle(
              fontFamily: 'Rubik',
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
            unselectedLabelStyle: const TextStyle(
              fontFamily: 'Rubik',
              fontSize: 12,
            ),
            tabs: const [
              Tab(text: 'Memories'),
              Tab(text: 'Timeline'),
              Tab(text: 'AI'),
              Tab(text: 'Face Data'),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimelineProfileHeroCard extends StatelessWidget {
  const _TimelineProfileHeroCard({required this.user});

  final OtherUserDetails user;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.fromLTRB(20, 46, 20, 0),
      child: Column(
        children: [
          _TimelineProfileIdentityRow(user: user),
          const SizedBox(height: 16),
          _TimelineProfileInsightStrip(user: user),
        ],
      ),
    );
  }
}

class _TimelineProfileIdentityRow extends StatelessWidget {
  const _TimelineProfileIdentityRow({required this.user});

  final OtherUserDetails user;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TimelineProfileAvatar(user: user),
        const SizedBox(width: 16),
        Expanded(child: _TimelineProfileNameBlock(user: user)),
      ],
    );
  }
}

class _TimelineProfileAvatar extends StatelessWidget {
  const _TimelineProfileAvatar({required this.user});

  final OtherUserDetails user;

  @override
  Widget build(BuildContext context) {
    final profile = user.profile;
    final initials = _buildInitials(user.name);

    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        color: AppColors.brandBackground,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.primary.withOpacity(0.3), width: 2),
      ),
      child: profile?.avatarUrl.isNotEmpty ?? false
          ? ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Image.network(
                profile!.avatarUrl,
                width: 72,
                height: 72,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    _InitialsAvatar(initials: initials),
              ),
            )
          : _InitialsAvatar(initials: initials),
    );
  }
}

class _TimelineProfileNameBlock extends StatelessWidget {
  const _TimelineProfileNameBlock({required this.user});

  final OtherUserDetails user;

  @override
  Widget build(BuildContext context) {
    final profile = user.profile;
    final headline = profile?.headline.isNotEmpty ?? false
        ? profile!.headline
        : user.role;
    final location = profile?.location.isNotEmpty ?? false
        ? profile!.location
        : user.email;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 4),
        Text(
          user.name,
          style: const TextStyle(
            fontFamily: 'Libre',
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: AppColors.softPrimary,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          headline,
          style: const TextStyle(
            fontFamily: 'Rubik',
            fontSize: 13,
            color: AppColors.softTextGrey,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          location,
          style: const TextStyle(
            fontFamily: 'Rubik',
            fontSize: 12,
            color: AppColors.textGrey,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class _InitialsAvatar extends StatelessWidget {
  const _InitialsAvatar({required this.initials});

  final String initials;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        initials,
        style: const TextStyle(
          fontFamily: 'Rubik',
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: AppColors.primary,
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label, required this.bg, required this.fg});

  final String label;
  final Color bg;
  final Color fg;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Rubik',
          fontSize: 10.5,
          fontWeight: FontWeight.w600,
          color: fg,
        ),
      ),
    );
  }
}

class _TimelineProfileInsightStrip extends StatelessWidget {
  const _TimelineProfileInsightStrip({required this.user});

  final OtherUserDetails user;

  @override
  Widget build(BuildContext context) {
    final profile = user.profile;
    final note = profile?.headline.isNotEmpty ?? false
        ? '${user.name} highlighted ${profile!.headline.toLowerCase()}.'
        : '${user.name} is active on the timeline and can be reached through this profile.';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.aiSurfaceBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.aiSurfaceBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.auto_awesome_rounded,
            size: 14,
            color: Color(0xFFFF8C42),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              note,
              style: const TextStyle(
                fontFamily: 'Rubik',
                fontSize: 12,
                height: 1.5,
                color: AppColors.aiSurfaceText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _noop() {}

String _buildInitials(String name) {
  final parts = name
      .trim()
      .split(RegExp(r'\s+'))
      .where((part) => part.isNotEmpty);
  final initials = parts.take(2).map((part) => part[0]).join();
  return initials.isEmpty ? '?' : initials.toUpperCase();
}
