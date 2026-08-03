import 'package:flutter/material.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/features/home/presentation/widgets/connections/widget_types.dart';

class ConnectionTabStrip extends StatelessWidget {
  const ConnectionTabStrip({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final ConnectionTab selected;
  final ValueChanged<ConnectionTab> onChanged;

  static const _tabs = [
    (label: 'Connections', tab: ConnectionTab.connections),
    (label: 'Sent', tab: ConnectionTab.sent),
    (label: 'Received', tab: ConnectionTab.received),
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
