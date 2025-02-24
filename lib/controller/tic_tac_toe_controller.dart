import '../model/tic_tac_toe_model.dart';

class TicTacToeController {
    final TicTacToeModel model;

    // Callbacks para atualizar a UI
    final Function(int, int, int?) updateCellCallback;
    final Function(String) updateStatusCallback;
    final Function(List<List<int>>?) highlightWinningCellsCallback;

    TicTacToeController({
        required this.model,
        required this.updateCellCallback,
        required this.updateStatusCallback,
        required this.highlightWinningCellsCallback,
    }) {
        updateView();
    }

    void handleCellClick(int row, int col) {
        if (model.makeMove(row, col)) {
            updateView();

            if (model.isGameOver) {
                gameOver();
            }
        }
    }

    void gameOver() {
        List<List<int>>? winningPositions = model.getWinningPositions();
        if (winningPositions != null) {
            highlightWinningCellsCallback(winningPositions);
        }
    }

    void resetGame() {
        model.initGame();
        updateView();
        highlightWinningCellsCallback(null); // Limpa as células destacadas
    }

    void updateView() {
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
                int? cell = model.getCell(i, j);
                updateCellCallback(i, j, cell);
            }
        }
        updateStatusCallback(model.getGameStatus());
    }
}