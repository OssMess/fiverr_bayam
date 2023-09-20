import 'package:flutter/material.dart';
//to generate shades and tins
// https://maketintsandshades.com/#57C4A8

class Styles {
  static TextStyle poppins({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? height,
    TextOverflow? overflow,
  }) =>
      TextStyle(
        fontFamily: 'Poppins',
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        height: height,
        overflow: overflow,
      );

  static const MaterialColor yellow = MaterialColor(
    0xFFffb33e,
    <int, Color>{
      50: Color(0xFFfff7ec),
      100: Color(0xFFfff0d8),
      200: Color(0xFFffe8c5),
      300: Color(0xFFffe1b2),
      400: Color(0xFFffd99f),
      500: Color(0xFFffd18b),
      600: Color(0xFFffca78),
      700: Color(0xFFffc265),
      800: Color(0xFFffbb51),
      900: Color(0xFFffb33e),
    },
  );

  static const MaterialColor green = MaterialColor(
    0xFF23a994,
    <int, Color>{
      50: Color(0xFFe9f6f4),
      100: Color(0xFFd3eeea),
      200: Color(0xFFbde5df),
      300: Color(0xFFa7ddd4),
      400: Color(0xFF91d4ca),
      500: Color(0xFF7bcbbf),
      600: Color(0xFF65c3b4),
      700: Color(0xFF4fbaa9),
      800: Color(0xFF39b29f),
      900: Color(0xFF23a994),
    },
  );

  static const MaterialColor red = MaterialColor(
    0xFFfe6b28,
    <int, Color>{
      50: Color(0xFFfff0ea),
      100: Color(0xFFffe1d4),
      200: Color(0xFFffd3bf),
      300: Color(0xFFffc4a9),
      400: Color(0xFFffb594),
      500: Color(0xFFfea67e),
      600: Color(0xFFfe9769),
      700: Color(0xFFfe8953),
      800: Color(0xFFfe7a3e),
      900: Color(0xFFfe6b28),
    },
  );

  static const MaterialColor black = MaterialColor(
    0xFF000000,
    <int, Color>{
      50: Color(0xFFe6e6e6),
      100: Color(0xFFcccccc),
      200: Color(0xFFb3b3b3),
      300: Color(0xFF999999),
      400: Color(0xFF808080),
      500: Color(0xFF666666),
      600: Color(0xFF4d4d4d),
      700: Color(0xFF333333),
      800: Color(0xFF1a1a1a),
      900: Color(0xFF000000),
    },
  );

  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w900;
}
