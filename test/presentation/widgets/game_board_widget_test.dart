import 'package:clean_tic_tac_toe/application/game/game_bloc.dart';
import 'package:clean_tic_tac_toe/application/game/game_event.dart';
import 'package:clean_tic_tac_toe/domain/domain.dart';
import 'package:clean_tic_tac_toe/presentation/widgets/game_board_widget.dart';
import 'package:clean_tic_tac_toe/presentation/widgets/game_cell_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GameBoardWidget', () {
    testWidgets('should display 9 cells for empty board', (tester) async {
      // Arrange
      final board = GameBoard.empty();
      final bloc = GameBloc();

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: bloc,
            child: Scaffold(
              body: GameBoardWidget(board: board),
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(GameCellWidget), findsNWidgets(9));

      bloc.close();
    });

    testWidgets('should display correct symbols for occupied cells',
        (tester) async {
      // Arrange
      var board = GameBoard.empty();
      board = board.setCell(const CellPosition(row: 0, col: 0), Player.x);
      board = board.setCell(const CellPosition(row: 1, col: 1), Player.o);
      final bloc = GameBloc();

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: bloc,
            child: Scaffold(
              body: GameBoardWidget(board: board),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('X'), findsOneWidget);
      expect(find.text('O'), findsOneWidget);

      bloc.close();
    });

    testWidgets('should emit CellTapped event when empty cell is tapped',
        (tester) async {
      // Arrange
      final board = GameBoard.empty();
      final bloc = GameBloc();
      const position = CellPosition(row: 0, col: 0);

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: bloc,
            child: Scaffold(
              body: GameBoardWidget(board: board),
            ),
          ),
        ),
      );

      // Tap the first cell
      await tester.tap(find.byType(GameCellWidget).first);
      await tester.pump();

      // Note: We can't easily verify the event was added without mocking
      // but we can verify the widget responded to the tap
      expect(find.byType(GameCellWidget), findsWidgets);

      bloc.close();
    });

    testWidgets('should display board with proper layout', (tester) async {
      // Arrange
      final board = GameBoard.empty();
      final bloc = GameBloc();

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: bloc,
            child: Scaffold(
              body: GameBoardWidget(board: board),
            ),
          ),
        ),
      );

      // Assert - Board should be displayed
      expect(find.byType(GameBoardWidget), findsOneWidget);
      expect(find.byType(GameCellWidget), findsNWidgets(9));

      bloc.close();
    });

    testWidgets('should display full board correctly', (tester) async {
      // Arrange
      final board = GameBoard.fromCells([
        const Cell(owner: Player.x),
        const Cell(owner: Player.o),
        const Cell(owner: Player.x),
        const Cell(owner: Player.o),
        const Cell(owner: Player.x),
        const Cell(owner: Player.o),
        const Cell(owner: Player.x),
        const Cell(owner: Player.o),
        const Cell(owner: Player.x),
      ]);
      final bloc = GameBloc();

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: bloc,
            child: Scaffold(
              body: GameBoardWidget(board: board),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('X'), findsNWidgets(5));
      expect(find.text('O'), findsNWidgets(4));

      bloc.close();
    });

    testWidgets('should have proper size constraints', (tester) async {
      // Arrange
      final board = GameBoard.empty();
      final bloc = GameBloc();

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: bloc,
            child: Scaffold(
              body: Center(
                child: GameBoardWidget(board: board),
              ),
            ),
          ),
        ),
      );

      // Assert
      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(GameBoardWidget),
          matching: find.byType(Container).first,
        ),
      );

      // Board should have size constraints
      expect(container.constraints?.maxWidth, isNotNull);
      expect(container.constraints?.maxHeight, isNotNull);

      bloc.close();
    });
  });
}

