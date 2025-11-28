import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/game/game_bloc.dart';
import '../../application/game/game_event.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/entities.dart';
import 'game_cell_widget.dart';

/// Widget that displays the 3x3 Tic Tac Toe game board.
///
/// The board is rendered as a grid with lines separating the cells.
/// Each cell can be tapped to place a mark.
class GameBoardWidget extends StatelessWidget {
  const GameBoardWidget({
    required this.board,
    super.key,
  });

  /// The game board to display.
  final GameBoard board;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final boardSize = (screenWidth - 48).clamp(280.0, 400.0);

    return Container(
      width: boardSize,
      height: boardSize,
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: List.generate(3, (row) {
            return Expanded(
              child: Row(
                children: List.generate(3, (col) {
                  final position = CellPosition(row: row, col: col);
                  final cell = board.getCell(position);

                  return Expanded(
                    child: GameCellWidget(
                      cell: cell,
                      position: position,
                      onTap: () => _onCellTapped(context, position),
                      showRightBorder: col < 2,
                      showBottomBorder: row < 2,
                    ),
                  );
                }),
              ),
            );
          }),
        ),
      ),
    );
  }

  void _onCellTapped(BuildContext context, CellPosition position) {
    context.read<GameBloc>().add(CellTapped(position: position));
  }
}

