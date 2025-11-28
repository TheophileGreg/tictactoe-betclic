import '../entities/entities.dart';

/// Use case for switching the current player to the opponent.
///
/// This simple use case returns the opponent of the current player.
/// In Tic Tac Toe, players alternate turns: X → O → X → O, etc.
///
/// Note: This is a thin wrapper around [Player.opponent]. It exists to:
/// - Maintain consistency with other use cases
/// - Make the game flow explicit in the application layer
/// - Provide a centralized place for turn-switching logic if it becomes
///   more complex in the future
///
/// However, you can also use [Player.opponent] directly if you prefer.
///
/// Example usage:
/// ```dart
/// final useCase = SwitchPlayerUseCase();
/// var currentPlayer = Player.x;
///
/// currentPlayer = useCase(currentPlayer); // Player.o
/// currentPlayer = useCase(currentPlayer); // Player.x
/// currentPlayer = useCase(currentPlayer); // Player.o
/// ```
///
/// See also:
/// - [Player.opponent], which provides the same functionality directly
/// - [PlayMoveUseCase], which is called before switching players
class SwitchPlayerUseCase {
  /// Creates a [SwitchPlayerUseCase] instance.
  ///
  /// This use case has no dependencies and can be instantiated directly.
  const SwitchPlayerUseCase();

  /// Returns the opponent of [currentPlayer].
  ///
  /// This method alternates between players:
  /// - [Player.x] → [Player.o]
  /// - [Player.o] → [Player.x]
  ///
  /// The method is pure and deterministic - it always returns the same
  /// result for the same input.
  ///
  /// Example:
  /// ```dart
  /// final useCase = SwitchPlayerUseCase();
  ///
  /// final nextPlayer = useCase(Player.x); // Player.o
  /// final afterThat = useCase(nextPlayer); // Player.x
  /// ```
  Player call(Player currentPlayer) {
    return currentPlayer.opponent;
  }
}

