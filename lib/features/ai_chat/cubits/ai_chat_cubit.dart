import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/chat/chat_state.dart';
import 'package:memo/core/session/session_service.dart';
import 'package:web_socket_channel/io.dart';

@injectable
class AiChatCubit extends Cubit<ChatState> {
  AiChatCubit({required this.sessionService})
    : super(
        const ChatState(),
      ); // initilizing the initial state of the chatstate

  final SessionService sessionService;

  int? userId;

  IOWebSocketChannel? channel;
  StreamSubscription? _subscription;
  bool _hasConnected = false;
  String incomingMessage = "";

  // making this a future function cause problems i don't know why
  //when doing form getIt it causes some problems
  void connect() async {
    if (_hasConnected || state.status == ChatConnectionStatus.connecting) {
      return;
    }
    // if already hass been connected is in connecting state do nothing

    // state here is the ChatState and copywith is to
    //create new instance of the state with new values and other values same
    emit(
      state.copyWith(
        status: ChatConnectionStatus.connecting,
        errorMessage: null,
      ),
    );

    try {
      userId = int.tryParse(await sessionService.userId);
      final token = await sessionService.token;
      final uri = Uri.parse('ws://192.168.1.76:4000/v1/aiChat');
      channel = IOWebSocketChannel.connect(
        uri,
        headers: {'Authorization': 'Bearer $token'},
      );

      _hasConnected = true;
      emit(
        state.copyWith(
          status: ChatConnectionStatus.connected,
          errorMessage: null,
        ),
      );

      // this is to listen to the incoming messages from the websocket and handle them with the
      //_handleIncomingMessage function and also handle errors and done events
      _subscription = channel!.stream.listen(
        _handleIncomingMessage,
        onError: _handleError,
        onDone: _handleDone,
        cancelOnError: true,
      );
    } catch (error) {
      _hasConnected = false;
      emit(
        state.copyWith(
          status: ChatConnectionStatus.error,
          errorMessage: 'Could not connect to chat: $error',
        ),
      );
    }
  }

  void sendMessage(String text) {
    final message = text.trim();
    if (message.isEmpty) {
      return;
    }

    if (state.status != ChatConnectionStatus.connected || channel == null) {
      emit(
        state.copyWith(
          status: ChatConnectionStatus.error,
          errorMessage: 'Chat is not connected yet.',
        ),
      );
      return;
    }

    final outgoingMessage = ChatMessage(
      name: 'You',
      message: message,
      isMe: true,
      timeLabel: _currentTimeLabel(),
    );

    // i think this is the one which is causing error adding the message

    emit(
      state.copyWith(
        messages: [...state.messages, outgoingMessage],
        status: ChatConnectionStatus.answering,
      ),
    );

    try {
      // this is to send the message to the websocket server and if
      //there is an error in sending the message we need to remove that message from the chat and show the error message
      channel!.sink.add(message);
    } catch (error) {
      _removeLastOptimisticMessage(message);
      emit(
        state.copyWith(
          status: ChatConnectionStatus.error,
          errorMessage: 'Failed to send message: $error',
        ),
      );
    }
  }

  void retry(int id) {
    closeConnection();
    _hasConnected = false;
    connect();
  }

  void _handleIncomingMessage(dynamic rawMessage) {
    final chunk = rawMessage as String;
    if (!state.messages.last.isMe) {
      // update last message
      final last = state.messages.last;
      final updated = last.copyWith(message: last.message + chunk);
      final updatedList = [...state.messages];
      updatedList[updatedList.length - 1] = updated;

      emit(state.copyWith(messages: updatedList));
    } else {
      // first chunk → create message
      final newMsg = ChatMessage(
        name: "Menmo AI",
        message: chunk,
        isMe: false,
        timeLabel: _currentTimeLabel(),
      );

      emit(
        state.copyWith(
          messages: [...state.messages, newMsg],
          status: ChatConnectionStatus.connected,
        ),
      );
    }
  }

  void _handleError(Object error) {
    emit(
      state.copyWith(
        status: ChatConnectionStatus.error,
        errorMessage: 'Chat connection error: $error',
      ),
    );
  }

  void _handleDone() {
    emit(
      state.copyWith(
        status: ChatConnectionStatus.disconnected,
        errorMessage: 'Chat connection closed.',
      ),
    );
    print("This ran");
  }

  void closeConnection() {
    _subscription?.cancel();
    _subscription = null;
    channel?.sink.close();
    channel = null;
  }

  @override
  Future<void> close() {
    closeConnection();
    return super.close();
  }

  //. optimistic update is to add the message to the chat before it is actually sent to the server and
  //if there is an error in sending the message we need to remove that message from the chat and show the error message
  void _removeLastOptimisticMessage(String text) {
    for (var index = state.messages.length - 1; index >= 0; index--) {
      final message = state.messages[index];
      if (message.isMe && message.message == text) {
        final updatedMessages = [...state.messages]..removeAt(index);
        emit(state.copyWith(messages: updatedMessages));
        return;
      }
    }
  }

  String _currentTimeLabel() {
    final now = DateTime.now();
    final hourOfDay = now.hour % 12 == 0 ? 12 : now.hour % 12;
    final minute = now.minute.toString().padLeft(2, '0');
    final suffix = now.hour >= 12 ? 'PM' : 'AM';
    return '$hourOfDay:$minute $suffix';
  }
}
