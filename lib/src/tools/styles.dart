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
    TextDecoration? textDecoration,
  }) =>
      TextStyle(
        fontFamily: 'Poppins',
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        height: height,
        overflow: overflow,
        decoration: textDecoration,
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
    0xFF619B2F,
    <int, Color>{
      50: Color(0xFFeff5ea),
      100: Color(0xFFdfebd5),
      300: Color(0xFFc0d7ac),
      400: Color(0xFFb0cd97),
      500: Color(0xFFa0c382),
      600: Color(0xFF90b96d),
      700: Color(0xFF81af59),
      800: Color(0xFF71a544),
      200: Color(0xFFd0e1c1),
      900: Color(0xFFe9f6f4),
    },
  );

  static const MaterialColor red = MaterialColor(
    0xFFD05439,
    <int, Color>{
      50: Color(0xFFfaeeeb),
      100: Color(0xFFf6ddd7),
      200: Color(0xFFf1ccc4),
      300: Color(0xFFecbbb0),
      400: Color(0xFFe8aa9c),
      500: Color(0xFFe39888),
      600: Color(0xFFde8774),
      700: Color(0xFFd97661),
      800: Color(0xFFd5654d),
      900: Color(0xFFD05439),
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

  static const MaterialColor blue = MaterialColor(
    0xFF0074D9,
    <int, Color>{},
  );

  static const MaterialColor orange = MaterialColor(
    0xFFFE9200,
    <int, Color>{},
  );

  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w900;
}
