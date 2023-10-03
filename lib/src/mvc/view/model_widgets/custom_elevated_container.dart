import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../extensions.dart';

class CustomElevatedContainer extends StatelessWidget {
  const CustomElevatedContainer({
    super.key,
    required this.child,
    this.width,
    this.onTap,
    this.height,
    this.color,
    this.borderRadius,
    this.margin,
    this.padding,
  });

  final Widget child;
  final void Function()? onTap;
  final double? width;
  final double? height;
  final Color? color;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          color: color ?? context.scaffoldBackgroundColor,
          borderRadius: borderRadius ?? BorderRadius.circular(14.sp),
          boxShadow: [
            BoxShadow(
              color: context.textTheme.headlineMedium!.color!.withOpacity(0.5),
              offset: const Offset(0.0, 2.0),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
