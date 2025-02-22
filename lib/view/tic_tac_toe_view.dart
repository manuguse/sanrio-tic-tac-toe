import 'package:flutter/material.dart';
import 'package:flutter_ttt/utils/player.dart';

import '../controller/tic_tac_toe_controller.dart';
import '../model/tic_tac_toe_model.dart';
import '../utils/colors.dart';
import '../utils/texts.dart';

class TicTacToeView extends StatefulWidget {
  final Player player1;
  final Player player2;

  const TicTacToeView({
    super.key,
    required this.player1,
    required this.player2,
  });

  @override
  State<TicTacToeView> createState() => _TicTacToeViewState();
}

class _TicTacToeViewState extends State<TicTacToeView> {
  late TicTacToeModel _model;
  late TicTacToeController _controller;
  late List<List<int?>> _board;
  late String _statusText;
  late List<Image> _playerAvatars;
  List<List<int>>? _winningPositions;

  @override
  void initState() {
    super.initState();

    _model = TicTacToeModel(widget.player1, widget.player2);
    _board = List.generate(3, (_) => List.filled(3, null));
    _statusText = "Game starting...";

    _playerAvatars = [
      widget.player1.getDefaultImage,
      widget.player2.getDefaultImage
    ];

    _controller = TicTacToeController(
      model: _model,
      updateCellCallback: _updateCell,
      updateStatusCallback: _updateStatus,
      highlightWinningCellsCallback: _highlightWinningCells,
    );
  }

  void _updateCell(int row, int col, int? player) {
    setState(() {
      _board[row][col] = player;
    });
  }

  void _updateStatus(String status) {
    setState(() {
      _statusText = status;
    });
  }

  void _highlightWinningCells(List<List<int>>? positions) {
    setState(() {
      _winningPositions = positions;
    });
  }

  bool _isCellWinning(int row, int col) {
    if (_winningPositions == null) return false;

    for (var position in _winningPositions!) {
      if (position[0] == row && position[1] == col) {
        return true;
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildHeaderPanel(),
              const SizedBox(height: 20),
              _buildGridPanel(),
              const SizedBox(height: 20),
              _buildFooterPanel(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderPanel() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildPlayerPanel(widget.player1.getName, _playerAvatars[0]),
            const SizedBox(width: 40),
            _buildPlayerPanel(widget.player2.getName, _playerAvatars[1]),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey[300]!,
                width: 1,
              ),
            ),
          ),
          child: Text(
            _statusText,
            style: TextStyle(
              fontSize: 18,
              color: _getStatusColor(),
            ),
          ),
        ),
      ],
    );
  }

  Color _getStatusColor() {
    if (_statusText.contains("wins")) {
      return AppColors.winText;
    } else if (_statusText.contains("draw")) {
      return AppColors.draw;
    } else {
      return AppColors.defaultText;
    }
  }

  Widget _buildPlayerPanel(String text, Image playerIcon) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.grid.withOpacity(0.3), width: 2),
          ),
          child: ClipOval(
            child: SizedBox(
              width: 60,
              height: 60,
              child: playerIcon,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildGridPanel() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppColors.grid,
        border: Border.all(color: AppColors.grid, width: 7),
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 9,
          itemBuilder: (context, index) {
            final row = index ~/ 3;
            final col = index % 3;
            return _buildGridButton(row, col);
          },
        ),
      ),
    );
  }

  Widget _buildGridButton(int row, int col) {
    final player = _board[row][col];
    final isWinningCell = _isCellWinning(row, col);

    return GestureDetector(
      onTap: () {
        _controller.handleCellClick(row, col);
      },
      child: Container(
        decoration: BoxDecoration(
          color: isWinningCell ? AppColors.win : Colors.white,
          border: isWinningCell
              ? Border.all(color: AppColors.win.darker(), width: 2)
              : null,
        ),
        child: player != null
            ? Center(child: SizedBox(
          width: 70,
          height: 70,
          child: _playerAvatars[player],
        ))
            : null,
      ),
    );
  }

  Widget _buildFooterPanel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            _controller.resetGame();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.grid,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            elevation: 0,
          ),
          child: Text(
            Texts.getNewGameText(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 20),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: AppColors.grid),
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          ),
          child: const Text(
            "change players",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}

// Extensão para facilitar o uso do .darker() como no Java
extension ColorExtension on Color {
  Color darker() {
    const factor = 0.8;
    return Color.fromARGB(
      alpha,
      (red * factor).round(),
      (green * factor).round(),
      (blue * factor).round(),
    );
  }
}
