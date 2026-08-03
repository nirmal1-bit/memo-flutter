import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/di/injector.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/core/utils/app_utils.dart';
import 'package:memo/features/game/cubits/accept_game_session_cubit.dart';
import 'package:memo/features/game/cubits/cancel_game_session_cubit.dart';
import 'package:memo/features/game/cubits/create_game_session_cubit.dart';
import 'package:memo/features/game/cubits/get_game_questions_cubit.dart';
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
import 'package:memo/features/home/data/models/response/connection_response.dart';
import 'package:memo/features/home/data/models/response/user_profile_response.dart';

class ThinkAlikeScreen extends StatefulWidget {
  const ThinkAlikeScreen({
    super.key,
    required this.user,
    required this.partner,
    this.sessionId,
    required this.isFromNotification,
    this.gameSessionId = 0,
  });

  final Profile user;
  final UserProfile partner;
  final int? sessionId;
  final bool isFromNotification;
  final int gameSessionId;

  @override
  State<ThinkAlikeScreen> createState() => _ThinkAlikeScreenState();
}

class _ThinkAlikeScreenState extends State<ThinkAlikeScreen>
    with TickerProviderStateMixin {
  ThinkAlikeSession? _session;
  bool _requestFailed = false;
  ThinkAlikeGameState _gameState = ThinkAlikeGameState.waitingForAcceptance;
  final _answerController = TextEditingController();
  bool _myAnswerSubmitted = false;
  bool _partnerAnswerSubmitted = false;
  bool _showConfetti = false;
  int _waitDots = 0;
  Timer? _waitTimer;

  late final AnimationController _headerSlideController;
  late final Animation<Offset> _headerSlideAnimation;
  late final AnimationController _bgPulseController;
  late final Animation<double> _bgPulseAnimation;

  String get _question => _session?.question?.question ?? '';
  String get _initiatorName => widget.user.name ?? 'You';
  String get _partnerName => widget.partner.name;
  String? get _userProfileUrl =>
      widget.user.avatarUrl ?? widget.user.profileUrl;
  String? get _partnerProfileUrl => widget.partner.profileUrl;
  String get _initiatorAnswer => _session?.initiatorAnswer ?? '';
  String get _partnerAnswer => _session?.partnerAnswer ?? '';
  List<String> get _matchingWords {
    Set<String> words(String answer) => answer
        .toLowerCase()
        .split(RegExp(r'\s+'))
        .map((word) => word.replaceAll(RegExp(r'[^a-z0-9]'), ''))
        .where((word) => word.length > 2)
        .toSet();
    return words(_initiatorAnswer).intersection(words(_partnerAnswer)).toList();
  }

  @override
  void initState() {
    super.initState();
    _headerSlideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _headerSlideAnimation =
        Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _headerSlideController,
            curve: Curves.easeOutCubic,
          ),
        );
    _bgPulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);
    _bgPulseAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _bgPulseController, curve: Curves.easeInOut),
    );
    _headerSlideController.forward();
    _waitTimer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      if (mounted) setState(() => _waitDots = (_waitDots + 1) % 4);
    });
  }

  @override
  void dispose() {
    _answerController.dispose();
    _headerSlideController.dispose();
    _bgPulseController.dispose();
    _waitTimer?.cancel();
    super.dispose();
  }

  void _onPartnerAccepted(BuildContext context) {
    HapticFeedback.mediumImpact();
    if (_session != null) {
      context.read<AcceptGameSessionCubit>().accept(_session!.id);
    }
  }

  void _onSubmitAnswer(BuildContext context) {
    if (_answerController.text.trim().isEmpty) return;
    HapticFeedback.lightImpact();
    setState(() => _myAnswerSubmitted = true);
    if (_session != null) {
      context.read<SubmitGameAnswerCubit>().submit(
        _session!.id,
        _answerController.text.trim(),
      );
    }
  }

  void _onReveal(BuildContext context) {
    HapticFeedback.heavyImpact();
    if (_session != null) {
      context.read<RevealGameSessionCubit>().reveal(_session!.id);
    }
  }

  void _onCancel(BuildContext context) {
    HapticFeedback.lightImpact();
    if (_session != null) {
      context.read<CancelGameSessionCubit>().cancel(_session!.id);
    }
    setState(() => _gameState = ThinkAlikeGameState.cancelled);
  }

  void _onApiStateChanged(
    BuildContext context,
    BaseApiState<ThinkAlikeSession> state,
  ) {
    state.maybeWhen(
      success: (session) {
        if (!mounted) return;
        setState(() {
          _session = session;
          _requestFailed = false;
          _gameState = switch (session.status) {
            'waiting_for_acceptance' =>
              ThinkAlikeGameState.waitingForAcceptance,
            'waiting_for_answers' => ThinkAlikeGameState.waitingForAnswers,
            'ready_to_reveal' => ThinkAlikeGameState.readyToReveal,
            'completed' => ThinkAlikeGameState.completed,
            _ => ThinkAlikeGameState.cancelled,
          };
          _myAnswerSubmitted =
              _myAnswerSubmitted || session.initiatorAnswer != null;
          // The API intentionally masks the partner answer while waiting for
          // the reveal. Keep the WebSocket notification as the source of truth
          // for the partner's submitted state.
          _partnerAnswerSubmitted =
              _partnerAnswerSubmitted || session.partnerAnswer != null;
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

  void _onGameStateChanged(BuildContext context, GameState state) {
    final event = state.event;
    if (event == null) return;

    if (event == GameEvent.gameCanceled) {
      if (mounted) setState(() => _gameState = ThinkAlikeGameState.cancelled);
      return;
    }

    if (event == GameEvent.partnerDisconnected) {
      _showError(context, 'Your partner disconnected from the game.');
      return;
    }

    if (event == GameEvent.partnerAnswered) {
      if (mounted) {
        setState(() {
          _partnerAnswerSubmitted = true;
          if (_myAnswerSubmitted) {
            _gameState = ThinkAlikeGameState.readyToReveal;
          }
        });
      }
    } else if (event == GameEvent.answersReadyToReveal && mounted) {
      setState(() => _gameState = ThinkAlikeGameState.readyToReveal);
    }

    final sessionId = _session?.id;
    if (sessionId != null) {
      context.read<GetGameSessionCubit>().getSession(sessionId);
    }
  }

  void _showError(BuildContext context, String message) =>
      AppUtils.showErrorSnackbar(context: context, message: message);

  void _showSessionError(BuildContext context, String message) {
    if (mounted) setState(() => _requestFailed = true);
    _showError(context, message);
  }

  void _onPlayAgain(BuildContext context) {
    context.read<GetGameQuestionsCubit>().getQuestion();
    HapticFeedback.mediumImpact();
    _answerController.clear();
    setState(() {
      _gameState = ThinkAlikeGameState.waitingForAcceptance;
      _myAnswerSubmitted = false;
      _partnerAnswerSubmitted = false;
      _showConfetti = false;
    });
  }

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => getIt<GetGameQuestionsCubit>()..getQuestion(),
      ),
      BlocProvider(create: (_) => getIt<GetGameSessionCubit>()),
      BlocProvider(create: (_) => getIt<CreateGameSessionCubit>()),
      BlocProvider(create: (_) => getIt<AcceptGameSessionCubit>()),
      BlocProvider(create: (_) => getIt<SubmitGameAnswerCubit>()),
      BlocProvider(create: (_) => getIt<RevealGameSessionCubit>()),
      BlocProvider(create: (_) => getIt<CancelGameSessionCubit>()),
      BlocProvider(create: (_) => getIt<GameCubit>()),
    ],
    child: MultiBlocListener(
      listeners: [
        BlocListener<GetGameSessionCubit, BaseApiState<ThinkAlikeSession>>(
          listener: _onApiStateChanged,
        ),
        BlocListener<CreateGameSessionCubit, BaseApiState<ThinkAlikeSession>>(
          listener: _onApiStateChanged,
        ),
        BlocListener<GetGameQuestionsCubit, BaseApiState<ThinkAlikeQuestion>>(
          listener: (context, state) {
            state.maybeWhen(
              success: (question) =>
                  context.read<CreateGameSessionCubit>().createSession(
                    questionId: question.id,
                    partnerId: widget.partner.userId,
                  ),
              error: (message) => _showError(context, message),
              validationError: (error) => _showError(context, error.message),
              noInternet: () => _showError(context, 'No internet connection'),
              orElse: () {},
            );
          },
        ),
        BlocListener<AcceptGameSessionCubit, BaseApiState<ThinkAlikeSession>>(
          listener: _onApiStateChanged,
        ),
        BlocListener<SubmitGameAnswerCubit, BaseApiState<ThinkAlikeSession>>(
          listener: _onApiStateChanged,
        ),
        BlocListener<RevealGameSessionCubit, BaseApiState<ThinkAlikeSession>>(
          listener: _onApiStateChanged,
        ),
        BlocListener<CancelGameSessionCubit, BaseApiState<String>>(
          listener: (context, state) {
            state.maybeWhen(
              success: (_) {
                if (mounted) {
                  setState(() => _gameState = ThinkAlikeGameState.cancelled);
                }
              },
              error: (message) => _showError(context, message),
              validationError: (error) => _showError(context, error.message),
              noInternet: () => _showError(context, 'No internet connection'),
              orElse: () {},
            );
          },
        ),
        BlocListener<GameCubit, GameState>(listener: _onGameStateChanged),
      ],
      child: BlocBuilder<GetGameSessionCubit, BaseApiState<ThinkAlikeSession>>(
        builder: (context, state) => Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          body: Stack(
            children: [
              ThinkAlikeBackground(animation: _bgPulseAnimation),
              SafeArea(
                child: Column(
                  children: [
                    ThinkAlikeHeader(
                      slideAnimation: _headerSlideAnimation,
                      gameState: _gameState,
                    ),
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        switchInCurve: Curves.easeOutCubic,
                        switchOutCurve: Curves.easeInCubic,
                        transitionBuilder: (child, animation) => FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, 0.05),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        ),
                        child: ThinkAlikeStateContent(
                          session: _session,
                          gameState: _gameState,
                          requestFailed: _requestFailed,
                          sessionId: widget.sessionId,
                          initiatorName: _initiatorName,
                          partnerName: _partnerName,
                          question: _question,
                          initiatorAnswer: _initiatorAnswer,
                          partnerAnswer: _partnerAnswer,
                          matchingWords: _matchingWords,
                          waitDots: _waitDots,
                          answerController: _answerController,
                          myAnswerSubmitted: _myAnswerSubmitted,
                          partnerAnswerSubmitted: _partnerAnswerSubmitted,
                          userProfileUrl: _userProfileUrl,
                          partnerProfileUrl: _partnerProfileUrl,
                          pulseAnimation: _bgPulseAnimation,
                          onRetry: () {
                            setState(() => _requestFailed = false);
                            if (widget.sessionId != null) {
                              context.read<GetGameSessionCubit>().getSession(
                                widget.sessionId!,
                              );
                            }
                          },
                          onAccept: () => _onPartnerAccepted(context),
                          onCancel: () => _onCancel(context),
                          onSubmitAnswer: () => _onSubmitAnswer(context),
                          onReveal: () => _onReveal(context),
                          onPlayAgain: () {
                            _onPlayAgain(context);
                          },
                        ),
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
