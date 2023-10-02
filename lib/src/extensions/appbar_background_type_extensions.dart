import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../mvc/model/enums.dart';
import '../tools.dart';

extension AppBarBackgroundTypeExtensions on AppBarBackgroundType {
  Color? get backgroundColor => {
        AppBarBackgroundType.shrink: Styles.green,
        AppBarBackgroundType.expanded: Styles.green,
      }[this];

  String get backgroundPngPath => {
        AppBarBackgroundType.shrink: 'assets/images/appbar_shrink.png',
        AppBarBackgroundType.expanded: 'assets/images/appbar_expanded.png',
        AppBarBackgroundType.oval: 'assets/images/appbar_oval.png',
      }[this]!;
  double height(
    BuildContext context,
    bool resizeToAvoidBottomInset,
  ) =>
      !resizeToAvoidBottomInset || Paddings.showAppBar
          ? {
              AppBarBackgroundType.shrink:
                  Paddings.viewPadding.top + kToolbarHeight + 30.h,
              AppBarBackgroundType.expanded:
                  Paddings.viewPadding.top + kToolbarHeight + 0.15.sh,
              AppBarBackgroundType.oval:
                  Paddings.viewPadding.top + kToolbarHeight + 0.25.sh,
            }[this]!
          : Paddings.viewPadding.top + 20.sp;
}
