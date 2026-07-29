import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/theme/app_text_styles.dart';

class MatchHeader extends StatelessWidget {
  const MatchHeader({super.key, required this.range, required this.onRangeChanged});

  final int range;
  final ValueChanged<int> onRangeChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: AppColors.appBarGradient,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.favorite,
                      color: AppColors.white,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Matches',
                    style: AppTextStyles.libre.copyWith(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
              ],
            ),
            InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () => _showRangePicker(context),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.brandBackgroundLight),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.near_me_outlined, size: 17, color: AppColors.primary),
                    const SizedBox(width: 5),
                    Text(
                      _formatRange(range),
                      style: AppTextStyles.rubik.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down, size: 18, color: AppColors.primary),
                  ],
                ),
              ),
            ),
          ],
          ),
        )
        .animate()
        .fadeIn(duration: 400.ms)
        .slideY(begin: -0.3, end: 0, curve: Curves.easeOut);
  }

  String _formatRange(int meters) => '${(meters / 1000).round()} km';

  Future<void> _showRangePicker(BuildContext context) async {
    final selected = await showModalBottomSheet<int>(
      context: context,
      showDragHandle: true,
      builder: (context) => _RangePicker(initialRange: range),
    );
    if (selected != null) onRangeChanged(selected);
  }
}

class _RangePicker extends StatefulWidget {
  const _RangePicker({required this.initialRange});
  final int initialRange;

  @override
  State<_RangePicker> createState() => _RangePickerState();
}

class _RangePickerState extends State<_RangePicker> {
  late double _range;

  @override
  void initState() {
    super.initState();
    _range = widget.initialRange.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    final kilometers = (_range / 1000).round();
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Match distance', style: AppTextStyles.libre.copyWith(fontSize: 21, fontWeight: FontWeight.w700, color: AppColors.textDark)),
          const SizedBox(height: 6),
          Text('Show people within $kilometers km of you.', style: AppTextStyles.rubik.copyWith(fontSize: 13, color: AppColors.textLightDark)),
          Slider(
            value: _range,
            min: 1000,
            max: 200000,
            divisions: 199,
            activeColor: AppColors.primary,
            label: '$kilometers km',
            onChanged: (value) => setState(() => _range = value),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context, _range.round()),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: AppColors.white),
              child: const Text('Apply distance'),
            ),
          ),
        ],
      ),
    );
  }
}
