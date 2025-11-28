import 'package:clean_tic_tac_toe/core/theme/app_theme.dart';
import 'package:clean_tic_tac_toe/domain/domain.dart';
import 'package:clean_tic_tac_toe/presentation/widgets/game_cell_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GameCellWidget', () {
    testWidgets('should display empty cell', (tester) async {
      // Arrange
      const cell = Cell.empty();
      const position = CellPosition(row: 0, col: 0);
      var tapped = false;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GameCellWidget(
              cell: cell,
              position: position,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('X'), findsNothing);
      expect(find.text('O'), findsNothing);

      // Should be tappable
      await tester.tap(find.byType(GameCellWidget));
      expect(tapped, isTrue);
    });

    testWidgets('should display X symbol when cell is occupied by X',
        (tester) async {
      // Arrange
      const cell = Cell(owner: Player.x);
      const position = CellPosition(row: 0, col: 0);

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GameCellWidget(
              cell: cell,
              position: position,
              onTap: () {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle(); // Wait for animations

      // Assert
      expect(find.text('X'), findsOneWidget);
      expect(find.text('O'), findsNothing);
    });

    testWidgets('should display O symbol when cell is occupied by O',
        (tester) async {
      // Arrange
      const cell = Cell(owner: Player.o);
      const position = CellPosition(row: 1, col: 1);

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GameCellWidget(
              cell: cell,
              position: position,
              onTap: () {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('O'), findsOneWidget);
      expect(find.text('X'), findsNothing);
    });

    testWidgets('should not call onTap when cell is occupied', (tester) async {
      // Arrange
      const cell = Cell(owner: Player.x);
      const position = CellPosition(row: 0, col: 0);
      var tapCount = 0;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GameCellWidget(
              cell: cell,
              position: position,
              onTap: () => tapCount++,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Try to tap
      await tester.tap(find.byType(GameCellWidget));
      await tester.pump();

      // Assert
      expect(tapCount, 0); // Should not be called
    });

    testWidgets('should display X with correct color', (tester) async {
      // Arrange
      const cell = Cell(owner: Player.x);
      const position = CellPosition(row: 0, col: 0);

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GameCellWidget(
              cell: cell,
              position: position,
              onTap: () {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      final textWidget = tester.widget<Text>(find.text('X'));
      expect(textWidget.style?.color, AppTheme.playerXColor);
    });

    testWidgets('should display O with correct color', (tester) async {
      // Arrange
      const cell = Cell(owner: Player.o);
      const position = CellPosition(row: 0, col: 0);

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GameCellWidget(
              cell: cell,
              position: position,
              onTap: () {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      final textWidget = tester.widget<Text>(find.text('O'));
      expect(textWidget.style?.color, AppTheme.playerOColor);
    });

    testWidgets('should show animation when cell becomes occupied',
        (tester) async {
      // Arrange
      const emptyCell = Cell.empty();
      const occupiedCell = Cell(owner: Player.x);
      const position = CellPosition(row: 0, col: 0);

      // Act - Start with empty cell
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GameCellWidget(
              cell: emptyCell,
              position: position,
              onTap: () {},
            ),
          ),
        ),
      );

      // Update to occupied cell
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GameCellWidget(
              cell: occupiedCell,
              position: position,
              onTap: () {},
            ),
          ),
        ),
      );

      // Animation should be in progress
      await tester.pump(const Duration(milliseconds: 100));

      // Assert - Symbol should appear
      expect(find.text('X'), findsOneWidget);

      // Complete animation
      await tester.pumpAndSettle();
    });

    testWidgets('should display border when showRightBorder is true',
        (tester) async {
      // Arrange
      const cell = Cell.empty();
      const position = CellPosition(row: 0, col: 0);

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GameCellWidget(
              cell: cell,
              position: position,
              onTap: () {},
              showRightBorder: true,
            ),
          ),
        ),
      );

      // Assert
      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(GameCellWidget),
          matching: find.byType(Container),
        ),
      );
      final decoration = container.decoration as BoxDecoration;
      final border = decoration.border as Border;
      expect(border.right.width, greaterThan(0));
    });

    testWidgets('should display border when showBottomBorder is true',
        (tester) async {
      // Arrange
      const cell = Cell.empty();
      const position = CellPosition(row: 0, col: 0);

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GameCellWidget(
              cell: cell,
              position: position,
              onTap: () {},
              showBottomBorder: true,
            ),
          ),
        ),
      );

      // Assert
      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(GameCellWidget),
          matching: find.byType(Container),
        ),
      );
      final decoration = container.decoration as BoxDecoration;
      final border = decoration.border as Border;
      expect(border.bottom.width, greaterThan(0));
    });
  });
}

