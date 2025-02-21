class Texts {
  Texts._();

  static String getTurnText(String player) {
    return "${player.toLowerCase()}'s turn to play";
  }

  static String getWinText(String player) {
    return "${player.toLowerCase()} wins!";
  }

  static String getDrawText() {
    return "it's a draw!";
  }

  static String getNewGameText() {
    return "new game";
  }
}
