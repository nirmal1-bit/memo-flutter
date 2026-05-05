import 'dart:async';
import 'package:flutter_callkit_incoming/entities/entities.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:memo/core/di/injector.dart';
import 'package:memo/core/routes/app_router.dart';
import 'package:memo/core/routes/app_routes.dart';
import 'package:memo/features/video_call/pages/video_call_screen.dart';
import 'package:memo/features/video_call/repository/video_call_repository.dart';
import 'package:uuid/uuid.dart';

Map<String, int> _extractIds(Map<Object?, Object?> source) {
  final connectionId =
      int.tryParse(
        (source['connectionId'] ?? source['connection_id'] ?? '').toString(),
      ) ??
      0;

  final sessionId =
      int.tryParse(
        (source['sessionId'] ?? source['session_id'] ?? '').toString(),
      ) ??
      0;

  return {"connectionId": connectionId, "sessionId": sessionId};
}

Future<void> _joinAndNavigate(int connectionId, int sessionId) async {
  if (connectionId <= 0 || sessionId <= 0) return;

  final repo = getIt<VideoCallRepository>();
  final response = await repo.joinCall(connectionId, sessionId);

  response.fold((l) => print('Join call failed: $l'), (r) async {
    await AppRouter.router.push(
      AppRoutes.videoScreen,
      extra: VideoCallPageParams(
        requestModel: r.data,
        connectionId: connectionId,
      ),
    );
  });
}

Future<void> checkActiveCalls() async {
  final calls = await FlutterCallkitIncoming.activeCalls();
  if (calls == null || calls.isEmpty) return;

  final call = calls.first;

  if (call['accepted'] != true) return;

  final ids = _extractIds(call['extra'] ?? {});
  await _joinAndNavigate(ids['connectionId']!, ids['sessionId']!);
}

class CallKeepService {
  void init() => _registerListener();

  void _registerListener() async {
    await FlutterCallkitIncoming.requestFullIntentPermission();

    FlutterCallkitIncoming.onEvent.listen((event) async {
      if (event == null) return;

      final data = event.body['extra'] ?? event.body['payload'] ?? event.body;

      final ids = _extractIds(data);

      switch (event.event) {
        case Event.actionCallAccept:
          await _joinAndNavigate(ids['connectionId']!, ids['sessionId']!);
          break;

        case Event.actionCallDecline:
        case Event.actionCallEnded:
          await FlutterCallkitIncoming.endAllCalls();
          break;

        default:
          print('Unhandled CallKit event: ${event.event}');
      }
    });
  }

  Future<void> showCallKit(Map<String, dynamic> data) async {
    const uuid = Uuid();
    final callId = uuid.v4();

    final params = CallKitParams(
      id: callId,
      nameCaller: data['username'] ?? 'Menmo Call',
      handle: "",
      type: 0,
      duration: 30000,
      textAccept: "Accept",
      textDecline: "Decline",
      android: AndroidParams(
        isShowFullLockedScreen:
            await FlutterCallkitIncoming.canUseFullScreenIntent(),
        isCustomNotification: true,
        isShowLogo: true,
        ringtonePath: "system_ringtone_default",
        backgroundColor: "#0955fa",
      ),
      ios: const IOSParams(
        handleType: 'generic',
        supportsVideo: true,
        maximumCallGroups: 1,
        maximumCallsPerCallGroup: 1,
        audioSessionMode: 'default',
        audioSessionActive: true,
        audioSessionPreferredSampleRate: 44100.0,
        audioSessionPreferredIOBufferDuration: 0.005,
        supportsDTMF: true,
        supportsHolding: true,
        supportsGrouping: false,
        supportsUngrouping: false,
        ringtonePath: 'system_ringtone_default',
      ),
      extra: {
        "sessionId": data["session_id"],
        "connectionId": data["connection_id"],
      },
    );

    await FlutterCallkitIncoming.showCallkitIncoming(params);
  }
}
