import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../extensions.dart';

class CustomRectangleIconButton extends StatelessWidget {
  const CustomRectangleIconButton({
    super.key,
    required this.icon,
    this.color,
    this.iconSize,
    this.onTap,
  });

  final IconData icon;
  final double? iconSize;
  final Color? color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10.sp),
        margin: EdgeInsets.symmetric(horizontal: 8.sp),
        decoration: BoxDecoration(
          border: Border.all(
            color: context.textTheme.headlineMedium!.color!,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(8.sp),
        ),
        child: Icon(
          icon,
          size: iconSize ?? 30.sp,
          color: color,
        ),
      ),
    );
  }
}
