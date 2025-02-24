import 'package:flutter/material.dart';
import '../model/player_settings_model.dart';
import '../utils/image_utils.dart';

class PlayerSettingsController extends ChangeNotifier {
  final TextEditingController player1Controller = TextEditingController(
    text: "Player 1",
  );
  final TextEditingController player2Controller = TextEditingController(
    text: "Player 2",
  );

  int activePlayer = 1; // 1 para Player 1, 2 para Player 2

  List<Image> availableAvatars = ImageUtils.loadAllAvatars();
  late List<Image> playerIcons;

  late PlayerSettingsModel player1;
  late PlayerSettingsModel player2;

  PlayerSettingsController() {
    playerIcons = ImageUtils.loadPlayerIcons();
    player1 = PlayerSettingsModel(
      name: "Player 1",
      avatarIndex: 0,
      avatarImage: playerIcons[0],
    );
    player2 = PlayerSettingsModel(
      name: "Player 2",
      avatarIndex: 1,
      avatarImage: playerIcons[1],
    );
  }

  void selectAvatar(int index) {
    if (activePlayer == 1) {
      player1.avatarIndex = index;
      player1.avatarImage = availableAvatars[index];
    } else {
      player2.avatarIndex = index;
      player2.avatarImage = availableAvatars[index];
    }
    notifyListeners();
  }

  void switchActivePlayer(int player) {
    activePlayer = player;
    notifyListeners();
  }

  bool validatePlayers() {
    if (player1Controller.text.trim().isEmpty ||
        player2Controller.text.trim().isEmpty) {
      return false;
    }

    if (player1.avatarIndex == player2.avatarIndex) {
      return false;
    }

    if (player1Controller.text == player2Controller.text) {
      return false;
    }

    return true;
  }

  void disposeControllers() {
    player1Controller.dispose();
    player2Controller.dispose();
  }
}
