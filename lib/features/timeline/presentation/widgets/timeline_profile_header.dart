import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/features/timeline/presentation/widgets/timeline_shared_widgets.dart';

class TimelineProfileSliverHeader extends StatelessWidget {
  const TimelineProfileSliverHeader({
    super.key,
    required this.tabController,
    required this.innerBoxIsScrolled,
  });

  final TabController tabController;
  final bool innerBoxIsScrolled;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 280,
      automaticallyImplyLeading: false,
      pinned: true,
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.softPrimary,
      elevation: innerBoxIsScrolled ? 1 : 0,
      flexibleSpace: const FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: _TimelineProfileHeroCard(),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(48),
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
  const _TimelineProfileHeroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.fromLTRB(20, 56, 20, 0),
      child: const Column(
        children: [
          _TimelineProfileIdentityRow(),
          SizedBox(height: 16),
          _TimelineProfileInsightStrip(),
          SizedBox(height: 14),
          _TimelineProfileActionRow(),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _TimelineProfileIdentityRow extends StatelessWidget {
  const _TimelineProfileIdentityRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _TimelineProfileAvatar(),
        SizedBox(width: 16),
        Expanded(child: _TimelineProfileNameBlock()),
      ],
    );
  }
}

class _TimelineProfileAvatar extends StatelessWidget {
  const _TimelineProfileAvatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        color: AppColors.brandBackground,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.primary.withOpacity(0.3), width: 2),
      ),
      child: const Center(
        child: Text(
          'PM',
          style: TextStyle(
            fontFamily: 'Rubik',
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}

class _TimelineProfileNameBlock extends StatelessWidget {
  const _TimelineProfileNameBlock();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 4),
        const Text(
          'Priya Menon',
          style: TextStyle(
            fontFamily: 'Libre',
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: AppColors.softPrimary,
          ),
        ),
        const SizedBox(height: 3),
        const Text(
          'Product Lead · Series B startup',
          style: TextStyle(
            fontFamily: 'Rubik',
            fontSize: 13,
            color: AppColors.softTextGrey,
          ),
        ),
        const SizedBox(height: 3),
        const Text(
          'Mumbai, India',
          style: TextStyle(
            fontFamily: 'Rubik',
            fontSize: 12,
            color: AppColors.textGrey,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: const [
            _InfoChip(
              label: 'Connected',
              bg: Color(0xFFE8F8F0),
              fg: Color(0xFF1A7A4A),
            ),
            _InfoChip(
              label: '2 yrs known',
              bg: Color(0xFFEFF7F8),
              fg: Color(0xFF055F6B),
            ),
            _InfoChip(
              label: '18 memories',
              bg: Color(0xFFFFF0E5),
              fg: Color(0xFFB85C00),
            ),
          ],
        ),
      ],
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
  const _TimelineProfileInsightStrip();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.aiSurfaceBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.aiSurfaceBorder),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.auto_awesome_rounded, size: 14, color: Color(0xFFFF8C42)),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Priya is more responsive on Thursdays. She mentioned hiring pressure — asking about the team\'s morale could be a good icebreaker.',
              style: TextStyle(
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

class _TimelineProfileActionRow extends StatelessWidget {
  const _TimelineProfileActionRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: TimelineActionButton(
            label: 'Message',
            icon: Icons.chat_bubble_outline_rounded,
            filled: false,
            onTap: _noop,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TimelineActionButton(
            label: 'Video',
            icon: Icons.videocam_outlined,
            filled: false,
            onTap: _noop,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TimelineActionButton(
            label: 'Brief me',
            icon: Icons.flash_on_rounded,
            filled: true,
            onTap: _noop,
          ),
        ),
      ],
    );
  }
}

void _noop() {}
