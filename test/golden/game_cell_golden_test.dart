import 'package:clean_tic_tac_toe/domain/domain.dart';
import 'package:clean_tic_tac_toe/presentation/widgets/game_cell_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  group('GameCell Golden Tests', () {
    testGoldens('Empty cell golden test', (tester) async {
      // Arrange
      const cell = Cell.empty();
      const position = CellPosition(row: 0, col: 0);

      // Act
      await tester.pumpWidgetBuilder(
        SizedBox(
          width: 100,
          height: 100,
          child: GameCellWidget(
            cell: cell,
            position: position,
            onTap: () {},
          ),
        ),
        surfaceSize: const Size(100, 100),
      );
      await tester.pumpAndSettle();

      // Assert
      await screenMatchesGolden(tester, 'goldens/game_cell_empty');
    });

    testGoldens('Cell with X and O golden test', (tester) async {
      // Arrange
      const cellX = Cell(owner: Player.x);
      const cellO = Cell(owner: Player.o);
      const position = CellPosition(row: 0, col: 0);

      final builder = GoldenBuilder.column()
        ..addScenario(
          'Cell with X',
          SizedBox(
            width: 100,
            height: 100,
            child: GameCellWidget(
              cell: cellX,
              position: position,
              onTap: () {},
            ),
          ),
        )
        ..addScenario(
          'Cell with O',
          SizedBox(
            width: 100,
            height: 100,
            child: GameCellWidget(
              cell: cellO,
              position: position,
              onTap: () {},
            ),
          ),
        );

      // Act
      await tester.pumpWidgetBuilder(
        builder.build(),
        surfaceSize: const Size(500, 500),
      );
      await tester.pumpAndSettle();

      // Assert
      await screenMatchesGolden(tester, 'goldens/game_cell_x_and_o');
    });
  });
}
