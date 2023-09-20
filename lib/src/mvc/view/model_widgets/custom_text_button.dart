import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../extensions.dart';
import '../../../tools.dart';
import '../../model/models_ui.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.button,
    this.fontSize,
    this.enabled = true,
  });

  final ModelTextButton button;
  final double? fontSize;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    var textColor = enabled && button.onPressed != null
        ? (button.fontColor ?? context.textTheme.displayLarge!.color)
        : Colors.grey;
    var text = Text(
      button.label,
      style: Styles.poppins(
        fontSize: fontSize ?? 16.sp,
        color: textColor,
        fontWeight: Styles.medium,
      ),
    );
    if (button.icon == null) {
      return TextButton(
        onPressed: enabled ? button.onPressed : null,
        child: text,
      );
    }
    return TextButton.icon(
      onPressed: button.onPressed,
      icon: Icon(
        button.icon,
        color: textColor,
        size: 24.sp,
      ),
      label: text,
    );
  }
}
