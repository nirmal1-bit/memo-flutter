import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/di/injector.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/core/utils/app_utils.dart';
import 'package:memo/features/game/cubits/accept_game_session_cubit.dart';
import 'package:memo/features/game/cubits/get_game_session_cubit.dart';
import 'package:memo/features/game/cubits/reveal_game_session_cubit.dart';
import 'package:memo/features/game/cubits/submit_game_answer_cubit.dart';
import 'package:memo/features/game/data/think_alike_models.dart';
import 'package:memo/features/game/presentation/game_cubit.dart';
import 'package:memo/features/game/presentation/game_state.dart';
import 'package:memo/features/game/presentation/models/think_alike_game_state.dart';
import 'package:memo/features/game/presentation/widgets/confetti_overlay.dart';
import 'package:memo/features/game/presentation/widgets/think_alike_background.dart';
import 'package:memo/features/game/presentation/widgets/think_alike_header.dart';
import 'package:memo/features/game/presentation/widgets/think_alike_state_content.dart';
import 'package:memo/features/home/data/models/response/user_profile_response.dart';

class ThinkAlikeScreenPatner extends StatefulWidget {
  const ThinkAlikeScreenPatner({super.key, required this.params});

  final ThinkAlikePartnerArgs params;

  @override
  State<ThinkAlikeScreenPatner> createState() => _ThinkAlikeScreenPatnerState();
}

class _ThinkAlikeScreenPatnerState extends State<ThinkAlikeScreenPatner> {
  ThinkAlikeSession? _session;
  bool _requestFailed = false;
  ThinkAlikeGameState _gameState = ThinkAlikeGameState.waitingForAcceptance;
  final _answerController = TextEditingController();
  bool _myAnswerSubmitted = false;
  bool _partnerAnswerSubmitted = false;
  bool _showConfetti = false;

  String get _question => _session?.question?.question ?? '';
  String get _myName => 'You';
  String? get _myProfileUrl => null;
  String get _initiatorAnswer => _session?.initiatorAnswer ?? '';
  String get _partnerAnswer => _session?.partnerAnswer ?? '';
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  void _loadSession(BuildContext context) {
    context.read<GetGameSessionCubit>().getSession(widget.params.sessionId);
  }

  void _acceptGame(BuildContext context) {
    HapticFeedback.mediumImpact();
    if (_session != null) {
      context.read<AcceptGameSessionCubit>().accept(_session!.id);
    }
  }

  void _submitAnswer(BuildContext context) {
    if (_answerController.text.trim().isEmpty || _session == null) return;
    HapticFeedback.lightImpact();
    setState(() => _myAnswerSubmitted = true);
    context.read<SubmitGameAnswerCubit>().submit(
      _session!.id,
      _answerController.text.trim(),
    );
  }

  void _reveal(BuildContext context) {
    HapticFeedback.heavyImpact();
    if (_session != null) {
      context.read<RevealGameSessionCubit>().reveal(_session!.id);
    }
  }

  void _onSessionStateChanged(
    BuildContext context,
    BaseApiState<ThinkAlikeSession> state,
  ) {
    state.maybeWhen(
      success: (session) {
        if (!mounted) return;
        setState(() {
          _session = session;
          _requestFailed = false;
          _gameState = _stateForStatus(session.status);

          // The current user is the partner in this flow.
          _myAnswerSubmitted =
              _myAnswerSubmitted || session.partnerAnswer != null;
          // Keep the event-driven state while the follow-up API request is in
          // flight. This prevents a stale response from hiding the update.
          _partnerAnswerSubmitted =
              _partnerAnswerSubmitted || session.initiatorAnswer != null;
          if (_myAnswerSubmitted &&
              _partnerAnswerSubmitted &&
              session.status == 'waiting_for_answers') {
            _gameState = ThinkAlikeGameState.readyToReveal;
          }
          _showConfetti = session.status == 'completed';
        });
        context.read<GameCubit>().connect(session.id);
      },
      error: (message) => _showSessionError(context, message),
      validationError: (error) => _showSessionError(context, error.message),
      noInternet: () => _showSessionError(context, 'No internet connection'),
      orElse: () {},
    );
  }

  ThinkAlikeGameState _stateForStatus(String status) => switch (status) {
    'waiting_for_acceptance' => ThinkAlikeGameState.waitingForAcceptance,
    'waiting_for_answers' => ThinkAlikeGameState.waitingForAnswers,
    'ready_to_reveal' => ThinkAlikeGameState.readyToReveal,
    'completed' => ThinkAlikeGameState.completed,
    _ => ThinkAlikeGameState.cancelled,
  };

  void _onGameStateChanged(BuildContext context, GameState state) {
    final event = state.event;
    if (event == null) return;

    if (event == GameEvent.gameCanceled) {
      if (mounted) setState(() => _gameState = ThinkAlikeGameState.cancelled);
      return;
    }

    if (event == GameEvent.partnerDisconnected) {
      AppUtils.showErrorSnackbar(
        context: context,
        message: 'Your partner disconnected from the game.',
      );
      return;
    }

    if (event == GameEvent.partnerAnswered) {
      if (mounted) {
        setState(() {
          // In this screen the partner is the initiator.
          _partnerAnswerSubmitted = true;
          if (_myAnswerSubmitted) {
            _gameState = ThinkAlikeGameState.readyToReveal;
          }
        });
      }
    } else if (event == GameEvent.answersReadyToReveal && mounted) {
      setState(() => _gameState = ThinkAlikeGameState.readyToReveal);
    }

    context.read<GetGameSessionCubit>().getSession(widget.params.sessionId);
  }

  void _showSessionError(BuildContext context, String message) {
    if (mounted) setState(() => _requestFailed = true);
    AppUtils.showErrorSnackbar(context: context, message: message);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              getIt<GetGameSessionCubit>()..getSession(widget.params.sessionId),
        ),
        BlocProvider(create: (_) => getIt<AcceptGameSessionCubit>()),
        BlocProvider(create: (_) => getIt<SubmitGameAnswerCubit>()),
        BlocProvider(create: (_) => getIt<RevealGameSessionCubit>()),
        BlocProvider(create: (_) => getIt<GameCubit>()),
      ],
      child: Builder(
        // All callbacks below must use a context under MultiBlocProvider.
        builder: (blocContext) => MultiBlocListener(
          listeners: [
            BlocListener<GetGameSessionCubit, BaseApiState<ThinkAlikeSession>>(
              listener: _onSessionStateChanged,
            ),
            BlocListener<
              AcceptGameSessionCubit,
              BaseApiState<ThinkAlikeSession>
            >(listener: _onSessionStateChanged),
            BlocListener<
              SubmitGameAnswerCubit,
              BaseApiState<ThinkAlikeSession>
            >(listener: _onSessionStateChanged),
            BlocListener<
              RevealGameSessionCubit,
              BaseApiState<ThinkAlikeSession>
            >(listener: _onSessionStateChanged),
            BlocListener<GameCubit, GameState>(listener: _onGameStateChanged),
          ],
          child: Scaffold(
            backgroundColor: AppColors.scaffoldBackground,
            body: Stack(
              children: [
                const ThinkAlikeBackground(),
                SafeArea(
                  child: Column(
                    children: [
                      ThinkAlikeHeader(gameState: _gameState),
                      Expanded(
                        child: ThinkAlikeStateContent(
                          session: _session,
                          gameState: _gameState,
                          requestFailed: _requestFailed,
                          sessionId: widget.params.sessionId,
                          initiatorName: widget.params.initiatorName,
                          partnerName: _myName,
                          question: _question,
                          initiatorAnswer: _initiatorAnswer,
                          partnerAnswer: _partnerAnswer,
                          answerController: _answerController,
                          myAnswerSubmitted: _myAnswerSubmitted,
                          partnerAnswerSubmitted: _partnerAnswerSubmitted,
                          userProfileUrl: widget.params.initiatorProfileUrl,
                          partnerProfileUrl: _myProfileUrl,
                          onRetry: () {
                            setState(() => _requestFailed = false);
                            _loadSession(blocContext);
                          },
                          onAccept: () => _acceptGame(blocContext),
                          onCancel: () => Navigator.of(blocContext).maybePop(),
                          onSubmitAnswer: () => _submitAnswer(blocContext),
                          onReveal: () => _reveal(blocContext),
                          onPlayAgain: () =>
                              Navigator.of(blocContext).maybePop(),
                          acceptLabel: 'Accept Game',
                          cancelLabel: 'Decline',
                          isFromPatner: true,
                        ),
                      ),
                    ],
                  ),
                ),
                if (_showConfetti) const ConfettiOverlay(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ThinkAlikePartnerArgs {
  const ThinkAlikePartnerArgs({
    required this.user,
    required this.sessionId,
    this.initiatorName = 'Your partner',
    required this.initiatorProfileUrl,
  });

  final Profile user;
  final int sessionId;
  final String initiatorName;
  final String initiatorProfileUrl;
}
