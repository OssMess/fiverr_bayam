import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../extensions.dart';
import '../../../tools.dart';
import '../model_widgets.dart';

class CustomElevatedListTile extends StatelessWidget {
  const CustomElevatedListTile({
    super.key,
    this.leadingIcon,
    required this.title,
    this.leadingIconColor,
    this.trailing,
    this.showContainerDecoration = true,
    this.showTrailing = true,
    required this.onTap,
    this.margin,
    this.padding,
  });

  final IconData? leadingIcon;
  final String title;
  final Color? leadingIconColor;
  final Widget? trailing;
  final bool showContainerDecoration;
  final bool showTrailing;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedContainer(
      onTap: onTap,
      margin: margin,
      padding: padding ?? EdgeInsets.all(12.sp),
      child: Row(
        children: [
          if (leadingIcon != null) ...[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(14.sp),
              decoration: showContainerDecoration
                  ? BoxDecoration(
                      color: Styles.green[50]!,
                      borderRadius: BorderRadius.circular(8.sp),
                    )
                  : null,
              child: Icon(
                leadingIcon,
                size: 28.sp,
                color: leadingIconColor ?? Styles.green,
              ),
            ),
            16.widthSp,
          ],
          Expanded(
            child: Text(
              title,
              style: Styles.poppins(
                fontSize: 16.sp,
                fontWeight: Styles.semiBold,
                color: context.textTheme.displayLarge!.color,
              ),
            ),
          ),
          if (showTrailing) ...[
            16.widthSp,
            trailing ??
                Icon(
                  Icons.keyboard_arrow_right_rounded,
                  size: 28.sp,
                  color: context.textTheme.headlineLarge!.color,
                ),
          ],
        ],
      ),
    );
  }
}
