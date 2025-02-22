import 'package:flutter_ttt/utils/player.dart';

import '../utils/texts.dart';

class TicTacToeModel {
  late List<List<int?>> board;
  late int currentPlayer;
  late bool gameOver;
  late String gameStatus;
  late List<Player> players;
  late int startingPlayer;

  TicTacToeModel(Player player1, Player player2)
      : board = List.generate(3, (_) => List.filled(3, null)),
        currentPlayer = 0,
        startingPlayer = 0,
        gameOver = false,
        gameStatus = Texts.getTurnText(player1.getName),
        players = [player1, player2];

  void initGame() {
    board = List.generate(3, (_) => List.filled(3, null));
    startingPlayer = 1 - startingPlayer;
    currentPlayer = startingPlayer;
    gameOver = false;
    gameStatus = Texts.getTurnText(players[currentPlayer].getName);
  }

  bool makeMove(int row, int col) {
    if (row < 0 || row >= 3 || col < 0 || col >= 3 || board[row][col] != null || gameOver) {
      return false;
    }

    board[row][col] = currentPlayer;

    if (checkWin()) {
      gameStatus = Texts.getWinText(players[currentPlayer].getName);
      gameOver = true;
    } else if (isBoardFull()) {
      gameStatus = Texts.getDrawText();
      gameOver = true;
    } else {
      currentPlayer = 1 - currentPlayer; // alternates between 0 and 1
      gameStatus = Texts.getTurnText(players[currentPlayer].getName);
    }

    return true;
  }

  bool checkWin() {
    return checkRows() || checkColumns() || checkDiagonals();
  }

  bool checkRows() {
    for (int i = 0; i < 3; i++) {
      if (board[i][0] != null &&
          board[i][0] == board[i][1] &&
          board[i][1] == board[i][2]) {
        return true;
      }
    }
    return false;
  }

  bool checkColumns() {
    for (int i = 0; i < 3; i++) {
      if (board[0][i] != null &&
          board[0][i] == board[1][i] &&
          board[1][i] == board[2][i]) {
        return true;
      }
    }
    return false;
  }

  bool checkDiagonals() {
    return (board[0][0] != null &&
        board[0][0] == board[1][1] &&
        board[1][1] == board[2][2]) ||
        (board[0][2] != null &&
            board[0][2] == board[1][1] &&
            board[1][1] == board[2][0]);
  }

  bool isBoardFull() {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == null) {
          return false;
        }
      }
    }
    return true;
  }

  int? getCell(int row, int col) {
    return board[row][col];
  }

  bool isGameOver() {
    return gameOver;
  }

  String getGameStatus() {
    return gameStatus;
  }

  List<List<int>>? getWinningPositions() {
    // Check rows
    for (int i = 0; i < 3; i++) {
      if (board[i][0] != null &&
          board[i][0] == board[i][1] &&
          board[i][1] == board[i][2]) {
        return [[i, 0], [i, 1], [i, 2]];
      }
    }

    // Check columns
    for (int i = 0; i < 3; i++) {
      if (board[0][i] != null &&
          board[0][i] == board[1][i] &&
          board[1][i] == board[2][i]) {
        return [[0, i], [1, i], [2, i]];
      }
    }

    // Check diagonals
    if (board[0][0] != null &&
        board[0][0] == board[1][1] &&
        board[1][1] == board[2][2]) {
      return [[0, 0], [1, 1], [2, 2]];
    }

    if (board[0][2] != null &&
        board[0][2] == board[1][1] &&
        board[1][1] == board[2][0]) {
      return [[0, 2], [1, 1], [2, 0]];
    }

    return null;
  }

}