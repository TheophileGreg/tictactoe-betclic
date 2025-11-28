import '../entities/entities.dart';

/// Exception thrown when an invalid move is attempted.
///
/// This exception is thrown by [PlayMoveUseCase] when a player tries to
/// place a mark on a cell that is already occupied.
///
/// Example:
/// ```dart
/// try {
///   final newBoard = playMoveUseCase(
///     board: board,
///     position: position,
///     player: Player.x,
///   );
/// } on InvalidMoveException catch (e) {
///   print('Invalid move: ${e.message}');
///   showErrorToUser(e.message);
/// }
/// ```
class InvalidMoveException implements Exception {
  /// Creates an [InvalidMoveException] with the given error [message].
  const InvalidMoveException(this.message);

  /// A human-readable description of why the move was invalid.
  final String message;

  @override
  String toString() => 'InvalidMoveException: $message';
}

/// Use case for playing a move on the game board.
///
/// This use case handles the logic of placing a player's mark on the board.
/// It validates that the target cell is empty and returns the updated board
/// state if the move is valid.
///
/// Since boards are immutable, this returns a new [GameBoard] instance
/// rather than modifying the existing one.
///
/// Example usage:
/// ```dart
/// final useCase = PlayMoveUseCase();
/// final position = CellPosition(row: 1, col: 1);
///
/// try {
///   final newBoard = useCase(
///     board: currentBoard,
///     position: position,
///     player: Player.x,
///   );
///   // Move successful, use newBoard
/// } on InvalidMoveException catch (e) {
///   // Move failed, show error to user
///   print(e.message);
/// }
/// ```
///
/// See also:
/// - [GameBoard.setCell], which performs the actual cell update
/// - [CheckWinnerUseCase], typically called after a successful move
class PlayMoveUseCase {
  /// Creates a [PlayMoveUseCase] instance.
  ///
  /// This use case has no dependencies and can be instantiated directly.
  const PlayMoveUseCase();

  /// Attempts to place [player]'s mark at [position] on [board].
  ///
  /// Validates the move and returns a new [GameBoard] with the updated state.
  /// The original [board] is not modified (immutability).
  ///
  /// Parameters:
  /// - [board]: The current game board state
  /// - [position]: The position where the player wants to place their mark
  /// - [player]: The player making the move (X or O)
  ///
  /// Returns a new [GameBoard] with the cell at [position] occupied by [player].
  ///
  /// Throws [InvalidMoveException] if the cell at [position] is already
  /// occupied by another player.
  ///
  /// Example:
  /// ```dart
  /// final board = GameBoard.empty();
  /// final useCase = PlayMoveUseCase();
  ///
  /// // Valid move
  /// final newBoard = useCase(
  ///   board: board,
  ///   position: CellPosition(row: 0, col: 0),
  ///   player: Player.x,
  /// );
  ///
  /// // Invalid move - cell already occupied
  /// try {
  ///   useCase(
  ///     board: newBoard,
  ///     position: CellPosition(row: 0, col: 0), // same position
  ///     player: Player.o,
  ///   );
  /// } on InvalidMoveException catch (e) {
  ///   print(e); // Cell at (0, 0) is already occupied by X
  /// }
  /// ```
  GameBoard call({
    required GameBoard board,
    required CellPosition position,
    required Player player,
  }) {
    final cell = board.getCell(position);

    if (cell.isOccupied) {
      throw InvalidMoveException(
        'Cell at (${position.row}, ${position.col}) is already occupied by ${cell.owner!.symbol}',
      );
    }

    return board.setCell(position, player);
  }
}

