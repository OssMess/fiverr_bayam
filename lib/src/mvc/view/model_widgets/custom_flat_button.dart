import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../extensions.dart';

class CustomFlatButton extends StatelessWidget {
  const CustomFlatButton({
    super.key,
    this.child,
    this.icon,
    this.color,
    this.addBorder = false,
    this.iconColor,
    this.iconSize,
    this.onTap,
  }) : assert(icon != null || child != null);

  final Widget? child;
  final IconData? icon;
  final double? iconSize;
  final Color? color;
  final bool addBorder;
  final Color? iconColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      child: Container(
        // alignment: Alignment.center,
        padding: EdgeInsets.all(10.sp),
        decoration: BoxDecoration(
          color: color ?? context.textTheme.headlineSmall!.color,
          border: addBorder
              ? Border.all(
                  color: context.textTheme.headlineMedium!.color!,
                  width: 0.5,
                )
              : null,
          borderRadius: BorderRadius.circular(8.sp),
        ),
        child: child ??
            Icon(
              icon,
              size: iconSize ?? 20.sp,
              color: iconColor,
            ),
      ),
    );
  }
}
