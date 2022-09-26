import 'package:flutter/material.dart';

class ColorsManager {
  static const Color primaryColor = Color(0xff073b4c);
  static const Color accentColor = Color(0xff118ab2);
  static const Color accentColor2 = Color(0xff03045e);
  static const Color greyColor = Colors.grey;
  static const Color whiteColor = Colors.white;
  static const Color transarentColor = Colors.transparent;
  static const Color blackColor = Colors.black;

  static const List<Color> gradientColors = [
    ColorsManager.blackColor,
    ColorsManager.primaryColor,
  ];

  static const List<Color> gradientColors2 = [
    ColorsManager.accentColor2,
    ColorsManager.primaryColor,
  ];
}
