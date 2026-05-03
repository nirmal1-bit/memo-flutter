import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memo/core/chat/chat_state.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/di/injector.dart';
import 'package:memo/features/ai_chat/cubits/ai_chat_cubit.dart';
import 'package:memo/features/ai_chat/presentation/widgets/ai_chat_panel.dart';
import 'package:memo/features/network/presentation/widgets/chat/chat_composer.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _messagesController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => getIt<AiChatCubit>()..connect())],
      child: Builder(
        builder: (context) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: AppColors.scaffoldBackground,
            body: SafeArea(
              child: BlocConsumer<AiChatCubit, ChatState>(
                listenWhen: (previous, current) =>
                    previous.messages.length != current.messages.length ||
                    _lastMessageChanged(previous, current) ||
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
                          child: AiChatPanel(
                            messagesController: _messagesController,
                            messages: state.messages,
                            status: state.status,
                            errorMessage: state.errorMessage,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ChatComposer(
                          controller: _messageController,
                          onSend: () => _sendMessage(context),
                          isBusy:
                              state.status == ChatConnectionStatus.connecting,
                        ),

                        SizedBox(height: 60),
                      ],
                    ),
                  );
                },
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

    context.read<AiChatCubit>().sendMessage(text);
    _messageController.clear();
  }

  bool _lastMessageChanged(ChatState previous, ChatState current) {
    if (previous.messages.isEmpty || current.messages.isEmpty) {
      return previous.messages.length != current.messages.length;
    }

    final previousLastMessage = previous.messages.last;
    final currentLastMessage = current.messages.last;

    return previousLastMessage.name != currentLastMessage.name ||
        previousLastMessage.message != currentLastMessage.message ||
        previousLastMessage.isMe != currentLastMessage.isMe ||
        previousLastMessage.timeLabel != currentLastMessage.timeLabel;
  }
}
