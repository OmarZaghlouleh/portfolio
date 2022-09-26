import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyleManager {
  static TextStyle getLightStyle(Color color, double fontSize) {
    return GoogleFonts.righteous(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w300,
    );
  }

  static TextStyle getRegularStyle(Color color, double fontSize) {
    return GoogleFonts.righteous(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle getMediumStyle(Color color, double fontSize) {
    return GoogleFonts.righteous(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle getSemiBoldStyle(Color color, double fontSize) {
    return GoogleFonts.righteous(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle getBoldStyle(Color color, double fontSize) {
    return GoogleFonts.righteous(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
    );
  }
}
