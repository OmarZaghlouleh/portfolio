import 'package:flutter/material.dart';
import 'package:portfolio/Data%20Managers/colors_manager.dart';
import 'package:portfolio/Data%20Managers/fonts_manager.dart';
import 'package:portfolio/Data%20Managers/styles_manager.dart';

class ThemeManager {
  static ThemeData getLightTheme() {
    return ThemeData(
      scaffoldBackgroundColor: ColorsManager.transarentColor,
      scrollbarTheme: ScrollbarThemeData(
          thumbColor: MaterialStateProperty.all(ColorsManager.accentColor)),
      textTheme: TextTheme(
        headline1: TextStyleManager.getSemiBoldStyle(
            ColorsManager.accentColor, FontsSize.s30),
        headline2: TextStyleManager.getLightStyle(
            ColorsManager.whiteColor, FontsSize.s30),
        headline3: TextStyleManager.getSemiBoldStyle(
            ColorsManager.whiteColor, FontsSize.s20),
        headline4: TextStyleManager.getMediumStyle(
            ColorsManager.greyColor, FontsSize.s25),
        subtitle1: TextStyleManager.getLightStyle(
            ColorsManager.accentColor, FontsSize.s15),
        subtitle2: TextStyleManager.getLightStyle(
            ColorsManager.greyColor, FontsSize.s15),
        labelMedium: TextStyleManager.getLightStyle(
            ColorsManager.whiteColor, FontsSize.s15),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          overlayColor:
              MaterialStateProperty.all(ColorsManager.transarentColor),
          textStyle: MaterialStateProperty.all(
            TextStyleManager.getLightStyle(
                ColorsManager.whiteColor, FontsSize.s15),
          ),
        ),
      ),
    );
  }
}
