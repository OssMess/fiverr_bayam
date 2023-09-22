import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
    this.height,
    this.padding,
    this.color,
  });

  final double? height;
  final EdgeInsetsGeometry? padding;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Divider(
        height: height ?? 1.sp,
        color: color ?? Theme.of(context).textTheme.headlineSmall!.color,
        thickness: 1,
      ),
    );
  }
}
