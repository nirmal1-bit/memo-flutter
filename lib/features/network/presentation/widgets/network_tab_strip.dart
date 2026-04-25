import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/features/network/presentation/widgets/network_widget_types.dart';

class NetworkTabStrip extends StatelessWidget {
  const NetworkTabStrip({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final NetworkTab selected;
  final ValueChanged<NetworkTab> onChanged;

  static const _tabs = [
    (label: 'Connections', tab: NetworkTab.connections),
    (label: 'Sent', tab: NetworkTab.sent),
    (label: 'Received', tab: NetworkTab.received),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        children: _tabs.map((item) {
          final isSelected = selected == item.tab;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(item.tab),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(9),
                ),
                alignment: Alignment.center,
                child: Text(
                  item.label,
                  style: AppTextStyles.rubik.copyWith(
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected ? AppColors.white : AppColors.textGrey,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
