import 'package:clean_tic_tac_toe/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PlayMoveUseCase', () {
    late PlayMoveUseCase useCase;
    late GameBoard emptyBoard;

    setUp(() {
      useCase = const PlayMoveUseCase();
      emptyBoard = GameBoard.empty();
    });

    test('should place X on an empty cell', () {
      // Arrange
      const position = CellPosition(row: 0, col: 0);

      // Act
      final newBoard = useCase(
        board: emptyBoard,
        position: position,
        player: Player.x,
      );

      // Assert
      final cell = newBoard.getCell(position);
      expect(cell.isOccupied, isTrue);
      expect(cell.owner, Player.x);
    });

    test('should place O on an empty cell', () {
      // Arrange
      const position = CellPosition(row: 1, col: 1);

      // Act
      final newBoard = useCase(
        board: emptyBoard,
        position: position,
        player: Player.o,
      );

      // Assert
      final cell = newBoard.getCell(position);
      expect(cell.isOccupied, isTrue);
      expect(cell.owner, Player.o);
    });

    test('should not modify the original board (immutability)', () {
      // Arrange
      const position = CellPosition(row: 0, col: 0);
      final originalBoard = GameBoard.empty();

      // Act
      useCase(
        board: originalBoard,
        position: position,
        player: Player.x,
      );

      // Assert
      expect(originalBoard.getCell(position).isEmpty, isTrue);
    });

    test('should throw InvalidMoveException when cell is already occupied by X', () {
      // Arrange
      const position = CellPosition(row: 0, col: 0);
      final boardWithX = emptyBoard.setCell(position, Player.x);

      // Act & Assert
      expect(
        () => useCase(
          board: boardWithX,
          position: position,
          player: Player.o,
        ),
        throwsA(isA<InvalidMoveException>()),
      );
    });

    test('should throw InvalidMoveException when cell is already occupied by O', () {
      // Arrange
      const position = CellPosition(row: 1, col: 1);
      final boardWithO = emptyBoard.setCell(position, Player.o);

      // Act & Assert
      expect(
        () => useCase(
          board: boardWithO,
          position: position,
          player: Player.x,
        ),
        throwsA(isA<InvalidMoveException>()),
      );
    });

    test('should allow placing marks in different cells', () {
      // Arrange
      const pos1 = CellPosition(row: 0, col: 0);
      const pos2 = CellPosition(row: 0, col: 1);

      // Act
      var board = useCase(
        board: emptyBoard,
        position: pos1,
        player: Player.x,
      );
      board = useCase(
        board: board,
        position: pos2,
        player: Player.o,
      );

      // Assert
      expect(board.getCell(pos1).owner, Player.x);
      expect(board.getCell(pos2).owner, Player.o);
    });

    test('should work with all board positions', () {
      // Act & Assert
      for (var row = 0; row < 3; row++) {
        for (var col = 0; col < 3; col++) {
          final position = CellPosition(row: row, col: col);
          final newBoard = useCase(
            board: emptyBoard,
            position: position,
            player: Player.x,
          );
          expect(newBoard.getCell(position).owner, Player.x);
        }
      }
    });

    test('InvalidMoveException should contain position information', () {
      // Arrange
      const position = CellPosition(row: 2, col: 2);
      final boardWithX = emptyBoard.setCell(position, Player.x);

      // Act & Assert
      expect(
        () => useCase(
          board: boardWithX,
          position: position,
          player: Player.o,
        ),
        throwsA(
          predicate(
            (e) =>
                e is InvalidMoveException &&
                e.message.contains('(2, 2)') &&
                e.message.contains('occupied'),
          ),
        ),
      );
    });
  });
}

