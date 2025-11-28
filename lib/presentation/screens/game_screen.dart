import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/game/game_bloc.dart';
import '../../application/game/game_event.dart';
import '../../application/game/game_state.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/entities.dart';
import '../widgets/game_board_widget.dart';
import '../widgets/game_result_dialog.dart';
import '../widgets/player_turn_indicator.dart';

/// Main game screen where the Tic Tac Toe game is played.
///
/// This screen:
/// - Provides the GameBloc via BlocProvider
/// - Displays the game board
/// - Shows the current player's turn
/// - Handles game over dialogs
class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GameBloc()..add(const GameStarted()),
      child: const _GameScreenContent(),
    );
  }
}

class _GameScreenContent extends StatelessWidget {
  const _GameScreenContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TIC TAC TOE',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        actions: [
          // Reset button
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _resetGame(context),
            tooltip: 'Réinitialiser',
          ),
        ],
      ),
      body: BlocConsumer<GameBloc, GameState>(
        listener: (context, state) {
          // Show dialog when game ends
          if (state is GameOver) {
            _showGameOverDialog(context, state.result);
          }
        },
        builder: (context, state) {
          return switch (state) {
            GameInitial() => const Center(
                child: CircularProgressIndicator(),
              ),
            GamePlaying(:final board, :final currentPlayer, :final moveCount) =>
              _buildGameContent(
                context,
                board: board,
                currentPlayer: currentPlayer,
                moveCount: moveCount,
              ),
            GameOver(:final board, :final result) => _buildGameContent(
                context,
                board: board,
                gameResult: result,
              ),
          };
        },
      ),
    );
  }

  Widget _buildGameContent(
    BuildContext context, {
    required GameBoard board,
    Player? currentPlayer,
    int moveCount = 0,
    GameResult? gameResult,
  }) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Player turn indicator (or game over message)
              if (gameResult == null && currentPlayer != null)
                PlayerTurnIndicator(currentPlayer: currentPlayer)
              else if (gameResult != null)
                _buildGameOverMessage(gameResult),

              const Spacer(),

              // Game board
              GameBoardWidget(board: board),

              const Spacer(),

              // Move counter
              Text(
                'Coup : $moveCount',
                style: TextStyle(
                  fontSize: 16,
                  color: AppTheme.textSecondary,
                ),
              ),
              const SizedBox(height: 16),

              // New game button
              TextButton.icon(
                onPressed: () => _resetGame(context),
                icon: const Icon(Icons.refresh),
                label: const Text('Nouvelle partie'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameOverMessage(GameResult result) {
    return switch (result) {
      GameWon(:final winner) => Text(
          'Joueur ${winner.symbol} gagne ! 🎉',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: winner == Player.x
                ? AppTheme.playerXColor
                : AppTheme.playerOColor,
          ),
        ),
      GameDraw() => const Text(
          'Match nul ! 🤝',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
      GameInProgress() => const SizedBox.shrink(),
    };
  }

  void _resetGame(BuildContext context) {
    context.read<GameBloc>().add(const GameReset());
  }

  void _showGameOverDialog(BuildContext context, GameResult result) {
    // Wait a bit before showing dialog for better UX
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!context.mounted) return;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => GameResultDialog(
          result: result,
          onNewGame: () {
            Navigator.of(context).pop();
            context.read<GameBloc>().add(const GameReset());
          },
          onExit: () {
            Navigator.of(context).pop(); // Close dialog
            Navigator.of(context).pop(); // Exit to home
          },
        ),
      );
    });
  }
}
