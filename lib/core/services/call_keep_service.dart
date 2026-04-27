// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter_callkit_incoming/entities/entities.dart';
// import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
// import 'package:uuid/uuid.dart';

// Future<void> checkActiveCalls() async {
//   print("Checking active calls on app start...");

//   final calls = await FlutterCallkitIncoming.activeCalls();
//   if (calls == null || calls.isEmpty) return;
//   print("The active call data is ${calls[0]}]");
//   print("The accepted status is ${calls[0]['accepted']}");
//   try {
//     final call = calls[0];
//     final extra = call['extra'] ?? {};

//     final bookingId =
//         int.tryParse(
//           (extra['bookingId'] ?? extra['booking_id'] ?? '').toString(),
//         ) ??
//         0;
//     final videoId =
//         int.tryParse(
//           (extra['videoId'] ?? extra['video_call_session_id'] ?? '').toString(),
//         ) ??
//         0;

//     if (calls[0]['accepted']) {
//       if (bookingId > 0 && videoId > 0) {
//         try {
//           // // final repo = getIt<DashboardRemoteSource>();
//           // final response = await repo.getUser();

//           // response.fold((l) => print('Join call failed: $l'), (r) async {
//           //   final data = r.data;
//           // });jvkhkhk
//         } catch (e) {
//           print('Error joining call from CallKit, saved pending: $e');
//         }
//       }

//       if (bookingId > 0 && videoId > 0) {
//         // final repo = getIt<VideoCallRepository>();
//         // final response = await repo.joinCall(bookingId, videoId);
//         // response.fold((l) => print('Join call failed from activeCalls: $l'), (
//         //   r,
//         // ) async {
//         //   final callModel = r.data;
//         //   await getIt<AppRouter>().push(
//         //     VideoCallPageRoute(
//         //       callRequestModel: callModel,
//         //       bookingId: bookingId,
//         //     ),
//         //   );
//         // });
//       }
//     }
//   } catch (e) {
//     print("activeCalls recovery failed: $e");
//   }
// }

// class CallKeepService {
//   void _registerListener() async {
//     await FlutterCallkitIncoming.canUseFullScreenIntent();
//     await FlutterCallkitIncoming.requestFullIntentPermission();

//     FlutterCallkitIncoming.onEvent.listen((event) async {
//       if (event == null) return;
//       try {
//         switch (event.event) {
//           case Event.actionCallAccept:
//             final extra =
//                 event.body['extra'] ?? event.body['payload'] ?? event.body;

//             final bookingId =
//                 int.tryParse(
//                   (extra['bookingId'] ?? extra['booking_id'] ?? '').toString(),
//                 ) ??
//                 0;
//             final videoId =
//                 int.tryParse(
//                   (extra['videoId'] ?? extra['video_call_session_id'] ?? '')
//                       .toString(),
//                 ) ??
//                 0;

//             if (bookingId > 0 && videoId > 0) {
//               try {
//                 // final repo = getIt<VideoCallRepository>();
//                 // final response = await repo.joinCall(bookingId, videoId);

//                 // response.fold((l) => print('Join call failed: $l'), (r) async {
//                 //   final callModel = r.data;
//                   try {
//                     // await getIt<AppRouter>().push(
//                     //   VideoCallPageRoute(
//                     //     callRequestModel: callModel,
//                     //     bookingId: bookingId,
//                     //   ),
//                     // );
//                   } catch (navErr) {
//                     print(
//                       'Navigation not ready, saved pending accept: $navErr',
//                     );
//                   }
//                 });
//               } catch (e) {
//                 print('Error joining call from CallKit, saved pending: $e');
//               }
//             }
//             break;

//           case Event.actionCallDecline:
//             await FlutterCallkitIncoming.endAllCalls();
//           // final extra =
//           //     event.body['extra'] ?? event.body['payload'] ?? event.body;

//           // final bookingId =
//           //     int.tryParse(
//           //       (extra['bookingId'] ?? extra['booking_id'] ?? '').toString(),
//           //     ) ??
//           //     0;
//           // final videoId =
//           //     int.tryParse(
//           //       (extra['videoId'] ?? extra['video_call_session_id'] ?? '')
//           //           .toString(),
//           //     ) ??
//           //     0;

//           // if (bookingId > 0 && videoId > 0) {
//           //   try {
//           //     final repo = getIt<VideoCallRepository>();
//           //     final response = await repo.endCall(bookingId, videoId);

//           //     response.fold(
//           //       (l) => print('Join call failed: $l'),
//           //       (r) async {},
//           //     );
//           //   } catch (e) {
//           //     print('Error joining call from CallKit, saved pending: $e');
//           //   }
//           // }

//           case Event.actionCallEnded:
//             await FlutterCallkitIncoming.endAllCalls();
//             break;

//           default:
//             print('Unhandled CallKit event: ${event.event}');
//         }
//       } catch (e) {
//         print('CallKit event handling error: $e');
//       }
//     });
//   }

//   void init() => _registerListener();

//   Future<void> showCallKit(Map<String, dynamic> data) async {
//     final mapData = data['initiator'] is String
//         ? jsonDecode(data['initiator']) as Map<String, dynamic>
//         : data['initiator'] as Map<String, dynamic>;

//     const uuid = Uuid();

//     final params = CallKitParams(
//       // id: data["booking_id"].toString(),
//       id: data["booking_id"].toString(),

//       nameCaller: mapData['name'] ?? 'Unknown',
//       handle: "",
//       type: 0,
//       duration: 30000,
//       textAccept: "Accept",
//       textDecline: "Decline",
//       avatar: 'assets/images/pujapathlogo.png',
//       android: AndroidParams(
//         isShowFullLockedScreen:
//             await FlutterCallkitIncoming.canUseFullScreenIntent(),
//         isCustomNotification: true,
//         isShowLogo: true,
//         ringtonePath: "system_ringtone_default",
//         backgroundColor: "#0955fa",
//       ),
//       ios: const IOSParams(
//         handleType: 'generic',
//         supportsVideo: true,
//         maximumCallGroups: 1,
//         maximumCallsPerCallGroup: 1,
//         audioSessionMode: 'default',
//         audioSessionActive: true,
//         audioSessionPreferredSampleRate: 44100.0,
//         audioSessionPreferredIOBufferDuration: 0.005,
//         supportsDTMF: true,
//         supportsHolding: true,
//         supportsGrouping: false,
//         supportsUngrouping: false,
//         ringtonePath: 'system_ringtone_default', // ✅ Add this
//       ),
//       extra: {
//         "bookingId": data["booking_id"],
//         "videoId": data["video_call_session_id"],
//         "uuid": uuid.v4(),
//       },
//     );

//     await FlutterCallkitIncoming.showCallkitIncoming(params);
//   }
// }
