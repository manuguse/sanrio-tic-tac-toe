import 'package:flutter/material.dart';
import 'package:flutter_ttt/utils/player.dart';

import '../utils/colors.dart';
import '../utils/image_utils.dart';
import '../view/tic_tac_toe_view.dart';

class PlayerSettingsScreen extends StatefulWidget {
  const PlayerSettingsScreen({super.key});

  @override
  State<PlayerSettingsScreen> createState() => _PlayerSettingsScreenState();
}

class _PlayerSettingsScreenState extends State<PlayerSettingsScreen> {
  final _player1Controller = TextEditingController(text: "Player 1");
  final _player2Controller = TextEditingController(text: "Player 2");

  int _player1AvatarIndex = 0;
  int _player2AvatarIndex = 0;
  int _activePlayer = 1; // 1 para Player 1, 2 para Player 2

  late List<Image> _availableAvatars;

  @override
  void initState() {
    super.initState();
    _availableAvatars = ImageUtils.loadAllAvatars();
  }

  @override
  void dispose() {
    _player1Controller.dispose();
    _player2Controller.dispose();
    super.dispose();
  }

  void _selectAvatar(int index) {
    setState(() {
      if (_activePlayer == 1) {
        _player1AvatarIndex = index;
      } else {
        _player2AvatarIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                onTap: () => setState(() => _activePlayer = 1),
                child: _buildPlayerSettingsCard(
                  "Player 1",
                  _player1Controller,
                  _player1AvatarIndex,
                  _activePlayer == 1,
                ),
              ),

              const SizedBox(height: 24),

              GestureDetector(
                onTap: () => setState(() => _activePlayer = 2),
                child: _buildPlayerSettingsCard(
                  "Player 2",
                  _player2Controller,
                  _player2AvatarIndex,
                  _activePlayer == 2,
                ),
              ),

              const SizedBox(height: 32,),
              // Avatar Selection
              const Text(
                "select avatar",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // Number of columns in the grid
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemCount: _availableAvatars.length,
                itemBuilder: (context, index) {
                  bool isSelected =
                      (_activePlayer == 1 && _player1AvatarIndex == index) ||
                          (_activePlayer == 2 && _player2AvatarIndex == index);
                  return GestureDetector(
                    onTap: () => _selectAvatar(index),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: isSelected
                            ? Border.all(color: AppColors.grid, width: 3)
                            : null,
                      ),
                      child: _availableAvatars[index],
                    ),
                  );
                },
              ),
            ),

              const Spacer(),

              ElevatedButton(
                onPressed: _startGame,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.grid,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "start game",
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
  }

  Widget _buildPlayerSettingsCard(
    String label,
    TextEditingController controller,
    int selectedAvatarIndex,
    bool isActive,
  ) {
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
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // color: AppColors.grid,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipOval(child: _availableAvatars[selectedAvatarIndex]),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: "name",
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

  void _startGame() {
    final player1Name = _player1Controller.text.trim();
    final player2Name = _player2Controller.text.trim();

    if (player1Name.isEmpty || player2Name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Player names cannot be empty")),
      );
      return;
    }

    if (_player1AvatarIndex == _player2AvatarIndex) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Players cannot use the same avatar")),
      );
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder:
            (context) => TicTacToeView(
              player1: Player(
                name: player1Name,
                defaultImage: _availableAvatars[_player1AvatarIndex],
              ),
              player2: Player(
                name: player2Name,
                defaultImage: _availableAvatars[_player2AvatarIndex],
              ),
            ),
      ),
    );
  }
}
