import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension NumExtensions on num {
  /// return `true` if a number `this` is between two numbers `a` and `b `.
  bool isBetween(num a, num b) {
    return !((a >= this && b > this) || (a < this && b < this));
  }

  Widget get heightSp => SizedBox(height: sp);

  Widget get heightH => SizedBox(height: h);

  Widget get heightW => SizedBox(height: w);

  Widget get widthSp => SizedBox(width: sp);

  Widget get widthH => SizedBox(width: h);

  Widget get widthW => SizedBox(width: w);
}
