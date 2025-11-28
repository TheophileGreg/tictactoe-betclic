import 'package:clean_tic_tac_toe/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CheckWinnerUseCase', () {
    late CheckWinnerUseCase useCase;

    setUp(() {
      useCase = const CheckWinnerUseCase();
    });

    group('GameInProgress', () {
      test('should return GameInProgress for empty board', () {
        // Arrange
        final board = GameBoard.empty();

        // Act
        final result = useCase(board);

        // Assert
        expect(result, isA<GameInProgress>());
      });

      test('should return GameInProgress for partially filled board', () {
        // Arrange
        var board = GameBoard.empty();
        board = board.setCell(const CellPosition(row: 0, col: 0), Player.x);
        board = board.setCell(const CellPosition(row: 1, col: 1), Player.o);

        // Act
        final result = useCase(board);

        // Assert
        expect(result, isA<GameInProgress>());
      });
    });

    group('Horizontal Wins', () {
      test('should detect X win on top row', () {
        // Arrange
        final board = GameBoard.fromCells([
          const Cell(owner: Player.x), const Cell(owner: Player.x), const Cell(owner: Player.x),
          const Cell.empty(), const Cell.empty(), const Cell.empty(),
          const Cell.empty(), const Cell.empty(), const Cell.empty(),
        ]);

        // Act
        final result = useCase(board);

        // Assert
        expect(result, isA<GameWon>());
        final won = result as GameWon;
        expect(won.winner, Player.x);
        expect(won.winningLine.length, 3);
      });

      test('should detect O win on middle row', () {
        // Arrange
        final board = GameBoard.fromCells([
          const Cell.empty(), const Cell.empty(), const Cell.empty(),
          const Cell(owner: Player.o), const Cell(owner: Player.o), const Cell(owner: Player.o),
          const Cell.empty(), const Cell.empty(), const Cell.empty(),
        ]);

        // Act
        final result = useCase(board);

        // Assert
        expect(result, isA<GameWon>());
        final won = result as GameWon;
        expect(won.winner, Player.o);
      });

      test('should detect X win on bottom row', () {
        // Arrange
        final board = GameBoard.fromCells([
          const Cell.empty(), const Cell.empty(), const Cell.empty(),
          const Cell.empty(), const Cell.empty(), const Cell.empty(),
          const Cell(owner: Player.x), const Cell(owner: Player.x), const Cell(owner: Player.x),
        ]);

        // Act
        final result = useCase(board);

        // Assert
        expect(result, isA<GameWon>());
        expect((result as GameWon).winner, Player.x);
      });
    });

    group('Vertical Wins', () {
      test('should detect X win on left column', () {
        // Arrange
        final board = GameBoard.fromCells([
          const Cell(owner: Player.x), const Cell.empty(), const Cell.empty(),
          const Cell(owner: Player.x), const Cell.empty(), const Cell.empty(),
          const Cell(owner: Player.x), const Cell.empty(), const Cell.empty(),
        ]);

        // Act
        final result = useCase(board);

        // Assert
        expect(result, isA<GameWon>());
        expect((result as GameWon).winner, Player.x);
      });

      test('should detect O win on middle column', () {
        // Arrange
        final board = GameBoard.fromCells([
          const Cell.empty(), const Cell(owner: Player.o), const Cell.empty(),
          const Cell.empty(), const Cell(owner: Player.o), const Cell.empty(),
          const Cell.empty(), const Cell(owner: Player.o), const Cell.empty(),
        ]);

        // Act
        final result = useCase(board);

        // Assert
        expect(result, isA<GameWon>());
        expect((result as GameWon).winner, Player.o);
      });

      test('should detect X win on right column', () {
        // Arrange
        final board = GameBoard.fromCells([
          const Cell.empty(), const Cell.empty(), const Cell(owner: Player.x),
          const Cell.empty(), const Cell.empty(), const Cell(owner: Player.x),
          const Cell.empty(), const Cell.empty(), const Cell(owner: Player.x),
        ]);

        // Act
        final result = useCase(board);

        // Assert
        expect(result, isA<GameWon>());
        expect((result as GameWon).winner, Player.x);
      });
    });

    group('Diagonal Wins', () {
      test('should detect X win on main diagonal', () {
        // Arrange
        final board = GameBoard.fromCells([
          const Cell(owner: Player.x), const Cell.empty(), const Cell.empty(),
          const Cell.empty(), const Cell(owner: Player.x), const Cell.empty(),
          const Cell.empty(), const Cell.empty(), const Cell(owner: Player.x),
        ]);

        // Act
        final result = useCase(board);

        // Assert
        expect(result, isA<GameWon>());
        expect((result as GameWon).winner, Player.x);
      });

      test('should detect O win on anti-diagonal', () {
        // Arrange
        final board = GameBoard.fromCells([
          const Cell.empty(), const Cell.empty(), const Cell(owner: Player.o),
          const Cell.empty(), const Cell(owner: Player.o), const Cell.empty(),
          const Cell(owner: Player.o), const Cell.empty(), const Cell.empty(),
        ]);

        // Act
        final result = useCase(board);

        // Assert
        expect(result, isA<GameWon>());
        expect((result as GameWon).winner, Player.o);
      });
    });

    group('Draw', () {
      test('should detect draw when board is full with no winner', () {
        // Arrange
        final board = GameBoard.fromCells([
          const Cell(owner: Player.x), const Cell(owner: Player.o), const Cell(owner: Player.x),
          const Cell(owner: Player.x), const Cell(owner: Player.o), const Cell(owner: Player.o),
          const Cell(owner: Player.o), const Cell(owner: Player.x), const Cell(owner: Player.x),
        ]);

        // Act
        final result = useCase(board);

        // Assert
        expect(result, isA<GameDraw>());
      });

      test('should detect another draw scenario', () {
        // Arrange
        final board = GameBoard.fromCells([
          const Cell(owner: Player.o), const Cell(owner: Player.x), const Cell(owner: Player.o),
          const Cell(owner: Player.x), const Cell(owner: Player.x), const Cell(owner: Player.o),
          const Cell(owner: Player.x), const Cell(owner: Player.o), const Cell(owner: Player.x),
        ]);

        // Act
        final result = useCase(board);

        // Assert
        expect(result, isA<GameDraw>());
      });
    });

    group('Winning Line Information', () {
      test('should return correct winning line positions for horizontal win', () {
        // Arrange
        final board = GameBoard.fromCells([
          const Cell(owner: Player.x), const Cell(owner: Player.x), const Cell(owner: Player.x),
          const Cell.empty(), const Cell.empty(), const Cell.empty(),
          const Cell.empty(), const Cell.empty(), const Cell.empty(),
        ]);

        // Act
        final result = useCase(board) as GameWon;

        // Assert
        expect(result.winningLine, hasLength(3));
        expect(result.winningLine[0], const CellPosition(row: 0, col: 0));
        expect(result.winningLine[1], const CellPosition(row: 0, col: 1));
        expect(result.winningLine[2], const CellPosition(row: 0, col: 2));
      });

      test('should return correct winning line for diagonal win', () {
        // Arrange
        final board = GameBoard.fromCells([
          const Cell(owner: Player.x), const Cell.empty(), const Cell.empty(),
          const Cell.empty(), const Cell(owner: Player.x), const Cell.empty(),
          const Cell.empty(), const Cell.empty(), const Cell(owner: Player.x),
        ]);

        // Act
        final result = useCase(board) as GameWon;

        // Assert
        expect(result.winningLine, hasLength(3));
        expect(result.winningLine[0], const CellPosition(row: 0, col: 0));
        expect(result.winningLine[1], const CellPosition(row: 1, col: 1));
        expect(result.winningLine[2], const CellPosition(row: 2, col: 2));
      });
    });

    group('Edge Cases', () {
      test('should prioritize win over draw if both conditions met', () {
        // This shouldn't happen in real game but test defensive code
        // Arrange
        final board = GameBoard.fromCells([
          const Cell(owner: Player.x), const Cell(owner: Player.x), const Cell(owner: Player.x),
          const Cell(owner: Player.o), const Cell(owner: Player.o), const Cell(owner: Player.x),
          const Cell(owner: Player.x), const Cell(owner: Player.o), const Cell(owner: Player.o),
        ]);

        // Act
        final result = useCase(board);

        // Assert
        expect(result, isA<GameWon>());
        expect((result as GameWon).winner, Player.x);
      });
    });
  });
}

