import 'package:flutter/material.dart';

class ImageUtils {

  static List<Image> loadPlayerIcons() {
    return [
      Image.asset('assets/images/kuromi.png'),
      Image.asset('assets/images/my_melody.png')
    ];
  }

  static List<Image> loadAllAvatars() {
    return [
      Image.asset('assets/images/kuromi.png'),
      Image.asset('assets/images/my_melody.png'),
      Image.asset('assets/images/pinguim.png'),
      Image.asset('assets/images/cinnamon.png'),
      Image.asset('assets/images/hello_kitty.png'),
      Image.asset('assets/images/keroppi.png'),
      Image.asset('assets/images/little_twin_stars.png'),
    ];
  }

  static Image getAvatarByIndex(int index) {
    final avatars = loadAllAvatars();
    if (index >= 0 && index < avatars.length) {
      return avatars[index];
    }
    return avatars[0];
  }
}
