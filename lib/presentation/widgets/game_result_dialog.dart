import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../domain/entities/entities.dart';

/// Dialog shown when the game ends (win or draw).
///
/// Displays:
/// - Winner announcement or draw message
/// - Options to start a new game or exit
class GameResultDialog extends StatelessWidget {
  const GameResultDialog({
    required this.result,
    required this.onNewGame,
    required this.onExit,
    super.key,
  });

  /// The game result to display.
  final GameResult result;

  /// Callback when user wants to play again.
  final VoidCallback onNewGame;

  /// Callback when user wants to exit to home.
  final VoidCallback onExit;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Result icon
            _buildResultIcon(),
            const SizedBox(height: 24),

            // Result message
            _buildResultMessage(),
            const SizedBox(height: 32),

              // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Exit button
                TextButton(
                  onPressed: onExit,
                  child: const Text('Quitter'),
                ),

                // New game button
                ElevatedButton(
                  onPressed: onNewGame,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.playerXColor,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Rejouer'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultIcon() {
    return switch (result) {
      GameWon(:final winner) => Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: (winner == Player.x
                    ? AppTheme.playerXColor
                    : AppTheme.playerOColor)
                .withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.emoji_events,
            size: 48,
            color: winner == Player.x
                ? AppTheme.playerXColor
                : AppTheme.playerOColor,
          ),
        ),
      GameDraw() => Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppTheme.textSecondary.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.handshake,
            size: 48,
            color: AppTheme.textSecondary,
          ),
        ),
      GameInProgress() => const SizedBox.shrink(),
    };
  }

  Widget _buildResultMessage() {
    return switch (result) {
      GameWon(:final winner) => Column(
          children: [
            const Text(
              'Victoire !',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Joueur ${winner.symbol}',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: winner == Player.x
                    ? AppTheme.playerXColor
                    : AppTheme.playerOColor,
              ),
            ),
          ],
        ),
      GameDraw() => const Column(
          children: [
            Text(
              'Match nul !',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Bien joué !',
              style: TextStyle(
                fontSize: 18,
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      GameInProgress() => const SizedBox.shrink(),
    };
  }
}

