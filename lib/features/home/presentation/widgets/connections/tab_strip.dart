import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/features/network/presentation/widgets/network/network_widget_types.dart';

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
    return Row(
      children: _tabs.map((item) {
        final isSelected = selected == item.tab;
        return Expanded(
          child: GestureDetector(
            onTap: () => onChanged(item.tab),
            behavior: HitTestBehavior.opaque,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 150),
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 13,
                      fontWeight: isSelected
                          ? FontWeight.w500
                          : FontWeight.w400,
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.textGrey,
                    ),
                    child: Text(item.label, textAlign: TextAlign.center),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  height: 1.5,
                  color: isSelected ? AppColors.primary : Colors.transparent,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
