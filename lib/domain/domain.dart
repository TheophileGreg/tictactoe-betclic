/// Domain layer for the Tic Tac Toe game.
///
/// This is the core business logic layer of the application, containing pure
/// Dart code with zero dependencies on Flutter or external frameworks. This
/// design makes the domain layer:
/// - Highly testable (unit tests with no Flutter Test Widgets)
/// - Platform-agnostic (can run on any Dart platform)
/// - Maintainable (clear separation of concerns)
/// - Reusable (can be shared across multiple UI implementations)
///
/// The domain layer is divided into two main parts:
///
/// ## Entities
/// Immutable value objects and entities that represent the game's core concepts:
/// - [Player]: X or O player enum
/// - [Cell]: Single board cell (empty or occupied)
/// - [CellPosition]: Coordinates on the board (row, col)
/// - [GameBoard]: 3x3 grid of cells
/// - [GameResult]: Game outcome (in progress, draw, or won)
///
/// ## Use Cases
/// Stateless classes that encapsulate business rules:
/// - [StartNewGameUseCase]: Initialize a new game
/// - [PlayMoveUseCase]: Validate and execute a move
/// - [CheckWinnerUseCase]: Determine game outcome
/// - [SwitchPlayerUseCase]: Alternate between players
///
/// ## Architecture
/// This layer follows Clean Architecture principles:
/// ```
/// Presentation Layer (UI, BLoC)
///         ↓
///    Domain Layer ← You are here
///         ↓
///    Data Layer (if needed for persistence)
/// ```
///
/// ## Usage Example
/// ```dart
/// import 'package:clean_tic_tac_toe/domain/domain.dart';
///
/// // Initialize use cases
/// const startGame = StartNewGameUseCase();
/// const playMove = PlayMoveUseCase();
/// const checkWinner = CheckWinnerUseCase();
///
/// // Game flow
/// var (:board, :currentPlayer) = startGame();
///
/// // Player makes a move
/// board = playMove(
///   board: board,
///   position: CellPosition(row: 1, col: 1),
///   player: currentPlayer,
/// );
///
/// // Check result
/// final result = checkWinner(board);
/// if (result is GameWon) {
///   print('${result.winner.symbol} wins!');
/// }
/// ```
///
/// See also:
/// - [entities/entities.dart] for all entity definitions
/// - [usecases/usecases.dart] for all use case implementations
library;

export 'entities/entities.dart';
export 'usecases/usecases.dart';

