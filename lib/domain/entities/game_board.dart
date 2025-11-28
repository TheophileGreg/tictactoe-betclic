import 'package:equatable/equatable.dart';

import 'cell.dart';
import 'cell_position.dart';
import 'player.dart';

/// Represents the 3x3 Tic Tac Toe game board.
///
/// The board is an immutable value object. Any modification creates a new
/// board instance. Internally, cells are stored as a flat list of 9 elements
/// for optimal performance (O(1) access).
///
/// Example:
/// ```dart
/// final board = GameBoard.empty();
/// final pos = CellPosition(row: 0, col: 0);
///
/// // Place a mark
/// final newBoard = board.setCell(pos, Player.x);
///
/// // Check the cell
/// final cell = newBoard.getCell(pos);
/// print(cell.owner); // Player.x
///
/// // Print the board
/// print(newBoard);
/// // Output:
/// // X | - | -
/// // --+---+--
/// // - | - | -
/// // --+---+--
/// // - | - | -
/// ```
///
/// See also:
/// - [Cell], the individual cell type
/// - [CellPosition], for addressing cells on the board
final class GameBoard extends Equatable {
  const GameBoard._({required List<Cell> cells}) : _cells = cells;

  /// Creates an empty game board with all cells unoccupied.
  ///
  /// This is the standard way to initialize a new game.
  ///
  /// Example:
  /// ```dart
  /// final board = GameBoard.empty();
  /// print(board.isEmpty); // true
  /// print(board.moveCount); // 0
  /// ```
  factory GameBoard.empty() {
    return GameBoard._(
      cells: List.generate(9, (_) => const Cell.empty()),
    );
  }

  /// Creates a board from an existing list of cells.
  ///
  /// The list must contain exactly 9 cells. This factory is primarily used
  /// for testing or reconstructing a board state.
  ///
  /// Throws an [AssertionError] in debug mode if [cells] length is not 9.
  ///
  /// Example:
  /// ```dart
  /// final cells = [
  ///   Cell(owner: Player.x), Cell.empty(), Cell.empty(),
  ///   Cell.empty(), Cell(owner: Player.o), Cell.empty(),
  ///   Cell.empty(), Cell.empty(), Cell.empty(),
  /// ];
  /// final board = GameBoard.fromCells(cells);
  /// ```
  factory GameBoard.fromCells(List<Cell> cells) {
    assert(cells.length == 9, 'Board must have exactly 9 cells');
    return GameBoard._(cells: List.unmodifiable(cells));
  }

  /// Internal flat representation of the board (9 cells).
  final List<Cell> _cells;

  /// The size of the board (3x3).
  static const int size = 3;

  /// Total number of cells on the board.
  static const int totalCells = size * size;

  /// Gets the cell at the specified [position].
  ///
  /// Example:
  /// ```dart
  /// final pos = CellPosition(row: 1, col: 1);
  /// final cell = board.getCell(pos);
  /// ```
  Cell getCell(CellPosition position) => _cells[position.flatIndex];

  /// Gets the cell at the specified flat [index] (0-8).
  ///
  /// This is slightly more efficient than [getCell] when you already have
  /// a flat index.
  ///
  /// Example:
  /// ```dart
  /// final centerCell = board.getCellAt(4); // center of board
  /// ```
  Cell getCellAt(int index) => _cells[index];

  /// Returns a new board with the cell at [position] set to [player].
  ///
  /// Since boards are immutable, this creates and returns a new [GameBoard]
  /// instance. The original board is unchanged.
  ///
  /// Throws [StateError] if the cell at [position] is already occupied.
  ///
  /// Example:
  /// ```dart
  /// final board = GameBoard.empty();
  /// final pos = CellPosition(row: 0, col: 0);
  /// final newBoard = board.setCell(pos, Player.x);
  /// // board.getCell(pos).isEmpty == true (original unchanged)
  /// // newBoard.getCell(pos).owner == Player.x (new board)
  /// ```
  GameBoard setCell(CellPosition position, Player player) {
    final currentCell = getCell(position);
    if (currentCell.isOccupied) {
      throw StateError(
        'Cell at $position is already occupied by ${currentCell.owner}',
      );
    }

    final newCells = List<Cell>.from(_cells);
    newCells[position.flatIndex] = Cell(owner: player);
    return GameBoard._(cells: newCells);
  }

  /// Whether all cells are occupied (board is full).
  ///
  /// Returns `true` if all 9 cells have an owner, `false` otherwise.
  /// A full board typically means the game is a draw (if no winner).
  bool get isFull => _cells.every((cell) => cell.isOccupied);

  /// Whether the board is completely empty (no moves made).
  ///
  /// Returns `true` if all cells are empty, `false` otherwise.
  /// This is useful for detecting the start of a new game.
  bool get isEmpty => _cells.every((cell) => cell.isEmpty);

  /// Returns a list of all empty cell positions on the board.
  ///
  /// This is useful for:
  /// - Determining available moves
  /// - Implementing AI opponent logic
  /// - Validating game state
  ///
  /// Example:
  /// ```dart
  /// final board = GameBoard.empty()
  ///   .setCell(CellPosition(row: 0, col: 0), Player.x);
  /// final available = board.emptyCells;
  /// print(available.length); // 8
  /// ```
  List<CellPosition> get emptyCells {
    final positions = <CellPosition>[];
    for (var i = 0; i < totalCells; i++) {
      if (_cells[i].isEmpty) {
        positions.add(CellPosition.fromFlatIndex(i));
      }
    }
    return positions;
  }

  /// Returns the number of moves made on this board.
  ///
  /// This is calculated by counting occupied cells.
  ///
  /// Example:
  /// ```dart
  /// final board = GameBoard.empty();
  /// print(board.moveCount); // 0
  /// final newBoard = board.setCell(CellPosition(row: 0, col: 0), Player.x);
  /// print(newBoard.moveCount); // 1
  /// ```
  int get moveCount => _cells.where((cell) => cell.isOccupied).length;

  /// Gets a row of cells by index (0-2).
  ///
  /// Returns a list of 3 cells representing the specified row.
  ///
  /// Throws an [AssertionError] in debug mode if [row] is not in range 0-2.
  ///
  /// Example:
  /// ```dart
  /// final topRow = board.getRow(0); // cells at (0,0), (0,1), (0,2)
  /// final middleRow = board.getRow(1);
  /// final bottomRow = board.getRow(2);
  /// ```
  List<Cell> getRow(int row) {
    assert(row >= 0 && row < size, 'Row must be between 0 and 2');
    return [
      _cells[row * size],
      _cells[row * size + 1],
      _cells[row * size + 2],
    ];
  }

  /// Gets a column of cells by index (0-2).
  ///
  /// Returns a list of 3 cells representing the specified column.
  ///
  /// Throws an [AssertionError] in debug mode if [col] is not in range 0-2.
  ///
  /// Example:
  /// ```dart
  /// final leftColumn = board.getColumn(0); // cells at (0,0), (1,0), (2,0)
  /// final middleColumn = board.getColumn(1);
  /// final rightColumn = board.getColumn(2);
  /// ```
  List<Cell> getColumn(int col) {
    assert(col >= 0 && col < size, 'Column must be between 0 and 2');
    return [
      _cells[col],
      _cells[col + size],
      _cells[col + size * 2],
    ];
  }

  /// Gets the main diagonal (top-left to bottom-right).
  ///
  /// Returns cells at positions: (0,0), (1,1), (2,2).
  ///
  /// Example:
  /// ```dart
  /// final diagonal = board.mainDiagonal;
  /// // diagonal[0] = top-left
  /// // diagonal[1] = center
  /// // diagonal[2] = bottom-right
  /// ```
  List<Cell> get mainDiagonal => [_cells[0], _cells[4], _cells[8]];

  /// Gets the anti-diagonal (top-right to bottom-left).
  ///
  /// Returns cells at positions: (0,2), (1,1), (2,0).
  ///
  /// Example:
  /// ```dart
  /// final diagonal = board.antiDiagonal;
  /// // diagonal[0] = top-right
  /// // diagonal[1] = center
  /// // diagonal[2] = bottom-left
  /// ```
  List<Cell> get antiDiagonal => [_cells[2], _cells[4], _cells[6]];

  /// Returns an unmodifiable flat list of all cells.
  ///
  /// The list contains exactly 9 cells in row-major order (left-to-right,
  /// top-to-bottom).
  ///
  /// Example:
  /// ```dart
  /// final allCells = board.cells;
  /// for (var i = 0; i < allCells.length; i++) {
  ///   print('Cell $i: ${allCells[i]}');
  /// }
  /// ```
  List<Cell> get cells => List.unmodifiable(_cells);

  @override
  List<Object?> get props => [_cells];

  /// Returns a human-readable string representation of the board.
  ///
  /// Example output:
  /// ```
  /// X | O | -
  /// --+---+--
  /// - | X | -
  /// --+---+--
  /// O | - | X
  /// ```
  @override
  String toString() {
    final buffer = StringBuffer();
    for (var row = 0; row < size; row++) {
      buffer.writeln(getRow(row).map((c) => c.toString()).join(' | '));
      if (row < size - 1) buffer.writeln('--+---+--');
    }
    return buffer.toString();
  }
}
