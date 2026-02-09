import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/flashcard.dart';
import '../providers/app_state.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;
  bool _showFront = true;

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOut),
    );
    _flipController.addListener(() {
      if (_flipAnimation.value >= 0.5 && _showFront) {
        setState(() => _showFront = false);
      } else if (_flipAnimation.value < 0.5 && !_showFront) {
        setState(() => _showFront = true);
      }
    });
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  void _toggleFlip(AppState state) {
    state.toggleFlip();
    if (state.isFlipped) {
      _flipController.forward();
    } else {
      _flipController.reverse();
    }
  }

  void _resetFlip(AppState state) {
    if (state.isFlipped) {
      state.toggleFlip();
    }
    _flipController.reset();
    _showFront = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.5, -1),
            end: Alignment(0.5, 1),
            colors: [
              Color(0xFF0a0a0f),
              Color(0xFF111127),
              Color(0xFF0d0d1a),
            ],
            stops: [0, 0.4, 1],
          ),
        ),
        child: Consumer<AppState>(
          builder: (context, state, _) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return SafeArea(
              child: Column(
                children: [
                  _buildHeader(state),
                  _buildViewToggle(state),
                  if (state.viewMode == ViewMode.explore) ...[
                    _buildCategoryChips(state),
                    Expanded(child: _buildCard(state)),
                    _buildControls(state),
                  ] else
                    Expanded(child: _buildSavedView(state)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ── Header ──
  Widget _buildHeader(AppState state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFFff6b6b), Color(0xFFffc857), Color(0xFF4ecdc4)],
                ).createShader(bounds),
                child: const Text(
                  'Film Craft Daily',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
              const Text(
                'SHARPEN YOUR CINEMATIC EYE',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF666666),
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                '${state.seenIds.length}/${state.allCards.length}',
                style: const TextStyle(fontSize: 11, color: Color(0xFF555555)),
              ),
              const SizedBox(width: 6),
              SizedBox(
                width: 60,
                height: 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: Stack(
                    children: [
                      Container(color: const Color(0xFF1a1a2e)),
                      FractionallySizedBox(
                        widthFactor: state.progress,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF4ecdc4), Color(0xFFff6b6b)],
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── View Toggle ──
  Widget _buildViewToggle(AppState state) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: const Color(0xFF12122a),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _viewToggleButton(
            label: '\u2726 Explore',
            isActive: state.viewMode == ViewMode.explore,
            onTap: () {
              _resetFlip(state);
              state.setViewMode(ViewMode.explore);
            },
          ),
          _viewToggleButton(
            label: '\u2661 Saved (${state.savedIds.length})',
            isActive: state.viewMode == ViewMode.saved,
            onTap: () {
              _resetFlip(state);
              state.setViewMode(ViewMode.saved);
            },
          ),
        ],
      ),
    );
  }

  Widget _viewToggleButton({
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: isActive
                ? const LinearGradient(
                    colors: [Color(0x33FF6B6B), Color(0x334ECDC4)],
                  )
                : null,
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isActive ? Colors.white : const Color(0xFF555555),
            ),
          ),
        ),
      ),
    );
  }

  // ── Category Chips ──
  Widget _buildCategoryChips(AppState state) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
        itemCount: AppTheme.categories.length,
        separatorBuilder: (_, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final cat = AppTheme.categories[index];
          final isActive = cat == state.activeCategory;
          final catColors = cat == 'All'
              ? const CategoryColors(
                  bg: Color(0x19888888),
                  border: Color(0xFF888888),
                  text: Color(0xFF888888),
                )
              : AppTheme.colorsForCategory(cat);

          return GestureDetector(
            onTap: () {
              _resetFlip(state);
              state.setCategory(cat);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: isActive ? catColors.bg : const Color(0x0AFFFFFF),
                border: Border.all(
                  width: 1.5,
                  color: isActive ? catColors.border : Colors.transparent,
                ),
              ),
              child: Text(
                cat,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isActive ? catColors.text : const Color(0xFF555555),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ── Card with 3D Flip ──
  Widget _buildCard(AppState state) {
    final card = state.currentCard;
    if (card == null) {
      return const Center(
        child: Text('No cards found', style: TextStyle(color: Color(0xFF555555))),
      );
    }

    final colors = AppTheme.colorsForCategory(card.cat);

    return GestureDetector(
      onTap: () => _toggleFlip(state),
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity == null) return;
        if (details.primaryVelocity! < -100) {
          _resetFlip(state);
          state.nextCard();
        } else if (details.primaryVelocity! > 100) {
          _resetFlip(state);
          state.previousCard();
        }
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
        child: AnimatedBuilder(
          animation: _flipAnimation,
          builder: (context, _) {
            final angle = _flipAnimation.value * pi;
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.0008)
                ..rotateY(angle),
              child: _showFront
                  ? _buildCardFront(card, colors, state)
                  : Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..rotateY(pi),
                      child: _buildCardBack(card, colors),
                    ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCardFront(Flashcard card, CategoryColors colors, AppState state) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(-1, -1),
          end: const Alignment(1, 1),
          colors: [colors.bg, const Color(0xFF0d0d1a)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.border.withValues(alpha: 0.13)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x66000000),
            blurRadius: 40,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category + card count
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${card.icon} ${card.cat}'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                    color: colors.text.withValues(alpha: 0.8),
                  ),
                ),
                Text(
                  '${state.currentIndex + 1}/${state.filteredCards.length}',
                  style: const TextStyle(fontSize: 11, color: Color(0xFF444444)),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Title
            Text(
              card.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 16),

            // Description
            Text(
              card.desc,
              style: const TextStyle(
                fontSize: 14,
                height: 1.7,
                color: Color(0xFFb0b0c8),
              ),
            ),
            const SizedBox(height: 20),

            // Featured In
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0x0AFFFFFF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'FEATURED IN',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                      color: Color(0xFF555555),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    card.film,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: colors.text,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Hint
            const Center(
              child: Text(
                'Tap to see your challenge \u2192',
                style: TextStyle(fontSize: 11, color: Color(0xFF444444)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardBack(Flashcard card, CategoryColors colors) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(-1, -1),
          end: const Alignment(1, 1),
          colors: [const Color(0xFF0d0d1a), colors.bg],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.border.withValues(alpha: 0.13)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x66000000),
            blurRadius: 40,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('\uD83C\uDFAC', style: TextStyle(fontSize: 40)),
          const SizedBox(height: 16),
          Text(
            'TRY THIS',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
              color: colors.text,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            card.tryThis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              height: 1.8,
              color: Color(0xFFd0d0e8),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Tap to flip back',
            style: TextStyle(fontSize: 11, color: Color(0xFF444444)),
          ),
        ],
      ),
    );
  }

  // ── Controls (←  ♡  →) ──
  Widget _buildControls(AppState state) {
    final card = state.currentCard;
    final isSaved = card != null && state.isCardSaved(card.id);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _circleButton(
            child: const Text('\u2190', style: TextStyle(fontSize: 20, color: Color(0xFF666666))),
            onTap: () {
              _resetFlip(state);
              state.previousCard();
            },
          ),
          const SizedBox(width: 16),
          _circleButton(
            child: Text(
              isSaved ? '\u2665' : '\u2661',
              style: TextStyle(
                fontSize: 22,
                color: isSaved ? const Color(0xFFff6b6b) : const Color(0xFF666666),
              ),
            ),
            borderColor: isSaved ? const Color(0xFFff6b6b) : const Color(0xFF222222),
            bgColor: isSaved ? const Color(0x26FF6B6B) : const Color(0x08FFFFFF),
            onTap: () => state.toggleSave(),
          ),
          const SizedBox(width: 16),
          _circleButton(
            child: const Text('\u2192', style: TextStyle(fontSize: 20, color: Color(0xFF666666))),
            onTap: () {
              _resetFlip(state);
              state.nextCard();
            },
          ),
        ],
      ),
    );
  }

  Widget _circleButton({
    required Widget child,
    required VoidCallback onTap,
    Color borderColor = const Color(0xFF222222),
    Color bgColor = const Color(0x08FFFFFF),
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: bgColor,
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Center(child: child),
      ),
    );
  }

  // ── Saved View ──
  Widget _buildSavedView(AppState state) {
    final savedCards = state.allCards
        .where((c) => state.savedIds.contains(c.id))
        .toList();

    if (savedCards.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('\u2661', style: TextStyle(fontSize: 48, color: Color(0xFF444444))),
            SizedBox(height: 12),
            Text(
              'No saved cards yet',
              style: TextStyle(fontSize: 15, color: Color(0xFF444444)),
            ),
            SizedBox(height: 4),
            Text(
              'Tap the heart while exploring to save cards here',
              style: TextStyle(fontSize: 12, color: Color(0xFF333333)),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
      itemCount: savedCards.length,
      separatorBuilder: (_, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final sc = savedCards[index];
        final c = AppTheme.colorsForCategory(sc.cat);

        return Container(
          padding: const EdgeInsets.fromLTRB(20, 18, 12, 18),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: const Alignment(-1, -1),
              end: const Alignment(1, 1),
              colors: [c.bg, const Color(0xFF0d0d1a)],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: c.border.withValues(alpha: 0.09)),
            boxShadow: const [
              BoxShadow(color: Color(0x4D000000), blurRadius: 20, offset: Offset(0, 4)),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${sc.icon} ${sc.cat}'.toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                        color: c.text.withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      sc.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      sc.desc,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        height: 1.6,
                        color: Color(0xFF888888),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      sc.film,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: c.text,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => state.toggleSaveById(sc.id),
                child: const Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text(
                    '\u2665',
                    style: TextStyle(fontSize: 18, color: Color(0xFFff6b6b)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
