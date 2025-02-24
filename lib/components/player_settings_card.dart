import 'package:flutter/material.dart';

import '../model/player_settings_model.dart';
import '../utils/colors.dart';

class PlayerSettingsCard extends StatelessWidget {
  final PlayerSettingsModel player;
  final TextEditingController playerTextEditingController;
  final int playerNumber;
  final bool isActive;
  final VoidCallback onFocused;

  const PlayerSettingsCard({
    super.key,
    required this.player,
    required this.playerNumber,
    required this.isActive,
    required this.onFocused,
    required this.playerTextEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side:
            isActive
                ? BorderSide(color: AppColors.grid, width: 3)
                : BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipOval(child: player.avatarImage),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                onTap: onFocused,
                controller: playerTextEditingController,
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
}
