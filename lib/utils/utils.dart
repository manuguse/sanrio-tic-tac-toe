import 'package:flutter/material.dart';

class Utils {
  Utils._();

  static Image get defaultAvatar => Image.asset('assets/images/pinguim.png');
}

extension ColorExtension on Color {
  Color darker([double amount = 0.8]) {
    return Color.fromARGB(
      alpha,
      (red * (1 - amount)).toInt(),
      (green * (1 - amount)).toInt(),
      (blue * (1 - amount)).toInt(),
    );
  }

  Color lighter([double amount = 0.2]) {
    return Color.fromARGB(
      alpha,
      (red + ((255 - red) * amount)).toInt(),
      (green + ((255 - green) * amount)).toInt(),
      (blue + ((255 - blue) * amount)).toInt(),
    );
  }
}