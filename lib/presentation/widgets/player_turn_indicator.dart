import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../domain/entities/entities.dart';

/// Widget that displays whose turn it is in the game.
///
/// Shows the current player's symbol with their color.
class PlayerTurnIndicator extends StatelessWidget {
  const PlayerTurnIndicator({
    required this.currentPlayer,
    super.key,
  });

  /// The player whose turn it currently is.
  final Player currentPlayer;

  @override
  Widget build(BuildContext context) {
    final color = currentPlayer == Player.x
        ? AppTheme.playerXColor
        : AppTheme.playerOColor;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Joueur',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              currentPlayer.symbol,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

