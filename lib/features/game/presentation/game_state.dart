enum GameConnectionStatus {
  initial,
  connecting,
  connected,
  disconnected,
  error,
}

enum GameEvent {
  partnerDisconnected,
  partnerAnswered,
  answersReadyToReveal,
  gameStarted,
  gameFinished,
  gameCanceled,
}

class GameState {
  const GameState({
    this.status = GameConnectionStatus.initial,
    this.event,
    this.errorMessage,
  });

  final GameConnectionStatus status;
  final GameEvent? event;
  final String? errorMessage;

  GameState copyWith({
    GameConnectionStatus? status,
    GameEvent? event,
    bool clearEvent = false,
    String? errorMessage,
    bool clearError = false,
  }) {
    return GameState(
      status: status ?? this.status,
      event: clearEvent ? null : (event ?? this.event),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
