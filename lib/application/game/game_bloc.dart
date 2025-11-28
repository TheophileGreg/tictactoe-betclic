import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/domain.dart';
import 'game_event.dart';
import 'game_state.dart';

/// BLoC that manages the Tic Tac Toe game logic and state.
///
/// This BLoC coordinates the domain use cases and emits appropriate states
/// in response to user events. It follows the BLoC pattern for event-driven
/// state management.
///
/// Flow:
/// ```
/// User taps cell
///     ↓
/// CellTapped event
///     ↓
/// GameBloc processes:
///   1. Validate move (PlayMoveUseCase)
///   2. Update board
///   3. Check winner (CheckWinnerUseCase)
///   4. Switch player or end game
///     ↓
/// Emit new state (GamePlaying or GameOver)
/// ```
///
/// Example usage:
/// ```dart
/// // In your widget
/// BlocProvider(
///   create: (_) => GameBloc()..add(const GameStarted()),
///   child: GameScreen(),
/// )
///
/// // Listen to state changes
/// BlocBuilder<GameBloc, GameState>(
///   builder: (context, state) {
///     return switch (state) {
///       GameInitial() => LoadingWidget(),
///       GamePlaying(:final board) => GameBoardWidget(board: board),
///       GameOver(:final result) => ResultWidget(result: result),
///     };
///   },
/// )
/// ```
class GameBloc extends Bloc<GameEvent, GameState> {
  /// Creates a [GameBloc] with the required use cases.
  ///
  /// By default, initializes use cases internally. You can inject them
  /// for testing purposes.
  GameBloc({
    StartNewGameUseCase? startNewGameUseCase,
    PlayMoveUseCase? playMoveUseCase,
    CheckWinnerUseCase? checkWinnerUseCase,
    SwitchPlayerUseCase? switchPlayerUseCase,
  })  : _startNewGameUseCase = startNewGameUseCase ?? const StartNewGameUseCase(),
        _playMoveUseCase = playMoveUseCase ?? const PlayMoveUseCase(),
        _checkWinnerUseCase = checkWinnerUseCase ?? const CheckWinnerUseCase(),
        _switchPlayerUseCase = switchPlayerUseCase ?? const SwitchPlayerUseCase(),
        super(const GameInitial()) {
    on<GameStarted>(_onGameStarted);
    on<CellTapped>(_onCellTapped);
    on<GameReset>(_onGameReset);
  }

  final StartNewGameUseCase _startNewGameUseCase;
  final PlayMoveUseCase _playMoveUseCase;
  final CheckWinnerUseCase _checkWinnerUseCase;
  final SwitchPlayerUseCase _switchPlayerUseCase;

  /// Handles the [GameStarted] event.
  ///
  /// Initializes a new game with an empty board and Player X as the
  /// starting player.
  void _onGameStarted(GameStarted event, Emitter<GameState> emit) {
    final (:board, :currentPlayer) = _startNewGameUseCase();
    emit(GamePlaying(
      board: board,
      currentPlayer: currentPlayer,
      moveCount: 0,
    ));
  }

  /// Handles the [CellTapped] event.
  ///
  /// Process flow:
  /// 1. Validate that we're in a playing state
  /// 2. Attempt to place the current player's mark
  /// 3. Check if the game has ended (win or draw)
  /// 4. If game continues, switch to the other player
  /// 5. Emit the appropriate state
  void _onCellTapped(CellTapped event, Emitter<GameState> emit) {
    // Only process moves if game is in progress
    if (state is! GamePlaying) return;

    final currentState = state as GamePlaying;

    try {
      // Attempt to play the move
      final newBoard = _playMoveUseCase(
        board: currentState.board,
        position: event.position,
        player: currentState.currentPlayer,
      );

      // Check if the game has ended
      final result = _checkWinnerUseCase(newBoard);

      switch (result) {
        case GameInProgress():
          // Game continues - switch to the other player
          final nextPlayer = _switchPlayerUseCase(currentState.currentPlayer);
          emit(GamePlaying(
            board: newBoard,
            currentPlayer: nextPlayer,
            moveCount: currentState.moveCount + 1,
          ));

        case GameWon() || GameDraw():
          // Game ended - emit GameOver state
          emit(GameOver(
            board: newBoard,
            result: result,
          ));
      }
    } on InvalidMoveException {
      // Invalid move (cell already occupied) - ignore and keep same state
      // Could also emit a specific error state if needed
      return;
    }
  }

  /// Handles the [GameReset] event.
  ///
  /// Resets the game to a fresh state, equivalent to [GameStarted].
  void _onGameReset(GameReset event, Emitter<GameState> emit) {
    final (:board, :currentPlayer) = _startNewGameUseCase();
    emit(GamePlaying(
      board: board,
      currentPlayer: currentPlayer,
      moveCount: 0,
    ));
  }
}

