import 'package:flutter/material.dart';
import 'package:memo/features/common/app_spacing.dart';

class AppBottomSpacing extends StatelessWidget {
  const AppBottomSpacing({super.key, this.height = 16});
  final num height;
  @override
  Widget build(BuildContext context) {
    return VerticalSpacing(MediaQuery.of(context).viewPadding.bottom + height);
  }
}
