import 'package:flutter/material.dart';
import 'package:flutter_ttt/view/player_settings_view.dart';
import 'view/tic_tac_toe_view.dart';

void main() {
  runApp(const TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Poppins',
      ),
      home: const PlayerSettingsView(),
      debugShowCheckedModeBanner: false,
    );
  }
}