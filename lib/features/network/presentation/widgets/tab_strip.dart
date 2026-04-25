import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';

enum NetworkTab { connections, requests }

class TabStrip extends StatelessWidget {
  const TabStrip({
    super.key,
    required this.selectedTab,
    required this.requestCount,
    required this.onChanged,
  });

  final NetworkTab selectedTab;
  final int requestCount;
  final ValueChanged<NetworkTab> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.dividerColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: _SegmentChip(
              label: 'My Connections',
              active: selectedTab == NetworkTab.connections,
              onTap: () => onChanged(NetworkTab.connections),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: _SegmentChip(
              label: 'Requests',
              active: selectedTab == NetworkTab.requests,
              showBadge: requestCount > 0,
              badgeLabel: requestCount.toString(),
              onTap: () => onChanged(NetworkTab.requests),
            ),
          ),
        ],
      ),
    );
  }
}

class _SegmentChip extends StatelessWidget {
  const _SegmentChip({
    required this.label,
    required this.active,
    required this.onTap,
    this.showBadge = false,
    this.badgeLabel,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;
  final bool showBadge;
  final String? badgeLabel;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          height: 42,
          decoration: BoxDecoration(
            color: active ? AppColors.primary : AppColors.transparent,
            borderRadius: BorderRadius.circular(14),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: AppTextStyles.rubik.copyWith(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: active ? AppColors.white : AppColors.primary,
                ),
              ),
              if (showBadge) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: active ? AppColors.white : AppColors.primary,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    badgeLabel ?? '',
                    style: AppTextStyles.rubik.copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: active ? AppColors.primary : AppColors.white,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
