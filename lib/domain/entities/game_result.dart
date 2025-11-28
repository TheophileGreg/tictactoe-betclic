import 'package:equatable/equatable.dart';

import 'cell_position.dart';
import 'player.dart';

/// Represents the result state of a Tic Tac Toe game.
///
/// This is a sealed class hierarchy that allows exhaustive pattern matching
/// at compile time. There are three possible results:
///
/// - [GameInProgress]: The game is ongoing
/// - [GameDraw]: The game ended in a draw (board full, no winner)
/// - [GameWon]: A player has won (three in a row)
///
/// Example usage with pattern matching:
/// ```dart
/// final result = CheckWinnerUseCase()(board);
///
/// switch (result) {
///   case GameInProgress():
///     print('Game continues...');
///   case GameDraw():
///     print('It\'s a draw!');
///   case GameWon(:final winner, :final winningLine):
///     print('${winner.symbol} wins!');
///     highlightCells(winningLine);
/// }
/// ```
///
/// See also:
/// - [CheckWinnerUseCase], which determines the game result
sealed class GameResult extends Equatable {
  const GameResult();
}

/// The game is still in progress.
///
/// This state indicates that:
/// - No player has three in a row
/// - The board is not full yet (empty cells remain)
///
/// Example:
/// ```dart
/// if (result is GameInProgress) {
///   // Allow the next player to move
/// }
/// ```
final class GameInProgress extends GameResult {
  const GameInProgress();

  @override
  List<Object?> get props => [];
}

/// The game ended in a draw.
///
/// This state indicates that:
/// - The board is completely full (all 9 cells occupied)
/// - No player achieved three in a row
///
/// Example:
/// ```dart
/// if (result is GameDraw) {
///   showDrawDialog();
/// }
/// ```
final class GameDraw extends GameResult {
  const GameDraw();

  @override
  List<Object?> get props => [];
}

/// The game has a winner (three in a row achieved).
///
/// This state includes information about:
/// - [winner]: Which player won
/// - [winningLine]: The three positions that form the winning combination
///
/// The [winningLine] can be used to highlight or animate the winning cells
/// in the UI.
///
/// Example:
/// ```dart
/// if (result case GameWon(:final winner, :final winningLine)) {
///   print('${winner.symbol} wins!');
///   for (final position in winningLine) {
///     highlightCell(position);
///   }
/// }
/// ```
final class GameWon extends GameResult {
  /// Creates a game result representing a win.
  const GameWon({
    required this.winner,
    required this.winningLine,
  });

  /// The player who won the game.
  final Player winner;

  /// The three cell positions that form the winning line.
  ///
  /// This list always contains exactly 3 positions that form one of:
  /// - A horizontal line (row)
  /// - A vertical line (column)
  /// - A diagonal line (main or anti-diagonal)
  ///
  /// Useful for highlighting the winning combination in the UI with
  /// animations or visual effects.
  final List<CellPosition> winningLine;

  @override
  List<Object?> get props => [winner, winningLine];
}

