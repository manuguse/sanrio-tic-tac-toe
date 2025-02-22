import 'package:flutter/material.dart';
import 'package:flutter_ttt/view/tic_tac_toe_view.dart';
import 'package:provider/provider.dart';

import '../controller/player_settings_controller.dart';
import '../model/player_settings_model.dart';
import '../utils/colors.dart';
import '../utils/player.dart';
import '../utils/texts.dart';

class PlayerSettingsView extends StatelessWidget {
  const PlayerSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PlayerSettingsController(),
      child: Consumer<PlayerSettingsController>(
        builder: (context, controller, child) {
          return Scaffold(
            backgroundColor: AppColors.background,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Customize Your Players",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),

                    GestureDetector(
                      onTap: () => controller.switchActivePlayer(1),
                      child: _buildPlayerSettingsCard(context, controller, controller.player1, 1),
                    ),

                    const SizedBox(height: 24),

                    GestureDetector(
                      onTap: () => controller.switchActivePlayer(2),
                      child: _buildPlayerSettingsCard(context, controller, controller.player2, 2),
                    ),

                    const SizedBox(height: 32),
                    const Text(
                      "Select Avatar",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),

                    Expanded(
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        itemCount: controller.availableAvatars.length,
                        itemBuilder: (context, index) {
                          bool isSelected =
                              (controller.activePlayer == 1 && controller.player1.avatarIndex == index) ||
                                  (controller.activePlayer == 2 && controller.player2.avatarIndex == index);
                          return GestureDetector(
                            onTap: () => controller.selectAvatar(index),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: isSelected
                                    ? Border.all(color: AppColors.grid, width: 3)
                                    : null,
                              ),
                              child: controller.availableAvatars[index],
                            ),
                          );
                        },
                      ),
                    ),

                    const Spacer(),

                    ElevatedButton(
                      onPressed: () => _startGame(context, controller),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.grid,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Start Game",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPlayerSettingsCard(BuildContext context, PlayerSettingsController controller, PlayerSettingsModel player, int playerNumber) {
    bool isActive = controller.activePlayer == playerNumber;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isActive ? BorderSide(color: AppColors.grid, width: 3) : BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipOval(child: player.avatarImage),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: playerNumber == 1 ? controller.player1Controller : controller.player2Controller,
                decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                style: const TextStyle(fontSize: 16),
                maxLength: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startGame(BuildContext context, PlayerSettingsController controller) {
    if (!controller.validatePlayers()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(Texts.getMissingInformation())),
      );
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => TicTacToeView(
          player1: Player(name: controller.player1Controller.text, defaultImage: controller.player1.avatarImage),
          player2: Player(name: controller.player2Controller.text, defaultImage: controller.player2.avatarImage),
        ),
      ),
    );
  }
}
