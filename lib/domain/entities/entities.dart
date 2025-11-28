/// Domain entities for the Tic Tac Toe game.
///
/// This library exports all entity classes and value objects that represent
/// the core domain concepts of a Tic Tac Toe game.
///
/// Entities included:
/// - [Player]: Enum representing X or O player
/// - [Cell]: Value object representing a single board cell
/// - [CellPosition]: Value object for cell coordinates (row, col)
/// - [GameBoard]: Entity representing the 3x3 game board
/// - [GameResult]: Sealed class hierarchy for game outcomes
///
/// Usage:
/// ```dart
/// import 'package:clean_tic_tac_toe/domain/entities/entities.dart';
///
/// final board = GameBoard.empty();
/// final position = CellPosition(row: 0, col: 0);
/// final newBoard = board.setCell(position, Player.x);
/// ```
///
/// All entities in this library are:
/// - Immutable (no setters, use `copyWith` or create new instances)
/// - Pure Dart (no Flutter dependencies)
/// - Value objects using Equatable for equality
library;

export 'cell.dart';
export 'cell_position.dart';
export 'game_board.dart';
export 'game_result.dart';
export 'player.dart';

