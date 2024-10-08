import 'dart:async';

import 'package:flutter/material.dart';

class ModelTextButton<T> {
  final String label;
  final FutureOr<T> Function()? onPressed;
  final Color? fontColor;
  final Color? color;
  final IconData? icon;

  ModelTextButton({
    required this.label,
    this.onPressed,
    this.fontColor,
    this.color,
    this.icon,
  });
}
