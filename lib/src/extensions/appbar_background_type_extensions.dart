import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../mvc/model/enums.dart';
import '../tools.dart';

extension AppBarBackgroundTypeExtensions on AppBarBackgroundType {
  double height(BuildContext context) => {
        AppBarBackgroundType.shrink:
            Paddings.viewPadding.top + kToolbarHeight + 30.h,
        AppBarBackgroundType.expanded:
            Paddings.viewPadding.top + kToolbarHeight + 0.15.sh,
        AppBarBackgroundType.oval:
            Paddings.viewPadding.top + kToolbarHeight + 0.3.sh,
      }[this]!;

  double topPadding(BuildContext context) => {
        AppBarBackgroundType.shrink: Paddings.viewPadding.top + 15.h,
        AppBarBackgroundType.expanded: Paddings.viewPadding.top + 50.h,
        AppBarBackgroundType.oval: Paddings.viewPadding.top + 100.h,
      }[this]!;

  BorderRadiusGeometry borderRadius() {
    switch (this) {
      case AppBarBackgroundType.oval:
        return BorderRadius.vertical(
          bottom: Radius.elliptical(300.sp, 200.sp),
        );
      default:
        return BorderRadius.zero;
    }
  }
}
