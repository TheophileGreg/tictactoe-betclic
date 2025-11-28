import 'package:clean_tic_tac_toe/application/game/game_bloc.dart';
import 'package:clean_tic_tac_toe/core/theme/app_theme.dart';
import 'package:clean_tic_tac_toe/domain/domain.dart';
import 'package:clean_tic_tac_toe/presentation/widgets/game_board_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  group('GameBoard Golden Tests', () {
    testGoldens('Empty board golden test', (tester) async {
      // Arrange
      final board = GameBoard.empty();
      final bloc = GameBloc();

      // Act
      await tester.pumpWidgetBuilder(
        BlocProvider.value(
          value: bloc,
          child: GameBoardWidget(board: board),
        ),
        wrapper: materialAppWrapper(
          theme: AppTheme.lightTheme,
        ),
        surfaceSize: const Size(500, 500),
      );
      await tester.pumpAndSettle();

      // Assert
      await screenMatchesGolden(tester, 'goldens/game_board_empty');

      bloc.close();
    });

    testGoldens('Board with game in progress golden test', (tester) async {
      // Arrange
      var board = GameBoard.empty();
      board = board.setCell(const CellPosition(row: 0, col: 0), Player.x);
      board = board.setCell(const CellPosition(row: 0, col: 1), Player.o);
      board = board.setCell(const CellPosition(row: 1, col: 1), Player.x);
      board = board.setCell(const CellPosition(row: 2, col: 0), Player.o);
      final bloc = GameBloc();

      // Act
      await tester.pumpWidgetBuilder(
        BlocProvider.value(
          value: bloc,
          child: GameBoardWidget(board: board),
        ),
        wrapper: materialAppWrapper(
          theme: AppTheme.lightTheme,
        ),
        surfaceSize: const Size(500, 500),
      );
      await tester.pumpAndSettle();

      // Assert
      await screenMatchesGolden(tester, 'goldens/game_board_in_progress');

      bloc.close();
    });

    testGoldens('Board with winning line golden test', (tester) async {
      // Arrange - X wins on top row
      final board = GameBoard.fromCells([
        const Cell(owner: Player.x), const Cell(owner: Player.x), const Cell(owner: Player.x),
        const Cell(owner: Player.o), const Cell(owner: Player.o), const Cell.empty(),
        const Cell.empty(), const Cell.empty(), const Cell.empty(),
      ]);
      final bloc = GameBloc();

      // Act
      await tester.pumpWidgetBuilder(
        BlocProvider.value(
          value: bloc,
          child: GameBoardWidget(board: board),
        ),
        wrapper: materialAppWrapper(
          theme: AppTheme.lightTheme,
        ),
        surfaceSize: const Size(500, 500),
      );
      await tester.pumpAndSettle();

      // Assert
      await screenMatchesGolden(tester, 'goldens/game_board_winner');

      bloc.close();
    });
  });
}

