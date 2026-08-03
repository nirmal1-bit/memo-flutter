import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:memo/core/constants/api_endpoints.dart';
import 'package:memo/core/session/session_service.dart';
import 'package:web_socket_channel/io.dart';

import 'game_state.dart';

@injectable
class GameCubit extends Cubit<GameState> {
  GameCubit({required this.sessionService}) : super(const GameState());

  final SessionService sessionService;

  IOWebSocketChannel? _channel;
  StreamSubscription? _subscription;
  int? _sessionId;
  bool _hasConnected = false;

  void connect(int sessionId) async {
    if (_sessionId == sessionId &&
        (_hasConnected || state.status == GameConnectionStatus.connecting)) {
      return;
    }

    await _disconnectSocket();
    _sessionId = sessionId;
    emit(
      state.copyWith(
        status: GameConnectionStatus.connecting,
        clearEvent: true,
        clearError: true,
      ),
    );

    try {
      final token = await sessionService.token;
      final uri = Uri.parse(
        'ws://10.170.41.138:4000/v1${ApiEndpoints.thinkAlikeWebsocket(sessionId)}',
      );
      _channel = IOWebSocketChannel.connect(
        uri,
        headers: {'Authorization': 'Bearer $token'},
      );
      _hasConnected = true;
      emit(
        state.copyWith(
          status: GameConnectionStatus.connected,
          clearError: true,
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
          status: GameConnectionStatus.error,
          errorMessage: 'Could not connect to game: $error',
        ),
      );
    }
  }

  void retry() {
    final sessionId = _sessionId;
    if (sessionId != null) connect(sessionId);
  }

  void _handleIncomingMessage(dynamic rawMessage) {
    final event = _eventFromMessage(rawMessage.toString());
    if (event == null || isClosed) return;
    emit(state.copyWith(event: event, clearError: true));
  }

  GameEvent? _eventFromMessage(String message) {
    var eventName = message.trim();
    try {
      final decoded = jsonDecode(eventName);
      if (decoded is String) {
        // json.Marshal("partner_answered") produces a quoted JSON string.
        eventName = decoded;
      } else if (decoded is Map<String, dynamic>) {
        eventName =
            (decoded['event'] ??
                    decoded['type'] ??
                    decoded['action'] ??
                    decoded['name'] ??
                    decoded['message'] ??
                    '')
                .toString();
      }
    } catch (_) {
      // Plain-text WebSocket events are supported below.
    }

    return switch (eventName) {
      'partner_disconnected' => GameEvent.partnerDisconnected,
      'partner_answered' ||
      'answer_submitted' ||
      'partner_answer_submitted' => GameEvent.partnerAnswered,
      'answer_ready' ||
      'answers_ready' ||
      'both_answers_submitted' ||
      'ready_to_reveal' => GameEvent.answersReadyToReveal,
      'game_started' => GameEvent.gameStarted,
      'game_finished' => GameEvent.gameFinished,
      'game_canceled' => GameEvent.gameCanceled,
      _ => null,
    };
  }

  void _handleError(Object error) {
    _hasConnected = false;
    if (!isClosed) {
      emit(
        state.copyWith(
          status: GameConnectionStatus.error,
          errorMessage: 'Game connection error: $error',
        ),
      );
    }
  }

  void _handleDone() {
    _hasConnected = false;
    if (!isClosed) {
      emit(
        state.copyWith(
          status: GameConnectionStatus.disconnected,
          errorMessage: 'Game connection closed.',
        ),
      );
    }
  }

  Future<void> _disconnectSocket() async {
    _hasConnected = false;
    await _subscription?.cancel();
    _subscription = null;
    await _channel?.sink.close();
    _channel = null;
  }

  Future<void> closeConnection() => _disconnectSocket();

  @override
  Future<void> close() async {
    await _disconnectSocket();
    return super.close();
  }
}
