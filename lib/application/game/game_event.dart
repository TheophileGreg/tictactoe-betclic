import 'package:equatable/equatable.dart';

import '../../domain/entities/entities.dart';

/// Base class for all game events.
///
/// Events represent user actions or system triggers that can change
/// the game state. They are processed by [GameBloc].
sealed class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object?> get props => [];
}

/// Event triggered when starting a new game.
///
/// This resets the board and sets Player X as the first player.
///
/// Example:
/// ```dart
/// context.read<GameBloc>().add(const GameStarted());
/// ```
final class GameStarted extends GameEvent {
  const GameStarted();
}

/// Event triggered when a player taps a cell on the board.
///
/// Contains the [position] of the cell that was tapped.
///
/// Example:
/// ```dart
/// context.read<GameBloc>().add(
///   CellTapped(position: CellPosition(row: 1, col: 1)),
/// );
/// ```
final class CellTapped extends GameEvent {
  const CellTapped({required this.position});

  /// The position of the cell that was tapped.
  final CellPosition position;

  @override
  List<Object?> get props => [position];
}

/// Event triggered when the user wants to reset/restart the game.
///
/// This clears the board and starts a fresh game with Player X.
///
/// Example:
/// ```dart
/// context.read<GameBloc>().add(const GameReset());
/// ```
final class GameReset extends GameEvent {
  const GameReset();
}

