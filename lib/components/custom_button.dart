import 'package:flutter/material.dart';
import 'package:flutter_ttt/utils/utils.dart';
import 'package:flutter_ttt/view/tic_tac_toe_view.dart';
import '../utils/colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color backgroundColor;
  final Color textColor;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor = AppColors.grid,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: AppColors.grid, // Cor da borda
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.grid, // Cor da borda
            offset: const Offset(-4, 5), // Move a sombra para criar o efeito angulado
            blurRadius: 0, // Deixar sem desfoque para parecer uma borda sólida
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.transparent,
          backgroundColor: AppColors.background.lighter(),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: "Schoolbell",
            color: AppColors.grid,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
