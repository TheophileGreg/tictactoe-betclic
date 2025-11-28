import 'package:equatable/equatable.dart';

import 'player.dart';

/// Represents a single cell on the game board.
///
/// A cell can either be empty ([owner] is null) or occupied by a [Player].
/// This is an immutable value object that uses [Equatable] for value equality.
///
/// Example:
/// ```dart
/// const emptyCell = Cell.empty();
/// const xCell = Cell(owner: Player.x);
/// const oCell = Cell(owner: Player.o);
///
/// print(emptyCell.isEmpty); // true
/// print(xCell.isOccupied); // true
/// print(xCell.toString()); // 'X'
/// print(emptyCell.toString()); // '-'
/// ```
///
/// See also:
/// - [GameBoard], which manages a 3x3 grid of cells
/// - [Player], which represents the owner of a cell
final class Cell extends Equatable {
  /// Creates a cell with the specified [owner].
  ///
  /// If [owner] is null, the cell is considered empty.
  const Cell({this.owner});

  /// Creates an empty cell with no owner.
  ///
  /// This is equivalent to `Cell(owner: null)` but more explicit.
  const Cell.empty() : owner = null;

  /// The player who owns this cell, or null if the cell is empty.
  final Player? owner;

  /// Whether this cell is empty (has no owner).
  ///
  /// Returns `true` if [owner] is null, `false` otherwise.
  bool get isEmpty => owner == null;

  /// Whether this cell is occupied by a player.
  ///
  /// Returns `true` if [owner] is not null, `false` otherwise.
  /// This is the inverse of [isEmpty].
  bool get isOccupied => owner != null;

  /// Creates a copy of this cell with the specified [owner].
  ///
  /// Since cells are immutable, this returns a new [Cell] instance.
  ///
  /// Example:
  /// ```dart
  /// const empty = Cell.empty();
  /// final occupied = empty.copyWith(owner: Player.x);
  /// print(occupied.owner); // Player.x
  /// ```
  Cell copyWith({Player? owner}) => Cell(owner: owner);

  @override
  List<Object?> get props => [owner];

  /// Returns a string representation of this cell.
  ///
  /// - If occupied: returns the player's symbol ('X' or 'O')
  /// - If empty: returns '-'
  @override
  String toString() => owner?.symbol ?? '-';
}
