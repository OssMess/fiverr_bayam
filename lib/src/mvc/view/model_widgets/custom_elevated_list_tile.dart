import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../extensions.dart';
import '../../../tools.dart';
import '../model_widgets.dart';

class CustomElevatedListTile extends StatelessWidget {
  const CustomElevatedListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedContainer(
      onTap: onTap,
      padding: EdgeInsets.all(8.sp),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10.sp),
            decoration: BoxDecoration(
              color: Styles.green[50]!,
              borderRadius: BorderRadius.circular(8.sp),
            ),
            child: Icon(
              icon,
              size: 25.sp,
              color: Styles.green,
            ),
          ),
          16.widthSp,
          Expanded(
            child: Text(
              title,
              style: Styles.poppins(
                fontSize: 14.sp,
                fontWeight: Styles.bold,
                color: context.textTheme.displayLarge!.color,
              ),
            ),
          ),
          16.widthSp,
          Icon(
            Icons.keyboard_arrow_right_rounded,
            size: 20.sp,
            color: context.textTheme.headlineMedium!.color,
          ),
        ],
      ),
    );
  }
}
