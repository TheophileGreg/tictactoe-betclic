import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../domain/entities/entities.dart';

/// Widget representing a single cell in the game board.
///
/// Displays:
/// - Empty state when no player has claimed it
/// - X or O symbol when occupied
/// - Tap feedback and animations
class GameCellWidget extends StatefulWidget {
  const GameCellWidget({
    required this.cell,
    required this.position,
    required this.onTap,
    this.showRightBorder = false,
    this.showBottomBorder = false,
    super.key,
  });

  /// The cell data to display.
  final Cell cell;

  /// The position of this cell on the board.
  final CellPosition position;

  /// Callback when the cell is tapped.
  final VoidCallback onTap;

  /// Whether to show a border on the right side.
  final bool showRightBorder;

  /// Whether to show a border on the bottom side.
  final bool showBottomBorder;

  @override
  State<GameCellWidget> createState() => _GameCellWidgetState();
}

class _GameCellWidgetState extends State<GameCellWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AppTheme.animationDuration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // Trigger animation if cell is already occupied
    if (widget.cell.isOccupied) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(GameCellWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Trigger animation when cell becomes occupied
    if (oldWidget.cell.isEmpty && widget.cell.isOccupied) {
      _controller.forward();
    }

    // Reset animation when cell becomes empty
    if (oldWidget.cell.isOccupied && widget.cell.isEmpty) {
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.cell.isEmpty ? widget.onTap : null,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: widget.showRightBorder
                ? BorderSide(color: AppTheme.gridColor, width: 2)
                : BorderSide.none,
            bottom: widget.showBottomBorder
                ? BorderSide(color: AppTheme.gridColor, width: 2)
                : BorderSide.none,
          ),
        ),
        child: Center(
          child: widget.cell.isOccupied
              ? FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: _buildSymbol(),
                  ),
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildSymbol() {
    final player = widget.cell.owner!;
    final color =
        player == Player.x ? AppTheme.playerXColor : AppTheme.playerOColor;

    return Text(
      player.symbol,
      style: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }
}

