// ignore_for_file: deprecated_member_use

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/di/injector.dart';
import 'package:memo/core/state/base_api_state.dart';
import 'package:memo/core/theme/app_text_styles.dart';
import 'package:memo/features/common/shimmer.dart';
import 'package:memo/features/matches/cubits/get_matches_cubit.dart';
import 'package:memo/features/matches/data/models/response/matches_response.dart';

enum _SwipeAction { like, nope, superLike }

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

  void _onPanEnd(DragEndDetails details) {
    setState(() => _isDragging = false);
    if (_dragOffset.dx.abs() > _swipeThreshold) {
      _animateSwipe(_dragOffset.dx > 0 ? _SwipeAction.like : _SwipeAction.nope);
    } else {
      _animateReset();
    }
  }

  void _animateSwipe(_SwipeAction action) {
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
      case _SwipeAction.superLike:
        endY = -size.height * 1.2;
        break;
    }

    _pendingAction = action;
    _swipeAnimation = Tween<Offset>(begin: _dragOffset, end: Offset(endX, endY))
        .animate(
          CurvedAnimation(parent: _swipeController, curve: Curves.easeInCubic),
        );
    _swipeController.forward(from: 0);
  }

  void _animateReset() {
    _pendingAction = null;
    _swipeAnimation = Tween<Offset>(begin: _dragOffset, end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _swipeController, curve: Curves.elasticOut),
        );
    _swipeController.forward(from: 0);
  }

  void _onSwipeComplete(_SwipeAction action) {}

  void _rewind() {
    if (_currentIndex == 0) return;
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
          ],
          child:
              BlocBuilder<GetMatchesCubit, BaseApiState<List<MatchesResponse>>>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () => SizedBox.shrink(),
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
                      return Stack(
                        children: [
                          Column(
                            children: [
                              _buildHeader(),
                              Expanded(child: _buildCardDeck(data)),
                              _buildActionBar(),
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
    );
  }

  Widget _buildHeader() {
    return Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: AppColors.appBarGradient,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.favorite,
                      color: AppColors.white,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Matches',
                    style: AppTextStyles.libre.copyWith(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.card,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadow,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: const Icon(Icons.tune, color: AppColors.primary),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 400.ms)
        .slideY(begin: -0.3, end: 0, curve: Curves.easeOut);
  }

  Widget _buildCardDeck(List<MatchesResponse> profiles) {
    if (_currentIndex >= profiles.length) {
      return _buildEmptyState();
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardsToShow = math.min(3, profiles.length - _currentIndex);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Stack(
            alignment: Alignment.center,
            children: List.generate(cardsToShow, (i) {
              final stackIndex = cardsToShow - 1 - i;
              final profile = profiles[_currentIndex + stackIndex];
              final isTop = stackIndex == 0;
              return _buildCard(profile, stackIndex, isTop, constraints);
            }),
          ),
        );
      },
    );
  }

  Widget _buildCard(
    MatchesResponse profile,
    int stackIndex,
    bool isTop,
    BoxConstraints constraints,
  ) {
    final scale = 1 - (stackIndex * 0.04);
    final verticalOffset = stackIndex * 14.0;
    final blur = (isTop && _isDragging) ? 28.0 : 18.0;
    final shadowOffsetY = (isTop && _isDragging) ? 16.0 : 10.0;

    final card = Container(
      width: constraints.maxWidth,
      height: constraints.maxHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: blur,
            offset: Offset(0, shadowOffsetY),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            profile.profileUrl,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return Container(
                color: AppColors.lightGrey,
                child: const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
              );
            },
            errorBuilder: (context, error, stack) => Container(
              color: AppColors.lightGrey,
              child: const Center(
                child: Icon(Icons.person, size: 80, color: AppColors.textLight),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.transparent,
                    AppColors.black.withOpacity(0.75),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        profile.name,
                        style: AppTextStyles.libre.copyWith(
                          color: AppColors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${profile.age}',
                        style: AppTextStyles.rubik.copyWith(
                          color: AppColors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.work_outline,
                        size: 14,
                        color: AppColors.white,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          profile.headline,
                          style: AppTextStyles.rubik.copyWith(
                            color: AppColors.lightWhite,
                            fontSize: 13,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: AppColors.white,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        profile.location,
                        style: AppTextStyles.rubik.copyWith(
                          color: AppColors.lightWhite,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    profile.bio,
                    style: AppTextStyles.rubik.copyWith(
                      color: AppColors.white,
                      fontSize: 13,
                      height: 1.35,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: profile.interests
                        .map((tag) => _buildTagChip(tag))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
          if (isTop) ..._buildSwipeStamps(),
        ],
      ),
    );

    if (!isTop) {
      return Transform.translate(
        offset: Offset(0, -verticalOffset),
        child: Transform.scale(scale: scale, child: card)
            .animate()
            .fadeIn(duration: 300.ms)
            .scale(begin: const Offset(0.95, 0.95)),
      );
    }

    final angle = _dragOffset.dx / 800;
    return Transform.translate(
      offset: _dragOffset,
      child: Transform.rotate(
        angle: angle,
        child: GestureDetector(
          onPanStart: _onPanStart,
          onPanUpdate: _onPanUpdate,
          onPanEnd: _onPanEnd,
          child: card,
        ),
      ),
    );
  }

  Widget _buildTagChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.18),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.white.withOpacity(0.4)),
      ),
      child: Text(
        label,
        style: AppTextStyles.rubik.copyWith(
          color: AppColors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  List<Widget> _buildSwipeStamps() {
    final likeOpacity = (_dragOffset.dx / _swipeThreshold).clamp(0.0, 1.0);
    final nopeOpacity = (-_dragOffset.dx / _swipeThreshold).clamp(0.0, 1.0);

    return [
      Positioned(
        top: 40,
        left: 24,
        child: Opacity(
          opacity: likeOpacity,
          child: Transform.rotate(
            angle: -0.35,
            child: _buildStampBadge('LIKE', AppColors.statusGreen),
          ),
        ),
      ),
      Positioned(
        top: 40,
        right: 24,
        child: Opacity(
          opacity: nopeOpacity,
          child: Transform.rotate(
            angle: 0.35,
            child: _buildStampBadge('NOPE', AppColors.statusRed),
          ),
        ),
      ),
    ];
  }

  Widget _buildStampBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 3),
        borderRadius: BorderRadius.circular(8),
        color: AppColors.white.withOpacity(0.85),
      ),
      child: Text(
        label,
        style: AppTextStyles.libre.copyWith(
          color: color,
          fontSize: 28,
          fontWeight: FontWeight.w800,
          letterSpacing: 2,
        ),
      ),
    );
  }

  Widget _buildActionBar() {
    return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _circleButton(
                icon: Icons.replay,
                color: AppColors.textGrey,
                size: 46,
                onTap: _rewind,
              ),
              _circleButton(
                icon: Icons.close,
                color: AppColors.statusRed,
                size: 60,
                onTap: () => _animateSwipe(_SwipeAction.nope),
              ),
              _circleButton(
                icon: Icons.star,
                color: AppColors.primary,
                size: 46,
                onTap: () => _animateSwipe(_SwipeAction.superLike),
              ),
              _circleButton(
                icon: Icons.favorite,
                color: AppColors.statusGreen,
                size: 60,
                onTap: () => _animateSwipe(_SwipeAction.like),
              ),
              _circleButton(
                icon: Icons.flash_on,
                color: AppColors.yellow,
                size: 46,
                onTap: () {},
              ),
            ],
          ),
        )
        .animate(delay: 200.ms)
        .fadeIn(duration: 400.ms)
        .slideY(begin: 0.4, end: 0, curve: Curves.easeOut);
  }

  Widget _circleButton({
    required IconData icon,
    required Color color,
    required double size,
    required VoidCallback onTap,
  }) {
    return Material(
      color: AppColors.card,
      shape: const CircleBorder(),
      elevation: 4,
      shadowColor: AppColors.shadow,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: size,
          height: size,
          child: Center(
            child: Icon(icon, color: color, size: size * 0.45),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
                Icons.explore_off_outlined,
                size: 72,
                color: AppColors.textLight,
              )
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .scale(
                begin: const Offset(1, 1),
                end: const Offset(1.08, 1.08),
                duration: 900.ms,
              ),
          const SizedBox(height: 16),
          Text(
            'No more profiles nearby',
            style: AppTextStyles.libre.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Check back later for new people',
            style: AppTextStyles.rubik.copyWith(
              fontSize: 14,
              color: AppColors.textGrey,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _resetDeck,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttonPrimary,
              foregroundColor: AppColors.white,
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: Text(
              'Refresh',
              style: AppTextStyles.rubik.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildMatchOverlay(MatchesResponse profile) {
    return Positioned.fill(
      child: Container(
        color: AppColors.black.withOpacity(0.75),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                      "IT'S A MATCH!",
                      style: AppTextStyles.libre.copyWith(
                        color: AppColors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.5,
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 400.ms)
                    .slideY(begin: -0.3, end: 0),
                const SizedBox(height: 8),
                Text(
                  'You and ${profile.name} liked each other',
                  style: AppTextStyles.rubik.copyWith(
                    color: AppColors.lightWhite,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ).animate(delay: 150.ms).fadeIn(duration: 400.ms),
                const SizedBox(height: 32),
                SizedBox(
                  height: 120,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: _matchAvatar('https://i.pravatar.cc/300?img=8')
                            .animate()
                            .slideX(
                              begin: -1,
                              end: 0,
                              duration: 500.ms,
                              curve: Curves.easeOutBack,
                            ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: _matchAvatar(profile.profileUrl)
                            .animate()
                            .slideX(
                              begin: 1,
                              end: 0,
                              duration: 500.ms,
                              curve: Curves.easeOutBack,
                            ),
                      ),
                      const Icon(
                            Icons.favorite,
                            color: AppColors.buttonPrimary,
                            size: 42,
                          )
                          .animate(onPlay: (c) => c.repeat(reverse: true))
                          .scale(
                            begin: const Offset(0.85, 0.85),
                            end: const Offset(1.15, 1.15),
                            duration: 700.ms,
                          ),
                    ],
                  ),
                ),
                const SizedBox(height: 36),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() => _showMatchOverlay = false);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Opening chat with ${profile.name}...'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonPrimary,
                      foregroundColor: AppColors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: Text(
                      'Send a Message',
                      style: AppTextStyles.rubik.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ).animate(delay: 300.ms).fadeIn().slideY(begin: 0.3, end: 0),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => setState(() => _showMatchOverlay = false),
                  child: Text(
                    'Keep Swiping',
                    style: AppTextStyles.rubik.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ).animate(delay: 400.ms).fadeIn(),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms);
  }

  Widget _matchAvatar(String url) {
    return Container(
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.white, width: 3),
        image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
      ),
    );
  }
}
