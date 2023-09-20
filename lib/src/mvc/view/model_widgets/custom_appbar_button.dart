import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../extensions.dart';

class AppBarActionButton extends StatelessWidget {
  const AppBarActionButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(4.sp),
        constraints: BoxConstraints(
          minHeight: 48.sp,
          minWidth: 48.sp,
        ),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(
          icon,
          color: context.primaryColor,
          size: 20.sp,
        ),
      ),
    );
  }
}
