import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/features/timeline/presentation/widgets/common/timeline_shared_widgets.dart';

class TimelineFaceDataTab extends StatelessWidget {
  const TimelineFaceDataTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.dividerColor),
            ),
            child: Column(
              children: [
                Container(
                  width: 160,
                  height: 190,
                  decoration: BoxDecoration(
                    color: AppColors.brandBackground,
                    borderRadius: BorderRadius.circular(80),
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.4),
                      width: 2,
                    ),
                  ),
                  child: Stack(
                    children: const [
                      _CornerBracket(top: 0, left: 0, rotate: 0),
                      _CornerBracket(top: 0, right: 0, rotate: 90),
                      _CornerBracket(bottom: 0, left: 0, rotate: 270),
                      _CornerBracket(bottom: 0, right: 0, rotate: 180),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _FaceBadge(),
                            SizedBox(height: 10),
                            Text(
                              'Face registered',
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
                            ),
                            Text(
                              '93% confidence',
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 11.5,
                                color: AppColors.softTextGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    const Text(
                      'Match confidence',
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 12.5,
                        color: AppColors.softTextGrey,
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      '93%',
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: const LinearProgressIndicator(
                    value: 0.93,
                    minHeight: 5,
                    backgroundColor: AppColors.brandBackgroundLight,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: const [
                    Expanded(
                      child: TimelineActionButton(
                        label: 'Update face',
                        icon: Icons.camera_alt_outlined,
                        filled: false,
                        onTap: _noop,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TimelineActionButton(
                        label: 'Remove',
                        icon: Icons.delete_outline_rounded,
                        filled: false,
                        onTap: _noop,
                        danger: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const TimelineSectionTitle(title: 'Recognition history'),
          const SizedBox(height: 10),
          const _ScanRecord(
            date: 'Apr 14, 2026 · 9:41 AM',
            note: 'Opened profile from face scan',
            result: 'Matched',
            success: true,
          ),
          const SizedBox(height: 10),
          const _ScanRecord(
            date: 'Mar 22, 2026 · 3:15 PM',
            note: 'Scan at ProductConf afterparty',
            result: 'Matched',
            success: true,
          ),
          const SizedBox(height: 10),
          const _ScanRecord(
            date: 'Feb 10, 2026 · 6:02 PM',
            note: 'Manual scan attempt (low light)',
            result: 'No match',
            success: false,
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.highlightYellow,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.yellow),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.lock_outline_rounded,
                  size: 16,
                  color: AppColors.memoryAmberText,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Face data is stored securely and used only to identify this person in scans. It is never shared with third parties.',
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 12,
                      height: 1.5,
                      color: AppColors.memoryAmberText,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _FaceBadge extends StatelessWidget {
  const _FaceBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.face_retouching_natural_rounded,
        size: 28,
        color: AppColors.white,
      ),
    );
  }
}

class _ScanRecord extends StatelessWidget {
  const _ScanRecord({
    required this.date,
    required this.note,
    required this.result,
    required this.success,
  });

  final String date;
  final String note;
  final String result;
  final bool success;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.dividerColor),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: success ? AppColors.statusGreen : AppColors.statusOrange,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note,
                  style: const TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.softBlack,
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 11.5,
                    color: AppColors.textGrey,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
            decoration: BoxDecoration(
              color: success ? AppColors.chipGreenBg : AppColors.chipOrangeBg,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              result,
              style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: success
                    ? AppColors.chipGreenText
                    : AppColors.chipOrangeText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CornerBracket extends StatelessWidget {
  const _CornerBracket({
    this.top,
    this.left,
    this.right,
    this.bottom,
    required this.rotate,
  });

  final double? top;
  final double? left;
  final double? right;
  final double? bottom;
  final double rotate;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Transform.rotate(
        angle: rotate * 3.14159 / 180,
        child: Container(
          width: 20,
          height: 20,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: AppColors.primary, width: 2.5),
              left: BorderSide(color: AppColors.primary, width: 2.5),
            ),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(4)),
          ),
        ),
      ),
    );
  }
}

void _noop() {}
