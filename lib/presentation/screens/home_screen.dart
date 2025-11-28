import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import 'game_screen.dart';

/// Home screen with game title and start button.
///
/// This is the entry screen of the app where users can start a new game.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App title
                const Text(
                  'TIC TAC TOE',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),

                // Subtitle
                Text(
                  'Jeu classique de X et O',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: 80),

                // Player icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _PlayerIcon(
                      symbol: 'X',
                      color: AppTheme.playerXColor,
                    ),
                    const SizedBox(width: 40),
                    _PlayerIcon(
                      symbol: 'O',
                      color: AppTheme.playerOColor,
                    ),
                  ],
                ),
                const SizedBox(height: 80),

                // Start button
                ElevatedButton(
                  onPressed: () => _startGame(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.playerXColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 48,
                      vertical: 20,
                    ),
                  ),
                  child: const Text(
                    'COMMENCER',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _startGame(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const GameScreen(),
      ),
    );
  }
}

/// Widget displaying a player symbol with decoration.
class _PlayerIcon extends StatelessWidget {
  const _PlayerIcon({
    required this.symbol,
    required this.color,
  });

  final String symbol;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color,
          width: 3,
        ),
      ),
      child: Center(
        child: Text(
          symbol,
          style: TextStyle(
            fontSize: 60,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }
}
