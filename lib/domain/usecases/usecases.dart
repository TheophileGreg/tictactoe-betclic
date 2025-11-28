/// Domain use cases for the Tic Tac Toe game.
///
/// This library exports all use case classes that encapsulate the business
/// logic and game rules. Each use case represents a single operation in the
/// game flow.
///
/// Use cases included:
/// - [StartNewGameUseCase]: Initialize a new game with empty board
/// - [PlayMoveUseCase]: Place a player's mark on the board
/// - [CheckWinnerUseCase]: Determine game result (win/draw/in progress)
/// - [SwitchPlayerUseCase]: Switch to the opponent player
///
/// Usage:
/// ```dart
/// import 'package:clean_tic_tac_toe/domain/usecases/usecases.dart';
///
/// // Initialize use cases
/// final startGame = StartNewGameUseCase();
/// final playMove = PlayMoveUseCase();
/// final checkWinner = CheckWinnerUseCase();
///
/// // Game flow example
/// final (:board, :currentPlayer) = startGame();
/// final newBoard = playMove(
///   board: board,
///   position: CellPosition(row: 0, col: 0),
///   player: currentPlayer,
/// );
/// final result = checkWinner(newBoard);
/// ```
///
/// All use cases in this library are:
/// - Pure functions (no side effects)
/// - Stateless (can be instantiated as const)
/// - Testable in isolation
/// - Independent of Flutter framework
library;

export 'check_winner_usecase.dart';
export 'play_move_usecase.dart';
export 'start_new_game_usecase.dart';
export 'switch_player_usecase.dart';

