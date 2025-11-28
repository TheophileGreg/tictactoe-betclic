import '../entities/entities.dart';

/// Use case for checking the game result (winner, draw, or in progress).
///
/// This use case analyzes the current board state to determine the game
/// outcome. It checks all possible winning combinations (3 rows, 3 columns,
/// 2 diagonals) and detects if a player has won, if the game is a draw,
/// or if it's still in progress.
///
/// The algorithm is optimized for a 3x3 board by using pre-defined winning
/// line indices, resulting in O(1) time complexity (8 lines × 3 cells = 24
/// cell checks maximum).
///
/// Example usage:
/// ```dart
/// final useCase = CheckWinnerUseCase();
/// final result = useCase(board);
///
/// switch (result) {
///   case GameInProgress():
///     print('Game continues, next player\'s turn');
///   case GameDraw():
///     print('Game over: Draw!');
///   case GameWon(:final winner, :final winningLine):
///     print('${winner.symbol} wins!');
///     highlightCells(winningLine);
/// }
/// ```
///
/// See also:
/// - [GameResult], the sealed class representing possible outcomes
/// - [PlayMoveUseCase], typically called before checking for a winner
class CheckWinnerUseCase {
  /// Creates a [CheckWinnerUseCase] instance.
  ///
  /// This use case has no dependencies and can be instantiated directly.
  const CheckWinnerUseCase();

  /// All possible winning line configurations on a 3x3 board.
  ///
  /// Each inner list contains 3 flat indices (0-8) representing a winning
  /// line. There are 8 total winning configurations:
  /// - 3 horizontal rows
  /// - 3 vertical columns
  /// - 2 diagonals
  ///
  /// Visual representation:
  /// ```
  /// 0 | 1 | 2     Row 0: [0,1,2]    Col 0: [0,3,6]    Diag: [0,4,8]
  /// --+---+--     Row 1: [3,4,5]    Col 1: [1,4,7]    Anti: [2,4,6]
  /// 3 | 4 | 5     Row 2: [6,7,8]    Col 2: [2,5,8]
  /// --+---+--
  /// 6 | 7 | 8
  /// ```
  static const List<List<int>> _winningLines = [
    // Rows (horizontal)
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    // Columns (vertical)
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    // Diagonals
    [0, 4, 8], // main diagonal (top-left to bottom-right)
    [2, 4, 6], // anti-diagonal (top-right to bottom-left)
  ];

  /// Analyzes [board] and returns the current game result.
  ///
  /// The method checks all 8 possible winning lines. If any line contains
  /// three cells owned by the same player, that player wins. If no winner
  /// is found and the board is full, the game is a draw. Otherwise, the
  /// game continues.
  ///
  /// Returns:
  /// - [GameWon] if a player has three in a row (includes winner and winning line)
  /// - [GameDraw] if the board is full with no winner
  /// - [GameInProgress] if the game can continue (empty cells remain, no winner)
  ///
  /// Time complexity: O(1) - checks exactly 8 lines × 3 cells = 24 comparisons
  /// Space complexity: O(1) - no additional data structures allocated
  ///
  /// Example:
  /// ```dart
  /// final board = GameBoard.empty()
  ///   .setCell(CellPosition(row: 0, col: 0), Player.x)
  ///   .setCell(CellPosition(row: 0, col: 1), Player.x)
  ///   .setCell(CellPosition(row: 0, col: 2), Player.x);
  ///
  /// final result = CheckWinnerUseCase()(board);
  /// // result is GameWon(winner: Player.x, winningLine: [(0,0), (0,1), (0,2)])
  /// ```
  GameResult call(GameBoard board) {
    // Check each possible winning line
    for (final line in _winningLines) {
      final cells = line.map((i) => board.getCellAt(i)).toList();

      // All three cells must be occupied by the same player
      if (cells[0].isOccupied &&
          cells[0].owner == cells[1].owner &&
          cells[1].owner == cells[2].owner) {
        return GameWon(
          winner: cells[0].owner!,
          winningLine: line.map(CellPosition.fromFlatIndex).toList(),
        );
      }
    }

    // No winner - check for draw (board full)
    if (board.isFull) {
      return const GameDraw();
    }

    // Game continues
    return const GameInProgress();
  }
}

