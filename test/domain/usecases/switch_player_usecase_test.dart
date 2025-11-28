import 'package:clean_tic_tac_toe/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SwitchPlayerUseCase', () {
    late SwitchPlayerUseCase useCase;

    setUp(() {
      useCase = const SwitchPlayerUseCase();
    });

    test('should switch from X to O', () {
      // Act
      final result = useCase(Player.x);

      // Assert
      expect(result, Player.o);
    });

    test('should switch from O to X', () {
      // Act
      final result = useCase(Player.o);

      // Assert
      expect(result, Player.x);
    });

    test('should be reversible', () {
      // Arrange
      const initial = Player.x;

      // Act
      final switched = useCase(initial);
      final switchedBack = useCase(switched);

      // Assert
      expect(switchedBack, initial);
    });

    test('should alternate correctly in sequence', () {
      // Arrange
      var current = Player.x;

      // Act & Assert
      current = useCase(current);
      expect(current, Player.o);

      current = useCase(current);
      expect(current, Player.x);

      current = useCase(current);
      expect(current, Player.o);

      current = useCase(current);
      expect(current, Player.x);
    });

    test('should match Player.opponent behavior', () {
      // Assert
      expect(useCase(Player.x), Player.x.opponent);
      expect(useCase(Player.o), Player.o.opponent);
    });
  });
}

