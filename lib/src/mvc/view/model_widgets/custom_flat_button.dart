import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../extensions.dart';

class CustomFlatButton extends StatelessWidget {
  const CustomFlatButton({
    super.key,
    this.child,
    this.icon,
    this.color,
    this.border,
    this.iconColor,
    this.iconSize,
    this.onTap,
  }) : assert(icon != null || child != null);

  final Widget? child;
  final IconData? icon;
  final double? iconSize;
  final Color? color;
  final BoxBorder? border;
  final Color? iconColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10.sp),
        // margin: EdgeInsets.symmetric(horizontal: 8.sp),
        decoration: BoxDecoration(
          color: color,
          border: border ??
              Border.all(
                color: context.textTheme.headlineMedium!.color!,
                width: 0.5,
              ),
          borderRadius: BorderRadius.circular(8.sp),
        ),
        child: Icon(
          icon,
          size: iconSize ?? 30.sp,
          color: iconColor,
        ),
      ),
    );
  }
}
