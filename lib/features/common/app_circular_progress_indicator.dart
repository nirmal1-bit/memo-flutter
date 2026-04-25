// import 'package:flutter/material.dart';
// import 'package:memo/core/theme/app_text_styles.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';

// class AppCircularProgressIndicator extends StatelessWidget {
//   const AppCircularProgressIndicator({
//     super.key,
//     required this.radius,
//     required this.color,
//     required this.completed,
//     required this.fontColor,
//     required this.lineWidth,
//     required this.fontSize,
//     required this.backGroundColor,
//   });
//   final double radius;
//   final Color color;
//   final double completed;
//   final Color fontColor;
//   final double lineWidth;
//   final double fontSize;
//   final Color backGroundColor;

//   @override
//   Widget build(BuildContext context) {
//     final st = completed * 100;
//     return CircularPercentIndicator(
//       radius: radius,
//       animation: true,
//       percent: completed,
//       lineWidth: lineWidth,
//       progressColor: color,
//       backgroundColor: backGroundColor,
//       center: Text(
//         "${st.toInt()}%",
//         style: AppTextStyles.normal.copyWith(
//           fontSize: fontSize,
//           fontWeight: FontWeight.bold,
//           color: fontColor,
//         ),
//       ),
//       circularStrokeCap: CircularStrokeCap.round,
//     );
//   }
// }
