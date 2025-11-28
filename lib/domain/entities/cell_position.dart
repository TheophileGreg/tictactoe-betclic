import 'package:equatable/equatable.dart';

/// Represents a position on the game board using 0-indexed coordinates.
///
/// The board uses a coordinate system where:
/// - [row] ranges from 0 to 2 (top to bottom)
/// - [col] ranges from 0 to 2 (left to right)
///
/// Visual representation of the board positions:
/// ```
/// (0,0) | (0,1) | (0,2)
/// ------+-------+------
/// (1,0) | (1,1) | (1,2)
/// ------+-------+------
/// (2,0) | (2,1) | (2,2)
/// ```
///
/// This class uses value equality via [Equatable], meaning two positions
/// with the same row and column are considered equal.
///
/// Example:
/// ```dart
/// const topLeft = CellPosition(row: 0, col: 0);
/// const center = CellPosition(row: 1, col: 1);
/// const fromIndex = CellPosition.fromFlatIndex(4); // center (1, 1)
///
/// print(center.flatIndex); // 4
/// print(center == fromIndex); // true
/// ```
///
/// See also:
/// - [GameBoard], which uses positions to access cells
final class CellPosition extends Equatable {
  /// Creates a position with the given [row] and [col].
  ///
  /// Both [row] and [col] must be in the range 0-2 (inclusive).
  ///
  /// Throws an [AssertionError] in debug mode if the coordinates are invalid.
  const CellPosition({
    required this.row,
    required this.col,
  })  : assert(row >= 0 && row < 3, 'Row must be between 0 and 2'),
        assert(col >= 0 && col < 3, 'Column must be between 0 and 2');

  /// The row index (0-2, top to bottom).
  final int row;

  /// The column index (0-2, left to right).
  final int col;

  /// Converts this position to a flat index (0-8) for a 3x3 grid.
  ///
  /// Formula: `index = row * 3 + col`
  ///
  /// Example:
  /// ```dart
  /// CellPosition(row: 0, col: 0).flatIndex; // 0 (top-left)
  /// CellPosition(row: 1, col: 1).flatIndex; // 4 (center)
  /// CellPosition(row: 2, col: 2).flatIndex; // 8 (bottom-right)
  /// ```
  int get flatIndex => row * 3 + col;

  /// Creates a position from a flat index (0-8).
  ///
  /// Formula:
  /// - `row = index ~/ 3`
  /// - `col = index % 3`
  ///
  /// Throws an [AssertionError] in debug mode if [index] is not in range 0-8.
  ///
  /// Example:
  /// ```dart
  /// CellPosition.fromFlatIndex(0); // (0, 0) top-left
  /// CellPosition.fromFlatIndex(4); // (1, 1) center
  /// CellPosition.fromFlatIndex(8); // (2, 2) bottom-right
  /// ```
  factory CellPosition.fromFlatIndex(int index) {
    assert(index >= 0 && index < 9, 'Index must be between 0 and 8');
    return CellPosition(
      row: index ~/ 3,
      col: index % 3,
    );
  }

  @override
  List<Object?> get props => [row, col];

  @override
  String toString() => 'CellPosition($row, $col)';
}

