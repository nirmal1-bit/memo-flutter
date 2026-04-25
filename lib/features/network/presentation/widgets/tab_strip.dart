import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';

enum NetworkTab { connections, sent, received }

class TabStrip extends StatelessWidget {
  const TabStrip({
    super.key,
    required this.selectedTab,
    required this.onChanged,
  });

  final NetworkTab selectedTab;
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
              label: 'Connections',
              active: selectedTab == NetworkTab.connections,
              onTap: () => onChanged(NetworkTab.connections),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: _SegmentChip(
              label: 'Sent',
              active: selectedTab == NetworkTab.sent,
              onTap: () => onChanged(NetworkTab.sent),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: _SegmentChip(
              label: 'Received',
              active: selectedTab == NetworkTab.received,
              onTap: () => onChanged(NetworkTab.received),
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
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

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
            ],
          ),
        ),
      ),
    );
  }
}
