import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:memo/core/chat/chat_state.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/di/injector.dart';
import 'package:memo/core/routes/app_routes.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/core/utils/app_utils.dart';
import 'package:memo/features/network/data/models/response/connection_response.dart';
import 'package:memo/features/network/presentation/cubits/chat_cubit.dart';
import 'package:memo/features/network/presentation/widgets/chat/chat_composer.dart';
import 'package:memo/features/network/presentation/widgets/chat/chat_panel.dart';
import 'package:memo/features/video_call/cubit/join_video_call_cubit.dart';
import 'package:memo/features/video_call/cubit/start_video_call_cubit.dart';
import 'package:memo/features/video_call/model/call_request_model.dart';
import 'package:memo/features/video_call/pages/video_call_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.connection});

  final ConnectionResponse connection;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _messagesController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _messagesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<ChatCubit>()..connect(widget.connection.id),
        ),

        BlocProvider(create: (_) => getIt<StartVideoCallCubit>()),

        BlocProvider(create: (_) => getIt<JoinVideoCallCubit>()),
      ],
      child: Builder(
        builder: (context) {
          return MultiBlocListener(
            listeners: [
              BlocListener<StartVideoCallCubit, BaseApiState<CallRequestModel>>(
                listener: (context, state) async {
                  state.maybeWhen(
                    success: (data) async {
                      AppUtils.showSuccessSnackbar(
                        context: context,
                        message: 'Starting video call',
                      );
                      context.replace(
                        AppRoutes.videoScreen,
                        extra: VideoCallPageParams(
                          requestModel: data,
                          connectionId: widget.connection.id,
                        ),
                      );
                    },
                    error: (message) {
                      AppUtils.showErrorSnackbar(
                        context: context,
                        message: message,
                      );
                    },
                    validationError: (validationError) {
                      AppUtils.showErrorSnackbar(
                        context: context,
                        message: validationError.message,
                      );
                    },
                    noInternet: () {
                      AppUtils.showErrorSnackbar(
                        context: context,
                        message: 'No internet connection',
                      );
                    },
                    orElse: () {},
                  );
                },
              ),

              BlocListener<JoinVideoCallCubit, BaseApiState<CallRequestModel>>(
                listener: (context, state) async {
                  state.maybeWhen(
                    success: (data) async {
                      AppUtils.showSuccessSnackbar(
                        context: context,
                        message: 'Starting video call',
                      );
                      context.replace(
                        AppRoutes.videoScreen,
                        extra: VideoCallPageParams(
                          requestModel: data,
                          connectionId: widget.connection.id,
                        ),
                      );
                    },
                    error: (message) {
                      AppUtils.showErrorSnackbar(
                        context: context,
                        message: message,
                      );
                    },
                    validationError: (validationError) {
                      AppUtils.showErrorSnackbar(
                        context: context,
                        message: validationError.message,
                      );
                    },
                    noInternet: () {
                      AppUtils.showErrorSnackbar(
                        context: context,
                        message: 'No internet connection',
                      );
                    },
                    orElse: () {},
                  );
                },
              ),
            ],
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: AppColors.scaffoldBackground,
              appBar: AppBar(
                backgroundColor: AppColors.scaffoldBackground,
                elevation: 0,
                foregroundColor: AppColors.softPrimary,
                titleSpacing: 0,
                title: Text(
                  'Chat',
                  style: AppTextStyles.libre.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.softPrimary,
                  ),
                ),
                actions: [
                  IconButton(
                    tooltip: 'Start video call',
                    onPressed: () {
                      context.read<StartVideoCallCubit>().startCall(
                        widget.connection.id,
                      );
                    },
                    icon: const Icon(Icons.videocam),
                  ),

                  IconButton(
                    tooltip: 'Join video call',
                    onPressed: () {
                      context.read<JoinVideoCallCubit>().joinCall(
                        widget.connection.id,
                        14,
                      );
                    },
                    icon: const Icon(Icons.join_full),
                  ),
                ],
              ),
              body: SafeArea(
                child: BlocConsumer<ChatCubit, ChatState>(
                  listenWhen: (previous, current) =>
                      previous.messages.length != current.messages.length ||
                      previous.status != current.status,
                  listener: (context, state) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (_messagesController.hasClients) {
                        _messagesController.animateTo(
                          _messagesController.position.maxScrollExtent + 120,
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeOut,
                        );
                      }
                    });

                    if (state.status == ChatConnectionStatus.error &&
                        state.errorMessage != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage!)),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ChatPanel(
                              messagesController: _messagesController,
                              messages: state.messages,
                              status: state.status,
                              errorMessage: state.errorMessage,
                            ),
                          ),
                          const SizedBox(height: 12),
                          SafeArea(
                            top: false,
                            child: ChatComposer(
                              controller: _messageController,
                              onSend: () => _sendMessage(context),
                              isBusy:
                                  state.status ==
                                  ChatConnectionStatus.connecting,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _sendMessage(BuildContext context) {
    final text = _messageController.text.trim();
    if (text.isEmpty) {
      return;
    }

    context.read<ChatCubit>().sendMessage(text);
    _messageController.clear();
  }
}
