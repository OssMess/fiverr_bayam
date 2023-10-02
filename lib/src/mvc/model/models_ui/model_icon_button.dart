import 'package:flutter/material.dart';

class ModelIconButton<T> {
  final T Function()? onPressed;
  final Color? color;
  final double? size;
  final IconData icon;

  ModelIconButton({
    this.onPressed,
    this.size,
    this.color,
    required this.icon,
  });
}
