import 'package:clean_tic_tac_toe/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StartNewGameUseCase', () {
    late StartNewGameUseCase useCase;

    setUp(() {
      useCase = const StartNewGameUseCase();
    });

    test('should return an empty board', () {
      // Act
      final result = useCase();

      // Assert
      expect(result.board.isEmpty, isTrue);
      expect(result.board.moveCount, 0);
    });

    test('should return Player X as the starting player', () {
      // Act
      final result = useCase();

      // Assert
      expect(result.currentPlayer, Player.x);
    });

    test('should return a board with all cells empty', () {
      // Act
      final result = useCase();

      // Assert
      for (var i = 0; i < 9; i++) {
        final cell = result.board.getCellAt(i);
        expect(cell.isEmpty, isTrue);
        expect(cell.owner, isNull);
      }
    });

    test('should be deterministic (same result each time)', () {
      // Act
      final result1 = useCase();
      final result2 = useCase();

      // Assert
      expect(result1.board, equals(result2.board));
      expect(result1.currentPlayer, equals(result2.currentPlayer));
    });

    test('should return a board with size 3x3', () {
      // Act
      final result = useCase();

      // Assert
      expect(result.board.cells.length, 9);
      expect(GameBoard.size, 3);
    });
  });
}

