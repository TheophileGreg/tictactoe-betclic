/// Represents a player in the Tic Tac Toe game.
///
/// Each player is identified by their symbol: X or O.
/// By convention, [Player.x] always plays first.
///
/// Example:
/// ```dart
/// final currentPlayer = Player.x;
/// final nextPlayer = currentPlayer.opponent; // Player.o
/// print(currentPlayer.symbol); // 'X'
/// ```
///
/// See also:
/// - [Cell], which tracks which player occupies a cell
enum Player {
  /// Player X (traditionally plays first).
  x('X'),

  /// Player O (traditionally plays second).
  o('O');

  /// Creates a player with the given [symbol].
  const Player(this.symbol);

  /// The display symbol for this player ('X' or 'O').
  ///
  /// This is useful for UI rendering and debugging output.
  final String symbol;

  /// Returns the opponent of this player.
  ///
  /// - [Player.x] → [Player.o]
  /// - [Player.o] → [Player.x]
  ///
  /// Example:
  /// ```dart
  /// final current = Player.x;
  /// final next = current.opponent; // Player.o
  /// final afterThat = next.opponent; // Player.x
  /// ```
  Player get opponent => this == Player.x ? Player.o : Player.x;
}

