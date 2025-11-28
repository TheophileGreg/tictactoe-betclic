import 'package:clean_tic_tac_toe/core/theme/app_theme.dart';
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

      final builder = GoldenBuilder.column()
        ..addScenario(
          'Empty cell',
          Container(
            width: 100,
            height: 100,
            color: Colors.white,
            child: GameCellWidget(
              cell: cell,
              position: position,
              onTap: () {},
            ),
          ),
        );

      // Act & Assert
      await tester.pumpWidgetBuilder(
        builder.build(),
        surfaceSize: const Size(200, 150),
      );
      await tester.pumpAndSettle();

      await screenMatchesGolden(tester, 'game_cell_empty');
    });

    testGoldens('Cell with X and O golden test', (tester) async {
      // Arrange
      const cellX = Cell(owner: Player.x);
      const cellO = Cell(owner: Player.o);
      const position = CellPosition(row: 0, col: 0);

      final builder = GoldenBuilder.column()
        ..addScenario(
          'Cell with X',
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: GameCellWidget(
              cell: cellX,
              position: position,
              onTap: () {},
            ),
          ),
        )
        ..addScenario(
          'Cell with O',
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: GameCellWidget(
              cell: cellO,
              position: position,
              onTap: () {},
            ),
          ),
        );

      // Act & Assert
      await tester.pumpWidgetBuilder(
        builder.build(),
        surfaceSize: const Size(200, 400),
      );
      await tester.pumpAndSettle();

      await screenMatchesGolden(tester, 'game_cell_x_and_o');
    });
  });
}
