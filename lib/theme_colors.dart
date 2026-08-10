import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static TextStyle Function({TextStyle? textStyle, Color? color, Color? backgroundColor, double? fontSize, FontWeight? fontWeight, FontStyle? fontStyle, double? letterSpacing, double? wordSpacing, TextBaseline? textBaseline, double? height, Locale? locale, Paint? foreground, Paint? background, List<Shadow>? shadows, List<FontFeature>? fontFeatures, TextDecoration? decoration, Color? decorationColor, TextDecorationStyle? decorationStyle, double? decorationThickness}) fontStyle = GoogleFonts.geist;
  static const Color mainColor = Color(0xFF2C4E40);
  static const Color red = Color(0xFFEE2737);
  static const Color orange = Color(0xFFA16F44);
  static const Color blue = Color(0xFF00ADD6);
  static const Color white = Color(0xFFFFFFFF);
  static const Color pink = Color(0xFFDF1995);
  static const Color purple = Color(0xFF93328E);
  static const Color lightGrey = Color(0xFFBDBDBD);
  static const Color darkGrey = Color(0xFF646363);
  static const Color dark = Color(0xFF2F2828);
  
  static const List<Color> colorfulPalette = [
    mainColor,
    red,
    orange,
    blue,
    pink,
    purple,
  ];
}
