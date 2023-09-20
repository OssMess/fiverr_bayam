import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../extensions.dart';
import '../../model/enums.dart';

class CustomAppBarBackground extends StatelessWidget {
  const CustomAppBarBackground({
    super.key,
    required this.type,
  });

  final AppBarBackgroundType type;

  @override
  Widget build(BuildContext context) {
    double backgroundTopHeight = type.height(context);
    double backgroundTopPadding = type.topPadding(context);
    Column column = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: backgroundTopPadding,
          ),
        ),
        Expanded(
          child: Image.asset(
            'assets/images/background_top.png',
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
            width: 1.sw,
          ),
        ),
      ],
    );
    return Container(
      width: 1.sw,
      height: backgroundTopHeight,
      decoration: BoxDecoration(
        color: context.primary,
        borderRadius: type.borderRadius(),
      ),
      child: Stack(
        children: [
          column,
          if (type != AppBarBackgroundType.oval)
            Positioned(
              bottom: 0,
              width: 1.sw,
              child: Container(
                width: 1.sw,
                height: 20.sp,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30.sp),
                  ),
                ),
              ),
            ),
          if (type == AppBarBackgroundType.expanded)
            Positioned(
              top: context.viewPadding.top + 100.h,
              width: 1.sw,
              child: Image.asset(
                'assets/images/logo_transparent.png',
                fit: BoxFit.contain,
                alignment: Alignment.center,
                height: 100.h,
              ),
            ),
        ],
      ),
    );
  }
}
