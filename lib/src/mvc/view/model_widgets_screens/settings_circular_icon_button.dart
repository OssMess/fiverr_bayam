import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../extensions.dart';
import '../../../tools.dart';

class CircularIconButton extends StatelessWidget {
  const CircularIconButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12.sp),
            decoration: BoxDecoration(
              color: context.textTheme.headlineSmall!.color,
              shape: BoxShape.circle,
              border: Border.all(
                color: context.scaffoldBackgroundColor,
                width: 3.sp,
              ),
            ),
            child: Icon(
              icon,
              color: context.textTheme.displayMedium!.color,
              size: 24.sp,
            ),
          ),
          4.heightSp,
          Text(
            label,
            style: Styles.poppins(
              fontSize: 14.sp,
              fontWeight: Styles.medium,
              color: context.textTheme.displayMedium!.color,
            ),
          ),
        ],
      ),
    );
  }
}
