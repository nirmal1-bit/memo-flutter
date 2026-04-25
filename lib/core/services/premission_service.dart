// import 'package:permission_handler/permission_handler.dart';

// class AlarmPermissionService {
//   static Future<void> checkNotificationPermission() async {
//     final status = await Permission.notification.status;

//     if (status.isDenied) {
//       await Permission.notification.request();
//     }
//   }

//   static Future<void> checkScheduleExactAlarmPermission() async {
//     final status = await Permission.scheduleExactAlarm.status;

//     if (status.isDenied) {
//       await Permission.scheduleExactAlarm.request();
//     }
//   }
// }
