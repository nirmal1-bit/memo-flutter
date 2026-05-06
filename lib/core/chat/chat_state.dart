enum ChatConnectionStatus {
  initial,
  connecting,
  connected,
  disconnected,
  error,
  answering,
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

  ChatMessage copyWith({
    String? name,
    String? message,
    bool? isMe,
    String? timeLabel,
  }) {
    return ChatMessage(
      name: name ?? this.name,
      message: message ?? this.message,
      isMe: isMe ?? this.isMe,
      timeLabel: timeLabel ?? this.timeLabel,
    );
  }
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
