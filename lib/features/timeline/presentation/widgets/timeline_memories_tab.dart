import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/features/timeline/presentation/time_line_data.dart';
import 'package:memo/features/timeline/presentation/widgets/timeline_shared_widgets.dart';

class TimelineMemoriesTab extends StatefulWidget {
  const TimelineMemoriesTab({super.key});

  @override
  State<TimelineMemoriesTab> createState() => _TimelineMemoriesTabState();
}

class _TimelineMemoriesTabState extends State<TimelineMemoriesTab> {
  MemoryType? _filter;

  Color _typeColor(MemoryType type) => switch (type) {
    MemoryType.personal => AppColors.accentRose,
    MemoryType.work => AppColors.primary,
    MemoryType.event => AppColors.secondary,
    MemoryType.behaviour => AppColors.timelineMem,
  };

  Color _typeBg(MemoryType type) => switch (type) {
    MemoryType.personal => const Color(0xFFFBEAF0),
    MemoryType.work => AppColors.brandBackground,
    MemoryType.event => AppColors.chipPurpleBg,
    MemoryType.behaviour => AppColors.chipOrangeBg,
  };

  String _typeLabel(MemoryType type) => switch (type) {
    MemoryType.personal => 'Personal',
    MemoryType.work => 'Work',
    MemoryType.event => 'Event',
    MemoryType.behaviour => 'Behaviour',
  };

  IconData _typeIcon(MemoryType type) => switch (type) {
    MemoryType.personal => Icons.favorite_border_rounded,
    MemoryType.work => Icons.work_outline_rounded,
    MemoryType.event => Icons.event_rounded,
    MemoryType.behaviour => Icons.psychology_outlined,
  };

  @override
  Widget build(BuildContext context) {
    final filtered = _filter == null
        ? dummyMemories
        : dummyMemories.where((memory) => memory.type == _filter).toList();

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Row(
              children: [
                const TimelineStatTile(label: 'Total', value: '5'),
                const SizedBox(width: 10),
                const TimelineStatTile(label: 'This month', value: '3'),
                const SizedBox(width: 10),
                const TimelineStatTile(label: 'Work', value: '1'),
                const SizedBox(width: 10),
                const TimelineStatTile(label: 'Personal', value: '2'),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  TimelineFilterChip(
                    label: 'All',
                    selected: _filter == null,
                    onTap: () => setState(() => _filter = null),
                  ),
                  const SizedBox(width: 8),
                  ...MemoryType.values.map(
                    (type) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: TimelineFilterChip(
                        label: _typeLabel(type),
                        selected: _filter == type,
                        onTap: () => setState(
                          () => _filter = _filter == type ? null : type,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 4),
            child: _AddMemoryButton(onTap: () => _showAddMemorySheet(context)),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final memory = filtered[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _MemoryCard(
                  title: memory.title,
                  body: memory.body,
                  date: memory.date,
                  typeColor: _typeColor(memory.type),
                  typeBg: _typeBg(memory.type),
                  typeLabel: _typeLabel(memory.type),
                  typeIcon: _typeIcon(memory.type),
                  tags: memory.tags,
                ),
              );
            }, childCount: filtered.length),
          ),
        ),
      ],
    );
  }

  void _showAddMemorySheet(BuildContext context) {
    final controller = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.dividerColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Add a memory',
              style: TextStyle(
                fontFamily: 'Libre',
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.softPrimary,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'About Priya Menon',
              style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 13,
                color: AppColors.softTextGrey,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              maxLines: 4,
              style: const TextStyle(fontFamily: 'Rubik', fontSize: 14),
              decoration: InputDecoration(
                hintText: 'What do you want to remember?',
                hintStyle: const TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 14,
                  color: AppColors.textGrey,
                ),
                filled: true,
                fillColor: AppColors.scaffoldBackground,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Save memory',
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddMemoryButton extends StatelessWidget {
  const _AddMemoryButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 13),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primary.withOpacity(0.35)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add_rounded, size: 18, color: AppColors.primary),
            const SizedBox(width: 6),
            const Text(
              'Add memory',
              style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MemoryCard extends StatelessWidget {
  const _MemoryCard({
    required this.title,
    required this.body,
    required this.date,
    required this.typeColor,
    required this.typeBg,
    required this.typeLabel,
    required this.typeIcon,
    required this.tags,
  });

  final String title;
  final String body;
  final DateTime date;
  final Color typeColor;
  final Color typeBg;
  final String typeLabel;
  final IconData typeIcon;
  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: typeBg,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(18),
              ),
            ),
            child: Row(
              children: [
                Icon(typeIcon, size: 14, color: typeColor),
                const SizedBox(width: 6),
                Text(
                  typeLabel,
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: typeColor,
                  ),
                ),
                const Spacer(),
                Text(
                  _fmt(date),
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 11,
                    color: typeColor.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.softBlack,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  body,
                  style: const TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 13,
                    color: AppColors.softTextGrey,
                    height: 1.5,
                  ),
                ),
                if (tags.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: tags
                        .map(
                          (tag) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 9,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: typeBg,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              tag,
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 10.5,
                                fontWeight: FontWeight.w600,
                                color: typeColor,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _fmt(DateTime date) => '${_mon(date.month)} ${date.day}, ${date.year}';

  String _mon(int month) => const [
    '',
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ][month];
}
