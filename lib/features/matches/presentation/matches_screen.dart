import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:memo/core/constants/app_colors.dart';
import 'package:memo/core/constants/app_text_styles.dart';
import 'match_card/match_card_data.dart';
import 'match_card/match_card_widget.dart';

class MatchesScreen extends StatefulWidget {
  const MatchesScreen({super.key});

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  // Stub list — replace with real data from your bloc/provider
  final List<MatchCardData> _cards = List.generate(
    5,
    (i) => MatchCardData(
      id: i + 1,
      name: [
        'Sophia Reeves',
        'Marcus Chen',
        'Aisha Patel',
        'Leo Torres',
        'Nina Wolff',
      ][i],
      email: 'user$i@example.com',
      role: [
        'Product Designer',
        'Fullstack Engineer',
        'Data Scientist',
        'Founder',
        'UX Researcher',
      ][i],
      activated: i % 2 == 0,
      headline: [
        'Building products that people love ✨',
        'Open source enthusiast & coffee addict ☕',
        'Turning data into decisions 📊',
        'Building the next big thing 🚀',
        'Obsessed with user delight 🎯',
      ][i],
      bio: 'Passionate professional looking to connect and collaborate.',
      avatarUrl: [
        'https://randomuser.me/api/portraits/women/44.jpg',
        'https://randomuser.me/api/portraits/men/32.jpg',
        'https://randomuser.me/api/portraits/women/68.jpg',
        'https://randomuser.me/api/portraits/men/75.jpg',
        'https://randomuser.me/api/portraits/women/90.jpg',
      ][i],
      profileUrl: '',
      website: 'example.com',
      location: [
        'San Francisco, CA',
        'New York, NY',
        'London, UK',
        'Austin, TX',
        'Berlin, DE',
      ][i],
      companyName: ['Figma', 'Vercel', 'Stripe', 'YC S24', 'Spotify'][i],
    ),
  );

  int _currentIndex = 0;

  void _onLike() {
    _showFeedback('Liked! 💚');
    _nextCard();
  }

  void _onDislike() {
    _showFeedback('Passed ✕');
    _nextCard();
  }

  void _onSuperLike() {
    _showFeedback('Super Liked! ⭐');
    _nextCard();
  }

  void _nextCard() {
    if (_currentIndex < _cards.length - 1) {
      setState(() => _currentIndex++);
    } else {
      setState(() => _currentIndex = _cards.length); // show empty state
    }
  }

  void _showFeedback(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: AppTextStyles.rubik.copyWith(
            color: AppColors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(milliseconds: 800),
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Column(
          children: [
            _MatchesAppBar(),
            Expanded(child: _buildCardArea()),
          ],
        ),
      ),
    );
  }

  Widget _buildCardArea() {
    if (_currentIndex >= _cards.length) {
      return _EmptyState(onReset: () => setState(() => _currentIndex = 0));
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        // Background card peek (next card)
        if (_currentIndex + 1 < _cards.length)
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 24, 28, 0),
            child: _PeekCard(data: _cards[_currentIndex + 1]),
          ),

        // Main card
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: MatchCardWidget(
            key: ValueKey(_currentIndex),
            data: _cards[_currentIndex],
            onLike: _onLike,
            onDislike: _onDislike,
            onSuperLike: _onSuperLike,
          ),
        ),
      ],
    );
  }
}

/// Dimmed behind-card so users feel there's more
class _PeekCard extends StatelessWidget {
  final MatchCardData data;
  const _PeekCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              AppColors.black.withOpacity(0.35),
              BlendMode.darken,
            ),
            child: Image.network(
              data.avatarUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) =>
                  Container(color: AppColors.brandBackground),
            ),
          ),
        ],
      ),
    );
  }
}

class _MatchesAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          Text(
            'Discover',
            style: AppTextStyles.rubik.copyWith(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1, end: 0),
          const Spacer(),
          _AppBarIconButton(
            icon: Icons.tune_rounded,
            onTap: () {},
          ).animate().fadeIn(delay: 150.ms, duration: 300.ms),
          const SizedBox(width: 10),
          _AppBarIconButton(
            icon: Icons.notifications_outlined,
            onTap: () {},
          ).animate().fadeIn(delay: 250.ms, duration: 300.ms),
        ],
      ),
    );
  }
}

class _AppBarIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _AppBarIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 20, color: AppColors.textDark),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final VoidCallback onReset;
  const _EmptyState({required this.onReset});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
                Icons.favorite_border_rounded,
                size: 72,
                color: AppColors.textLight,
              )
              .animate()
              .fadeIn(duration: 500.ms)
              .scale(begin: const Offset(0.5, 0.5)),
          const SizedBox(height: 20),
          Text(
            'No more profiles',
            style: AppTextStyles.rubik.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
          const SizedBox(height: 8),
          Text(
            'Check back later for new matches',
            style: AppTextStyles.rubik.copyWith(
              fontSize: 14,
              color: AppColors.textGrey,
            ),
          ).animate().fadeIn(delay: 300.ms, duration: 400.ms),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: onReset,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
            ),
            child: Text(
              'Restart',
              style: AppTextStyles.rubik.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ).animate().fadeIn(delay: 400.ms, duration: 400.ms),
        ],
      ),
    );
  }
}
