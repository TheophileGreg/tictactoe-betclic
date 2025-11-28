import '../entities/entities.dart';

/// Use case for starting a new Tic Tac Toe game.
///
/// This use case initializes a fresh game with:
/// - An empty 3x3 board (all cells unoccupied)
/// - [Player.x] as the starting player (by convention)
///
/// This is typically called when:
/// - The app first launches
/// - The user clicks "New Game" or "Restart"
/// - A previous game has finished
///
/// Example usage:
/// ```dart
/// final useCase = StartNewGameUseCase();
/// final (:board, :currentPlayer) = useCase();
///
/// print(board.isEmpty); // true
/// print(currentPlayer); // Player.x
/// ```
///
/// See also:
/// - [GameBoard.empty], which creates the initial board
/// - [PlayMoveUseCase], for placing moves on the board
class StartNewGameUseCase {
  /// Creates a [StartNewGameUseCase] instance.
  ///
  /// This use case has no dependencies and can be instantiated directly.
  const StartNewGameUseCase();

  /// Initializes a new game and returns the initial game state.
  ///
  /// Returns a record containing:
  /// - `board`: An empty [GameBoard] with all cells unoccupied
  /// - `currentPlayer`: [Player.x] (always plays first by convention)
  ///
  /// This method is pure and deterministic - calling it multiple times
  /// always returns the same initial state.
  ///
  /// Example:
  /// ```dart
  /// final useCase = StartNewGameUseCase();
  /// final gameState = useCase();
  ///
  /// // Destructure the record
  /// final board = gameState.board;
  /// final player = gameState.currentPlayer;
  ///
  /// // Or use record pattern matching
  /// final (:board, :currentPlayer) = useCase();
  /// ```
  ({GameBoard board, Player currentPlayer}) call() {
    return (
      board: GameBoard.empty(),
      currentPlayer: Player.x,
    );
  }
}

