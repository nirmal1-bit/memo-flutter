import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:memo/features/matches/data/models/response/matches_response.dart';
import 'package:memo/features/matches/presentation/widgets/profile_card.dart';

class CardDeck extends StatelessWidget {
  const CardDeck({
    super.key,
    required this.profiles,
    required this.currentIndex,
    required this.dragOffset,
    required this.swipeThreshold,
    required this.onPanStart,
    required this.onPanUpdate,
    required this.onPanEnd,
    required this.emptyState,
  });

  final List<MatchesResponse> profiles;
  final int currentIndex;
  final Offset dragOffset;
  final double swipeThreshold;
  final GestureDragStartCallback onPanStart;
  final GestureDragUpdateCallback onPanUpdate;
  final GestureDragEndCallback onPanEnd;
  final Widget emptyState;

  @override
  Widget build(BuildContext context) {
    if (currentIndex >= profiles.length) {
      return emptyState;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardsToShow = math.min(3, profiles.length - currentIndex);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Stack(
            alignment: Alignment.center,
            children: List.generate(cardsToShow, (i) {
              final stackIndex = cardsToShow - 1 - i;
              final profile = profiles[currentIndex + stackIndex];
              final isTop = stackIndex == 0;
              return ProfileCard(
                profile: profile,
                stackIndex: stackIndex,
                isTop: isTop,
                constraints: constraints,
                dragOffset: dragOffset,
                swipeThreshold: swipeThreshold,
                onPanStart: onPanStart,
                onPanUpdate: onPanUpdate,
                onPanEnd: onPanEnd,
              );
            }),
          ),
        );
      },
    );
  }
}
