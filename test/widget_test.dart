/// Widget tests for the Tic Tac Toe application.
///
/// These tests verify that the app initializes correctly and basic
/// navigation works as expected.

import 'package:flutter_test/flutter_test.dart';

import 'package:clean_tic_tac_toe/main.dart';

void main() {
  testWidgets('App initializes and shows home screen',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const TicTacToeApp());

    // Verify that the home screen title is shown
    expect(find.text('TIC TAC TOE'), findsOneWidget);
    expect(find.text('COMMENCER'), findsOneWidget);
  });
}
