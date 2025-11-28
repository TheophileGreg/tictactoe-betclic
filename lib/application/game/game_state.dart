import 'package:equatable/equatable.dart';

import '../../domain/entities/entities.dart';

/// Base class for all game states.
///
/// States represent the current condition of the game and are emitted
/// by [GameBloc] in response to events.
sealed class GameState extends Equatable {
  const GameState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any game has started.
///
/// This is the state when the app first launches or when on the home screen.
final class GameInitial extends GameState {
  const GameInitial();
}

/// State when a game is actively being played.
///
/// Contains:
/// - [board]: Current state of the game board
/// - [currentPlayer]: Whose turn it is (X or O)
/// - [moveCount]: Number of moves made so far
///
/// Example:
/// ```dart
/// if (state is GamePlaying) {
///   print('Current player: ${state.currentPlayer.symbol}');
///   print('Board: ${state.board}');
/// }
/// ```
final class GamePlaying extends GameState {
  const GamePlaying({
    required this.board,
    required this.currentPlayer,
    required this.moveCount,
  });

  /// The current state of the game board.
  final GameBoard board;

  /// The player whose turn it is.
  final Player currentPlayer;

  /// The number of moves made in this game.
  final int moveCount;

  @override
  List<Object?> get props => [board, currentPlayer, moveCount];
}

/// State when the game has ended (win or draw).
///
/// Contains:
/// - [board]: Final state of the board
/// - [result]: The game result (won or draw)
///
/// Example:
/// ```dart
/// if (state is GameOver) {
///   switch (state.result) {
///     case GameWon(:final winner):
///       showWinDialog(winner);
///     case GameDraw():
///       showDrawDialog();
///   }
/// }
/// ```
final class GameOver extends GameState {
  const GameOver({
    required this.board,
    required this.result,
  });

  /// The final state of the game board.
  final GameBoard board;

  /// The result of the game (won or draw).
  final GameResult result;

  @override
  List<Object?> get props => [board, result];
}

