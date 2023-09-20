import 'package:flutter/material.dart';

class ModelTextButton {
  final String label;
  final void Function()? onPressed;
  final Color? fontColor;
  final IconData? icon;

  ModelTextButton({
    required this.label,
    required this.onPressed,
    this.fontColor,
    this.icon,
  });
}
