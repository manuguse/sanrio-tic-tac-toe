import 'package:flutter_ttt/utils/player.dart';

import '../utils/texts.dart';

enum GameStatus { notOver, win, draw }

class TicTacToeModel {
  late List<List<int?>> board;
  late int currentPlayer;
  GameStatus gameStatusEnum;

  bool get isGameOver => gameStatusEnum != GameStatus.notOver;

  String get gameStatus {
    switch (gameStatusEnum) {
      case GameStatus.notOver:
        return Texts.getTurnText(players[currentPlayer].name);
      case GameStatus.win:
        return Texts.getWinText(players[currentPlayer].name);
      case GameStatus.draw:
        return Texts.getDrawText();
    }
  }

  late List<Player> players;
  late int startingPlayer;

  TicTacToeModel(Player player1, Player player2)
    : board = List.generate(3, (_) => List.filled(3, null)),
      currentPlayer = 0,
      startingPlayer = 0,
      gameStatusEnum = GameStatus.notOver,
      players = [player1, player2];

  void initGame() {
    board = List.generate(3, (_) => List.filled(3, null));
    startingPlayer = 1 - startingPlayer;
    currentPlayer = startingPlayer;
    gameStatusEnum = GameStatus.notOver;
  }

  bool makeMove(int row, int col) {
    if (row < 0 ||
        row >= 3 ||
        col < 0 ||
        col >= 3 ||
        board[row][col] != null ||
        gameStatusEnum != GameStatus.notOver) {
      return false;
    }

    board[row][col] = currentPlayer;

    if (checkWin()) {
      gameStatusEnum = GameStatus.win;
    } else if (isBoardFull()) {
      gameStatusEnum = GameStatus.draw;
    } else {
      currentPlayer = 1 - currentPlayer;
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

  String getGameStatus() {
    return gameStatus;
  }

  List<List<int>>? getWinningPositions() {
    for (int i = 0; i < 3; i++) {
      if (board[i][0] != null &&
          board[i][0] == board[i][1] &&
          board[i][1] == board[i][2]) {
        return [
          [i, 0],
          [i, 1],
          [i, 2],
        ];
      }
    }

    for (int i = 0; i < 3; i++) {
      if (board[0][i] != null &&
          board[0][i] == board[1][i] &&
          board[1][i] == board[2][i]) {
        return [
          [0, i],
          [1, i],
          [2, i],
        ];
      }
    }

    if (board[0][0] != null &&
        board[0][0] == board[1][1] &&
        board[1][1] == board[2][2]) {
      return [
        [0, 0],
        [1, 1],
        [2, 2],
      ];
    }

    if (board[0][2] != null &&
        board[0][2] == board[1][1] &&
        board[1][1] == board[2][0]) {
      return [
        [0, 2],
        [1, 1],
        [2, 0],
      ];
    }

    return null;
  }
}
