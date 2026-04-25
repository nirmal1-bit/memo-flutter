import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
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

class ChatState {
  const ChatState({
    this.messages = const [],
    this.status = ChatConnectionStatus.initial,
    this.errorMessage,
  });

  final List<ChatMessage> messages;
  final ChatConnectionStatus status;
  final String? errorMessage;

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

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({required this.connection, required this.sessionService})
    : super(const ChatState());

  final ConnectionResponse connection;
  final SessionService sessionService;

  IOWebSocketChannel? _channel;
  StreamSubscription? _subscription;
  bool _hasConnected = false;
  final Queue<String> _pendingOutgoingMessages = Queue<String>();

  Future<void> connect() async {
    if (_hasConnected || state.status == ChatConnectionStatus.connecting) {
      return;
    }

    emit(
      state.copyWith(
        status: ChatConnectionStatus.connecting,
        errorMessage: null,
      ),
    );

    try {
      final token = await sessionService.token;
      final uri = Uri.parse('ws://192.168.1.94:4000/v1/chat/${connection.id}');

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

    _pendingOutgoingMessages.addLast(message);
    emit(state.copyWith(messages: [...state.messages, outgoingMessage]));

    try {
      _channel!.sink.add(
        jsonEncode(<String, dynamic>{'message': message, 'name': 'You'}),
      );
    } catch (error) {
      _pendingOutgoingMessages.remove(message);
      _removeLastOptimisticMessage(message);
      emit(
        state.copyWith(
          status: ChatConnectionStatus.error,
          errorMessage: 'Failed to send message: $error',
        ),
      );
    }
  }

  void retry() {
    closeConnection();
    _hasConnected = false;
    connect();
  }

  void _handleIncomingMessage(dynamic rawMessage) {
    try {
      final decoded = _decodeIncoming(rawMessage);

      if (_shouldIgnoreEcho(decoded.message)) {
        return;
      }

      final incomingMessage = ChatMessage(
        name: decoded.name,
        message: decoded.message,
        isMe: false,
        timeLabel: _currentTimeLabel(),
      );

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
    _pendingOutgoingMessages.clear();
  }

  @override
  Future<void> close() {
    closeConnection();
    return super.close();
  }

  _DecodedMessage _decodeIncoming(dynamic rawMessage) {
    if (rawMessage is Map<String, dynamic>) {
      return _DecodedMessage.fromMap(rawMessage);
    }

    if (rawMessage is String) {
      final decoded = jsonDecode(rawMessage);
      if (decoded is Map<String, dynamic>) {
        return _DecodedMessage.fromMap(decoded);
      }

      return _DecodedMessage(name: 'Unknown', message: decoded.toString());
    }

    return _DecodedMessage(name: 'Unknown', message: rawMessage.toString());
  }

  bool _shouldIgnoreEcho(String incomingMessage) {
    final normalizedIncoming = incomingMessage.trim();
    if (_pendingOutgoingMessages.isEmpty || normalizedIncoming.isEmpty) {
      return false;
    }

    final pendingMessage = _pendingOutgoingMessages.first;
    if (pendingMessage.trim() != normalizedIncoming) {
      return false;
    }

    _pendingOutgoingMessages.removeFirst();
    return true;
  }

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

class _DecodedMessage {
  const _DecodedMessage({required this.name, required this.message});

  factory _DecodedMessage.fromMap(Map<String, dynamic> json) {
    return _DecodedMessage(
      name: json['name']?.toString().trim().isNotEmpty == true
          ? json['name'].toString()
          : 'Unknown',
      message: json['message']?.toString() ?? '',
    );
  }

  final String name;
  final String message;
}
