import 'package:clean_tic_tac_toe/core/theme/app_theme.dart';
import 'package:clean_tic_tac_toe/domain/domain.dart';
import 'package:clean_tic_tac_toe/presentation/widgets/player_turn_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PlayerTurnIndicator', () {
    testWidgets('should display "Joueur X" when current player is X',
        (tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PlayerTurnIndicator(currentPlayer: Player.x),
          ),
        ),
      );

      // Assert
      expect(find.text('Joueur'), findsOneWidget);
      expect(find.text('X'), findsOneWidget);
    });

    testWidgets('should display "Joueur O" when current player is O',
        (tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PlayerTurnIndicator(currentPlayer: Player.o),
          ),
        ),
      );

      // Assert
      expect(find.text('Joueur'), findsOneWidget);
      expect(find.text('O'), findsOneWidget);
    });

    testWidgets('should use player X color when current player is X',
        (tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PlayerTurnIndicator(currentPlayer: Player.x),
          ),
        ),
      );

      // Assert
      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(PlayerTurnIndicator),
          matching: find.byType(Container).at(1), // Inner container with player badge
        ),
      );
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, AppTheme.playerXColor);
    });

    testWidgets('should use player O color when current player is O',
        (tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PlayerTurnIndicator(currentPlayer: Player.o),
          ),
        ),
      );

      // Assert
      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(PlayerTurnIndicator),
          matching: find.byType(Container).at(1),
        ),
      );
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, AppTheme.playerOColor);
    });

    testWidgets('should have rounded corners', (tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PlayerTurnIndicator(currentPlayer: Player.x),
          ),
        ),
      );

      // Assert
      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(PlayerTurnIndicator),
          matching: find.byType(Container).first,
        ),
      );
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.borderRadius, isNotNull);
    });

    testWidgets('should display border with player color', (tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PlayerTurnIndicator(currentPlayer: Player.x),
          ),
        ),
      );

      // Assert
      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(PlayerTurnIndicator),
          matching: find.byType(Container).first,
        ),
      );
      final decoration = container.decoration as BoxDecoration;
      final border = decoration.border as Border;
      expect(border.top.color, AppTheme.playerXColor);
    });
  });
}

