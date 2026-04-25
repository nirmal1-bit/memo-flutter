// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:memo/core/constants/app_colors.dart';

// class AppTickMark extends StatefulWidget {
//   const AppTickMark({
//     super.key,
//     this.size = 20,
//     required this.onTap,
//     required this.id,
//     required this.isChecked,
//     this.boolForTask = false,
//     required this.onAnimation,
//   });
//   final double size;
//   final int id;
//   final void Function(int id) onTap;
//   final void Function() onAnimation;
//   final bool isChecked;
//   final bool boolForTask;
//   @override
//   State<AppTickMark> createState() => _AppTickMarkState();
// }

// class _AppTickMarkState extends State<AppTickMark> {
//   bool isChecked = false;
//   bool pressed = false;

//   @override
//   Widget build(BuildContext context) {
//     isChecked = widget.isChecked;
//     return GestureDetector(
//       onTap: () async {
//         setState(() {
//           isChecked = !isChecked;
//         });
//         widget.onAnimation();

//         if (widget.boolForTask) {
//           await Future.delayed(const Duration(milliseconds: 500));
//         }

//         widget.onTap(widget.id);
//       },

//       onTapDown: (_) => setState(() => pressed = true),
//       onTapUp: (_) {
//         setState(() => pressed = false);
//       },

//       child: AnimatedScale(
//         scale: pressed ? 0.5 : 1.0,
//         duration: Duration(milliseconds: 120),
//         child: Container(
//           decoration: BoxDecoration(
//             color: isChecked
//                 ? AppColors.primaryDark
//                 : AppColors.background.withAlpha(122),

//             borderRadius: BorderRadius.circular(12),
//           ),

//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),

//             child: FaIcon(
//               isChecked ? FontAwesomeIcons.check : FontAwesomeIcons.circle,
//               size: widget.size.sp,
//               color: isChecked ? AppColors.white : AppColors.black,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
