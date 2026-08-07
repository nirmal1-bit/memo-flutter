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
import 'package:memo/features/home/data/models/response/chat_history_response.dart';
import 'package:memo/features/home/data/models/response/connection_response.dart';
import 'package:memo/features/home/presentation/cubits/chat_cubit.dart';
import 'package:memo/features/home/presentation/cubits/get_chat_history_cubit.dart';
import 'package:memo/features/home/presentation/widgets/chat/chat_composer.dart';
import 'package:memo/features/home/presentation/widgets/chat/chat_panel.dart';
import 'package:memo/features/video_call/cubit/join_video_call_cubit.dart';
import 'package:memo/features/video_call/cubit/start_video_call_cubit.dart';
import 'package:memo/features/video_call/model/call_request_model.dart';
import 'package:memo/features/video_call/pages/video_call_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.connection});

  final ConnectionResponse connection;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<ChatCubit>()..connect(connection.id)),
        BlocProvider(
          create: (_) =>
              getIt<GetChatHistoryCubit>()..getChatHistory(connection.id),
        ),
        BlocProvider(create: (_) => getIt<StartVideoCallCubit>()),
        BlocProvider(create: (_) => getIt<JoinVideoCallCubit>()),
      ],
      child: _ChatScreenContent(connection: connection),
    );
  }
}

class _ChatScreenContent extends StatefulWidget {
  const _ChatScreenContent({required this.connection});

  final ConnectionResponse connection;

  @override
  State<_ChatScreenContent> createState() => _ChatScreenContentState();
}

class _ChatScreenContentState extends State<_ChatScreenContent> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _messagesController = ScrollController();

  @override
  void initState() {
    super.initState();
    _messagesController.addListener(_onMessagesScroll);
  }

  @override
  void dispose() {
    _messagesController.removeListener(_onMessagesScroll);
    _messageController.dispose();
    _messagesController.dispose();
    super.dispose();
  }

  /// chatPanel renders with `reverse: true`, so scrolling toward older
  /// messages moves the offset *toward* maxScrollExtent (not toward 0).
  void _onMessagesScroll() {
    if (!_messagesController.hasClients) return;
    final position = _messagesController.position;
    if (position.pixels < position.maxScrollExtent - 120) return;

    final historyCubit = context.read<GetChatHistoryCubit>();
    if (historyCubit.hasNext && !historyCubit.isLoadingMore) {
      historyCubit.loadNextPage(widget.connection.id);
    }
  }

  List<ChatMessage> _historyAsChatMessages(List<ChatHistoryResponse> history) {
    final peerId = widget.connection.userProfile.userId;
    return history
        .map(
          (item) => ChatMessage(
            name: item.senderId == peerId
                ? widget.connection.userProfile.name
                : 'You',
            message: item.message,
            isMe: item.senderId != peerId,
            timeLabel: _formatTime(item.createdAt),
            isCall: item.type.toLowerCase() == 'call',
          ),
        )
        .toList();
  }

  String _formatTime(DateTime value) {
    final local = value.toLocal();
    final hour = local.hour % 12 == 0 ? 12 : local.hour % 12;
    final minute = local.minute.toString().padLeft(2, '0');
    return '$hour:$minute ${local.hour >= 12 ? 'PM' : 'AM'}';
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<
          GetChatHistoryCubit,
          BaseApiState<List<ChatHistoryResponse>>
        >(
          listener: (context, state) {
            state.maybeWhen(
              error: (message) {
                AppUtils.showErrorSnackbar(context: context, message: message);
              },
              validationError: (error) {
                AppUtils.showErrorSnackbar(
                  context: context,
                  message: error.message,
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
                AppUtils.showErrorSnackbar(context: context, message: message);
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
                AppUtils.showErrorSnackbar(context: context, message: message);
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
          ],
        ),
        body: SafeArea(
          child:
              BlocBuilder<
                GetChatHistoryCubit,
                BaseApiState<List<ChatHistoryResponse>>
              >(
                builder: (context, historyState) {
                  final history = historyState.maybeWhen(
                    success: (data) => data,
                    orElse: () => const <ChatHistoryResponse>[],
                  );
                  final historyMessages = _historyAsChatMessages(history);
                  final isLoadingHistory = historyState.maybeWhen(
                    loading: () => true,
                    orElse: () => false,
                  );

                  return BlocConsumer<ChatCubit, ChatState>(
                    listenWhen: (previous, current) =>
                        previous.messages.length != current.messages.length ||
                        previous.status != current.status,
                    listener: (context, state) {
                      if (state.status == ChatConnectionStatus.error &&
                          state.errorMessage != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.errorMessage!)),
                        );
                      }
                    },
                    builder: (context, state) {
                      // Both history and live messages are newest-first for
                      // ChatPanel's reversed ListView.
                      final messages = [...state.messages, ...historyMessages];
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ChatPanel(
                                messagesController: _messagesController,
                                messages: messages,
                                status: state.status,
                                errorMessage: state.errorMessage,
                                isLoading: isLoadingHistory,
                                isLoadingMore: context
                                    .read<GetChatHistoryCubit>()
                                    .isLoadingMore,
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
                  );
                },
              ),
        ),
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
