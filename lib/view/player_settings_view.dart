import 'package:flutter/material.dart';
import 'package:flutter_ttt/components/custom_button.dart';
import 'package:flutter_ttt/components/player_settings_card.dart';
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
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/grid.png'),
                  fit: BoxFit.cover,
                  opacity: 0.1,
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "Customize Your Players",
                        style: TextStyle(
                          fontFamily: 'Schoolbell',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 28),

                      GestureDetector(
                        onTap: () => controller.switchActivePlayer(1),
                        child: PlayerSettingsCard(
                          player: controller.player1,
                          playerNumber: 1,
                          isActive: controller.activePlayer == 1,
                          onFocused: () => controller.switchActivePlayer(1),
                          playerTextEditingController: controller.player1Controller,
                        ),
                      ),

                      const SizedBox(height: 24),

                      GestureDetector(
                        onTap: () => controller.switchActivePlayer(2),
                        child: PlayerSettingsCard(
                          player: controller.player2,
                          playerNumber: 2,
                          isActive: controller.activePlayer == 2,
                          onFocused: () => controller.switchActivePlayer(2),
                          playerTextEditingController: controller.player2Controller,
                        ),
                      ),

                      const SizedBox(height: 32),
                      const Text(
                        "Select Avatar",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),

                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                            ),
                        itemCount: controller.availableAvatars.length,
                        itemBuilder: (context, index) {
                          bool isSelected =
                              (controller.activePlayer == 1 &&
                                  controller.player1.avatarIndex == index) ||
                              (controller.activePlayer == 2 &&
                                  controller.player2.avatarIndex == index);
                          return GestureDetector(
                            onTap: () => controller.selectAvatar(index),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    isSelected
                                        ? Border.all(
                                          color: AppColors.grid,
                                          width: 3,
                                        )
                                        : null,
                              ),
                              child: controller.availableAvatars[index],
                            ),
                          );
                        },
                      ),

                      const Spacer(),

                      CustomButton(
                        onPressed: () => _startGame(context, controller),
                        text: "start game",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _startGame(BuildContext context, PlayerSettingsController controller) {
    if (!controller.validatePlayers()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(Texts.getMissingInformation())));
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return TicTacToeView(
            player1: Player(
              name: controller.player1Controller.text,
              defaultImage: controller.player1.avatarImage,
            ),
            player2: Player(
              name: controller.player2Controller.text,
              defaultImage: controller.player2.avatarImage,
            ),
          );
        },
      ),
    );
  }
}
