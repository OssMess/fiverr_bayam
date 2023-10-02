import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../extensions.dart';
import '../../../tools.dart';
import '../../model/enums.dart';
import '../model_widgets.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    super.key,
    required this.category,
    required this.onTap,
  });

  final Category category;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedContainer(
      onTap: onTap,
      padding: EdgeInsets.all(12.sp),
      child: Row(
        children: [
          Container(
            width: 64.sp,
            height: 64.sp,
            padding: EdgeInsets.all(12.sp),
            decoration: BoxDecoration(
              color: Styles.green[50],
              borderRadius: BorderRadius.circular(8.sp),
            ),
            child: Icon(
              category.icon,
              color: Styles.green,
              size: 40.sp,
            ),
          ),
          12.widthSp,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.translateTitle(context),
                  style: Styles.poppins(
                    fontSize: 15.sp,
                    fontWeight: Styles.semiBold,
                    color: context.textTheme.displayLarge!.color,
                  ),
                ),
                Text(
                  category.translateSubtitle(context),
                  style: Styles.poppins(
                    fontSize: 12.sp,
                    fontWeight: Styles.medium,
                    color: context.textTheme.displayMedium!.color,
                  ),
                ),
              ],
            ),
          ),
          12.widthSp,
          Icon(
            Icons.keyboard_arrow_right_rounded,
            size: 24.sp,
            color: context.textTheme.headlineLarge!.color,
          ),
        ],
      ),
    );
  }
}
