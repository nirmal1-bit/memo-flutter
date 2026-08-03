import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memo/core/di/injector.dart';
import 'package:memo/core/services/call_recording_service.dart';
import 'package:memo/core/session/session_service.dart';
import 'package:memo/core/utils/app_utils.dart';
import 'package:memo/features/common/primary_button.dart';
import 'package:memo/features/home/presentation/cubits/chat_cubit.dart';
import 'package:memo/features/video_call/cubit/end_video_call.dart';
import 'package:memo/features/video_call/cubit/make_transcript_cubit.dart';
import 'package:permission_handler/permission_handler.dart';
import '../model/call_request_model.dart';

class VideoCallPageParams {
  VideoCallPageParams({required this.requestModel, required this.connectionId});

  final CallRequestModel requestModel;
  final int connectionId;
}

class VideoCallPage extends StatefulWidget {
  /// Construct the [VideoCallPage]
  const VideoCallPage({super.key, required this.params});

  final VideoCallPageParams params;

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<VideoCallPage> {
  RtcEngine? _engine;
  int? _remoteUid;
  bool _localVideoEnabled = true;
  bool _localAudioEnabled = true;
  bool _speakerEnabled = true;
  bool _permissionsGranted = false;
  bool _callEnded = false;
  late CallRecordingService recordingService;

  @override
  void initState() {
    super.initState();
    // CheckCallKit.isInCall = true;
    recordingService = CallRecordingService();
    _initAgora();
  }

  Future<void> _initAgora() async {
    try {
      await recordingService.startRecording("1");
      print("Call recording started");
    } catch (e) {
      debugPrint("Call recording error: $e");
      AppUtils.showErrorSnackbar(message: "Failed to start call recording");
    }
    final int validUid = int.tryParse(await SessionService().userId) ?? 0;
    await _checkPermissions();

    if (!_permissionsGranted) {
      return;
    }

    try {
      _engine = createAgoraRtcEngine();

      await _engine?.initialize(
        RtcEngineContext(
          appId: widget.params.requestModel.appId,
          channelProfile: ChannelProfileType.channelProfileCommunication,
        ),
      );

      _engine?.registerEventHandler(
        RtcEngineEventHandler(
          onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
            debugPrint("Local user ${connection.localUid} joined");
            AppUtils.showSuccessSnackbar(message: "Connected to call!");
          },
          onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
            debugPrint("Remote user $remoteUid joined");
            setState(() {
              _remoteUid = remoteUid;
            });
            AppUtils.showSuccessSnackbar(message: "User Joined!");
          },
          onUserOffline:
              (
                RtcConnection connection,
                int remoteUid,
                UserOfflineReasonType reason,
              ) {
                debugPrint("Remote user $remoteUid left channel");
                setState(() {
                  _remoteUid = null;
                });
                AppUtils.showSuccessSnackbar(message: "User Disconnected!");
              },
          onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
            debugPrint(
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token',
            );
          },
          onError: (ErrorCodeType err, String msg) {
            debugPrint("The error is $err ");
            AppUtils.showErrorSnackbar(message: "$err");
          },
        ),
      );

      await _engine?.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
      await _engine?.enableVideo();
      await _engine?.enableAudio();
      await _engine?.setDefaultAudioRouteToSpeakerphone(_speakerEnabled);
      await _engine?.setAudioProfile(
        profile: AudioProfileType.audioProfileMusicHighQuality,
        scenario: AudioScenarioType.audioScenarioChatroom,
      );

      debugPrint("The token is ${widget.params.requestModel.token}");
      debugPrint("The channel is ${widget.params.requestModel.channel}");
      debugPrint("The uid is $validUid");

      await _engine?.joinChannel(
        channelId: widget.params.requestModel.channel,
        options: const ChannelMediaOptions(),
        token: widget.params.requestModel.token,
        uid: validUid,
      );

      // await FlutterCallkitIncoming.endAllCalls();
    } catch (e) {
      debugPrint('Agora initialization error: $e');
      AppUtils.showErrorSnackbar(message: "Failed to initialize call");
    }
  }

  Future<void> _checkPermissions() async {
    var cameraStatus = await Permission.camera.status;
    var microphoneStatus = await Permission.microphone.status;

    if (!cameraStatus.isGranted || !microphoneStatus.isGranted) {
      setState(() {
        _permissionsGranted = false;
      });
    } else {
      setState(() {
        _permissionsGranted = true;
      });
    }
  }

  Future<void> _requestPermissions() async {
    // Request both at the same time
    final statuses = await [Permission.camera, Permission.microphone].request();

    final cameraStatus = statuses[Permission.camera];
    final microphoneStatus = statuses[Permission.microphone];

    print('Camera: $cameraStatus');
    print('Microphone: $microphoneStatus');

    if (cameraStatus!.isGranted && microphoneStatus!.isGranted) {
      setState(() => _permissionsGranted = true);
      await _initAgora();
      return;
    }

    // Handle permanently denied (user tapped "Don't Allow" twice on iOS)
    if (cameraStatus.isPermanentlyDenied) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Permissions Required'),
            content: const Text(
              'Camera and microphone access are required for video calls. '
              'Please enable them in Settings.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  openAppSettings(); // opens iOS Settings
                },
                child: const Text('Open Settings'),
              ),
            ],
          ),
        );
      }
      return;
    }

    // Denied but not permanently
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Camera and microphone permissions are required.'),
        ),
      );
    }
  }

  Future<void> _toggleLocalVideo() async {
    setState(() {
      _localVideoEnabled = !_localVideoEnabled;
    });
    await _engine?.enableLocalVideo(_localVideoEnabled);
  }

  Future<void> _toggleLocalAudio() async {
    setState(() {
      _localAudioEnabled = !_localAudioEnabled;
    });
    await _engine?.enableLocalAudio(_localAudioEnabled);
  }

  Future<void> _toggleSpeaker() async {
    setState(() {
      _speakerEnabled = !_speakerEnabled;
    });
    await _engine?.setDefaultAudioRouteToSpeakerphone(_speakerEnabled);
  }

  Future<void> _switchCamera() async {
    await _engine?.switchCamera();
  }

  Future<void> _leaveChannel() async {
    await _engine?.leaveChannel();
    await _engine?.release();
    // await FlutterCallkitIncoming.endAllCalls();
    // CheckCallKit.isInCall = false;
  }

  @override
  void dispose() {
    if (!_callEnded) {
      try {
        getIt<EndVideoCall>().endCall(
          widget.params.connectionId,
          widget.params.requestModel.videoCallSessionId,
        );
        recordingService.stopRecording();
      } catch (_) {}
      _callEnded = true;
    }
    _leaveChannel();
    super.dispose();
  }

  Widget _renderLocalPreview() {
    if (_localVideoEnabled && _engine != null) {
      return AgoraVideoView(
        controller: VideoViewController(
          rtcEngine: _engine!,
          canvas: VideoCanvas(uid: 0),
        ),
      );
    } else {
      return Container(
        color: Colors.grey[800],
        child: const Center(
          child: Icon(Icons.person, size: 100, color: Colors.white54),
        ),
      );
    }
  }

  Widget _renderRemoteVideo() {
    if (_remoteUid != null && _engine != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine!,
          canvas: VideoCanvas(uid: _remoteUid),
          connection: RtcConnection(
            channelId: widget.params.requestModel.channel,
          ),
        ),
      );
    } else {
      return Container(
        color: Colors.grey[800],
        child: const Center(
          child: Text(
            'Waiting for user to join...',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }

  Widget _buildControlButtons(BuildContext context) {
    return Positioned(
      bottom: 50,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Microphone toggle
          FloatingActionButton(
            heroTag: "mic_toggle",
            onPressed: _toggleLocalAudio,
            backgroundColor: _localAudioEnabled ? Colors.blue : Colors.red,
            child: Icon(_localAudioEnabled ? Icons.mic : Icons.mic_off),
          ),

          // Camera toggle
          FloatingActionButton(
            heroTag: "video_toggle",
            onPressed: _toggleLocalVideo,
            backgroundColor: _localVideoEnabled ? Colors.blue : Colors.red,
            child: Icon(
              _localVideoEnabled ? Icons.videocam : Icons.videocam_off,
            ),
          ),

          // Switch camera
          FloatingActionButton(
            heroTag: "switch_camera",
            onPressed: _switchCamera,
            backgroundColor: Colors.blue,
            child: const Icon(Icons.switch_camera),
          ),

          // Speaker toggle
          FloatingActionButton(
            heroTag: "speaker_toggle",
            onPressed: _toggleSpeaker,
            backgroundColor: _speakerEnabled ? Colors.blue : Colors.grey,
            child: Icon(_speakerEnabled ? Icons.volume_up : Icons.volume_off),
          ),

          // End call
          FloatingActionButton(
            heroTag: "end_call",
            onPressed: () async {
              final shouldEnd = await showDialog<bool>(
                context: context,
                builder: (dialogContext) {
                  return AlertDialog(
                    title: const Text("Call in progress"),
                    content: const Text("Are you sure you want to hang up?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(dialogContext).pop(false),
                        child: const Text("No"),
                      ),
                      TextButton(
                        onPressed: () async {
                          print("This is getting called");
                          getIt<EndVideoCall>().endCall(
                            widget.params.connectionId,
                            widget.params.requestModel.videoCallSessionId,
                          );
                          final path = await recordingService.stopRecording();
                          print("The path path to be send to backend is $path");
                          if (path != null) {
                            getIt<MakeTranscriptCubit>().makeTranscript(
                              widget.params.connectionId,
                              path,
                              widget.params.requestModel.videoCallSessionId,
                            );
                          }

                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text("Yes"),
                      ),
                    ],
                  );
                },
              );

              if (shouldEnd == true) {
                if (!_callEnded && mounted) {
                  try {
                    context.read<EndVideoCall>().endCall(
                      widget.params.connectionId,
                      widget.params.requestModel.videoCallSessionId,
                    );
                    final path = await recordingService.stopRecording();
                    print("The path is $path");
                  } catch (_) {}
                  _callEnded = true;
                }

                await _leaveChannel();
                if (mounted) {
                  Navigator.of(context).pop();
                }
              }
            },
            backgroundColor: Colors.red,
            child: const Icon(Icons.call_end),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChatCubit>(create: (context) => getIt<ChatCubit>()),
        BlocProvider<MakeTranscriptCubit>(
          create: (context) => getIt<MakeTranscriptCubit>(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              final shouldPop = await showDialog<bool>(
                context: context,
                builder: (dialogContext) {
                  return AlertDialog(
                    title: const Text("Call in progress"),
                    content: const Text("Are you sure you want to hang up?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(dialogContext).pop(false),
                        child: const Text("No"),
                      ),
                      TextButton(
                        onPressed: () async {
                          if (!context.mounted) return;
                          // ✅ FIX: guard _callEnded before calling endCall
                          if (!_callEnded) {
                            context.read<EndVideoCall>().endCall(
                              widget.params.connectionId,
                              widget.params.requestModel.videoCallSessionId,
                            );
                            _callEnded = true;
                          }
                          final path = await CallRecordingService()
                              .stopRecording();
                          print("The path is $path");
                          await _leaveChannel();
                          Navigator.of(dialogContext).pop(true);
                        },
                        child: const Text("Yes"),
                      ),
                    ],
                  );
                },
              );
              return shouldPop ?? false;
            },
            child: Scaffold(
              backgroundColor: Colors.black,
              body: !_permissionsGranted
                  ? SafeArea(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Please provide camera and microphone access to join the video call",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 20),
                              PrimaryButton(
                                label: "Allow Access",
                                onTap: _requestPermissions,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : SafeArea(
                      child: Stack(
                        children: [
                          // Remote user video (larger view)
                          Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height - 100,
                                width: double.infinity,
                                child: _renderRemoteVideo(),
                              ),
                            ],
                          ),

                          // Floating local video preview
                          Positioned(
                            top: 50,
                            right: 20,
                            child: Container(
                              width: 120,
                              height: 160,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: _renderLocalPreview(),
                              ),
                            ),
                          ),

                          _buildControlButtons(context),
                        ],
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
