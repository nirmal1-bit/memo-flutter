import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/session/session_service.dart';
import 'package:memo/features/network/data/models/response/connection_response.dart';
import 'package:web_socket_channel/io.dart';

enum ChatConnectionStatus {
  initial,
  connecting,
  connected,
  disconnected,
  error,
}

// this is the message class
class ChatMessage {
  const ChatMessage({
    required this.name,
    required this.message,
    required this.isMe,
    required this.timeLabel,
  });

  final String name;
  final String message;
  final bool isMe;
  final String timeLabel;
}

// this is the state class
class ChatState {
  const ChatState({
    this.messages = const [],
    this.status = ChatConnectionStatus.initial,
    this.errorMessage,
  });

  final List<ChatMessage> messages;
  final ChatConnectionStatus status;
  final String? errorMessage;

  // copy with to emmit new state with other value same and to give new instance of the object
  // copy with and initiate new object refrence
  ChatState copyWith({
    List<ChatMessage>? messages,
    ChatConnectionStatus? status,
    String? errorMessage,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}

@injectable
class ChatCubit extends Cubit<ChatState> {
  ChatCubit({required this.sessionService})
    : super(
        const ChatState(),
      ); // initilizing the initial state of the chatstate

  final SessionService sessionService;

  int? userId;

  IOWebSocketChannel? _channel;
  StreamSubscription? _subscription;
  bool _hasConnected = false;

  // making this a future function cause problems i don't know why
  //when doing form getIt it causes some problems
  void connect(int id) async {
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
      final uri = Uri.parse('ws://192.168.1.94:4000/v1/chat/$id');
      _channel = IOWebSocketChannel.connect(
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
      _subscription = _channel!.stream.listen(
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

    if (state.status != ChatConnectionStatus.connected || _channel == null) {
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

    emit(state.copyWith(messages: [...state.messages, outgoingMessage]));

    try {
      _channel!.sink.add(
        jsonEncode(<String, dynamic>{'message': message, 'name': 'You'}),
      );
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
    connect(id);
  }

  void _handleIncomingMessage(dynamic rawMessage) {
    try {
      final decodedMessage = jsonDecode(rawMessage) as Map<String, dynamic>;

      final incomingMessage = ChatMessage(
        name: "",
        message: decodedMessage['message'] ?? '',
        isMe: false,
        timeLabel: _currentTimeLabel(),
      );

      if (int.tryParse(decodedMessage['sender_id']) == userId) {
        // if the sender id is same as the user id then it is a message from me and
        //we can ignore it because we already added it to the chat with optimistic update
        return;
      }

      emit(state.copyWith(messages: [...state.messages, incomingMessage]));
    } catch (error) {
      emit(
        state.copyWith(
          status: ChatConnectionStatus.error,
          errorMessage: 'Received an invalid chat message: $error',
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
  }

  void closeConnection() {
    _subscription?.cancel();
    _subscription = null;
    _channel?.sink.close();
    _channel = null;
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
