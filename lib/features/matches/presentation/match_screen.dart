import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/di/injector.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/core/utils/app_utils.dart';
import 'package:memo/features/common/shimmer.dart';
import 'package:memo/features/matches/cubits/get_matches_cubit.dart';
import 'package:memo/features/matches/data/models/response/matches_response.dart';
import 'package:memo/features/matches/presentation/widgets/card_deck.dart';
import 'package:memo/features/matches/presentation/widgets/match_action_bar.dart';
import 'package:memo/features/matches/presentation/widgets/match_empty_state.dart';
import 'package:memo/features/matches/presentation/widgets/match_header.dart';
import 'package:memo/features/network/presentation/cubits/connection_action_cubit.dart';

enum _SwipeAction { like, nope }

class MatchScreen extends StatefulWidget {
  const MatchScreen({super.key});

  @override
  State<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;

  Offset _dragOffset = Offset.zero;
  bool _isDragging = false;

  late final AnimationController _swipeController;
  Animation<Offset>? _swipeAnimation;
  _SwipeAction? _pendingAction;

  bool _showMatchOverlay = false;

  static const double _swipeThreshold = 100;

  @override
  void initState() {
    super.initState();
    _swipeController =
        AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 320),
          )
          ..addListener(() {
            final animation = _swipeAnimation;
            if (animation != null) {
              setState(() => _dragOffset = animation.value);
            }
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              final action = _pendingAction;
              _pendingAction = null;
              if (action != null) {
                _onSwipeComplete(action);
              }
            }
          });
  }

  @override
  void dispose() {
    _swipeController.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------
  // Gesture handling
  // ---------------------------------------------------------------------
  void _onPanStart(DragStartDetails details) {
    setState(() => _isDragging = true);
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() => _dragOffset += details.delta);
  }

  void _animateReset() {
    _pendingAction = null;
    _swipeAnimation = Tween<Offset>(begin: _dragOffset, end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _swipeController, curve: Curves.elasticOut),
        );
    _swipeController.forward(from: 0);
  }

  void _onSwipeComplete(_SwipeAction action) {
    setState(() {
      _currentIndex++; // advance past the swiped card
      _dragOffset = Offset.zero;
      _showMatchOverlay = action == _SwipeAction.like;
    });
  }

  void _rewind() {
    if (_currentIndex == 0) return;
    _swipeController.reset(); // clear any in-flight animation
    setState(() {
      _currentIndex--;
      _dragOffset = Offset.zero;
      _showMatchOverlay = false;
    });
  }

  void _resetDeck() {
    setState(() {
      _currentIndex = 0;
      _dragOffset = Offset.zero;
      _showMatchOverlay = false;
    });
  }

  // ---------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => getIt<GetMatchesCubit>()..getMatches(),
            ),
            BlocProvider(create: (_) => getIt<ConnectionActionCubit>()),
          ],
          child: MultiBlocListener(
            listeners: [
              BlocListener<ConnectionActionCubit, BaseApiState<String>>(
                listener: (context, state) {
                  state.maybeWhen(
                    success: (message) {
                      AppUtils.showSuccessSnackbar(
                        context: context,
                        message: message,
                      );
                    },
                    error: (message) {
                      AppUtils.showErrorSnackbar(
                        context: context,
                        message: message,
                      );
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
            child:
                BlocBuilder<
                  GetMatchesCubit,
                  BaseApiState<List<MatchesResponse>>
                >(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () => const SizedBox.shrink(),
                      loading: () => Center(
                        child: SizedBox(
                          height: 600,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: DatingProfileShimmer(),
                          ),
                        ),
                      ),
                      success: (data) {
                        void animateSwipe(_SwipeAction action) {
                          if (_SwipeAction.like == action) {
                            context
                                .read<ConnectionActionCubit>()
                                .sendConnectionRequest(
                                  _currentIndex < data.length
                                      ? data[_currentIndex].userId
                                      : 0,
                                );
                          }

                          final size = MediaQuery.of(context).size;
                          double endX = _dragOffset.dx;
                          double endY = _dragOffset.dy;

                          switch (action) {
                            case _SwipeAction.like:
                              endX = size.width * 1.4;
                              break;
                            case _SwipeAction.nope:
                              endX = -size.width * 1.4;
                              break;
                          }

                          _pendingAction = action;
                          _swipeAnimation =
                              Tween<Offset>(
                                begin: _dragOffset,
                                end: Offset(endX, endY),
                              ).animate(
                                CurvedAnimation(
                                  parent: _swipeController,
                                  curve: Curves.easeInCubic,
                                ),
                              );
                          _swipeController.forward(from: 0);
                        }

                        void onPanEnd(DragEndDetails details) {
                          setState(() => _isDragging = false);
                          if (_dragOffset.dx.abs() > _swipeThreshold) {
                            animateSwipe(
                              _dragOffset.dx > 0
                                  ? _SwipeAction.like
                                  : _SwipeAction.nope,
                            );
                          } else {
                            _animateReset();
                          }
                        }

                        return Stack(
                          children: [
                            Column(
                              children: [
                                const MatchHeader(),
                                Expanded(
                                  child: CardDeck(
                                    profiles: data,
                                    currentIndex: _currentIndex,
                                    dragOffset: _dragOffset,
                                    swipeThreshold: _swipeThreshold,
                                    onPanStart: _onPanStart,
                                    onPanUpdate: _onPanUpdate,
                                    onPanEnd: onPanEnd,
                                    emptyState: MatchEmptyState(
                                      onRefresh: _resetDeck,
                                    ),
                                  ),
                                ),

                                MatchActionBar(
                                  onRewind: _rewind,
                                  onNope: () => animateSwipe(_SwipeAction.nope),
                                  onLike: () => animateSwipe(_SwipeAction.like),
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
          ),
        ),
      ),
    );
  }
}
