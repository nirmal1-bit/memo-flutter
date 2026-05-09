import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';

class TimelineMemoryCard extends StatelessWidget {
  const TimelineMemoryCard({
    super.key,
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
                  body,
                  style: const TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 15,
                    color: AppColors.softTextGrey,
                    fontWeight: FontWeight.w500,
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
