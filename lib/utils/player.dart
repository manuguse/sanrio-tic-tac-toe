import 'package:flutter/material.dart';

class Player {
  final String name;
  final Image defaultImage;

  Player({
    required this.name,
    required this.defaultImage,
  });

  String get getName => name;
  Image get getDefaultImage => defaultImage;

  set setName(String name) => name;
  set setDefaultImage(Image defaultImage) => defaultImage;
}