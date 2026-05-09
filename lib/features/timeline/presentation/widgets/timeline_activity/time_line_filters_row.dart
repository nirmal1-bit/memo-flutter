import 'package:flutter/material.dart';
import 'package:memo/features/timeline/presentation/widgets/common/timeline_shared_widgets.dart';
import 'timeline_helpers.dart';

class TimelineFilterRow extends StatelessWidget {
  const TimelineFilterRow({
    super.key,
    required this.selectedType,
    required this.onSelected,
  });

  /// `null` means "All" is selected.
  final TimelineActivityType? selectedType;

  /// Called with `null` when "All" is tapped, or the tapped type otherwise.
  final ValueChanged<TimelineActivityType?> onSelected;

  @override
  Widget build(BuildContext context) {
    final chips = <Widget>[
      TimelineFilterChip(
        label: 'All',
        selected: selectedType == null,
        onTap: () => onSelected(null),
      ),
    ];

    for (final type in TimelineActivityType.values) {
      chips.add(
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: TimelineFilterChip(
            label: type.filterLabel,
            selected: selectedType == type,
            onTap: () => onSelected(type),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: chips),
    );
  }
}
