// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

extension IntExtensions on int {
  /// get time format ``MM:HH` from `minutes`.
  ///
  /// - e.g. `430` in minutes is `08:13`
  String get toTimeFormat {
    return '${NumberFormat('00').format(this ~/ 60)}:${NumberFormat('00').format(this % 60)}';
  }

  Widget get heightSp => SizedBox(height: this.sp);

  Widget get heightH => SizedBox(height: this.h);

  Widget get heightW => SizedBox(height: this.w);

  Widget get widthSp => SizedBox(width: this.sp);

  Widget get widthH => SizedBox(width: this.h);

  Widget get widthW => SizedBox(width: this.w);
}
