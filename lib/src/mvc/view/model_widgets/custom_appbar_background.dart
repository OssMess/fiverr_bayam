import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../extensions.dart';
import '../../../tools.dart';
import '../../model/enums.dart';

class CustomAppBarBackground extends StatelessWidget {
  const CustomAppBarBackground({
    super.key,
    required this.type,
    this.appBarTitle,
    this.appBarTitleWidget,
    this.appBarLeading,
    this.appBarActions,
    this.resizeToAvoidBottomInset = true,
  }) : assert(appBarTitle == null || appBarTitleWidget == null);

  final AppBarBackgroundType type;
  final String? appBarTitle;
  final Widget? appBarTitleWidget;
  final Widget? appBarLeading;
  final List<Widget>? appBarActions;
  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    double backgroundTopHeight = type.height(
      context,
      resizeToAvoidBottomInset,
    );
    Column column = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (showAppBar)
          Expanded(
            child: Image.asset(
              type.backgroundPngPath,
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomCenter,
              width: 1.sw,
            ),
          ),
      ],
    );
    return AnimatedContainer(
      duration: const Duration(milliseconds: 50),
      width: 1.sw,
      height: backgroundTopHeight,
      color: type.backgroundColor ?? context.scaffoldBackgroundColor,
      child: Stack(
        children: [
          column,
          if (type != AppBarBackgroundType.oval)
            Positioned(
              bottom: 0,
              width: 1.sw,
              child: Container(
                width: 1.sw,
                height: type == AppBarBackgroundType.expanded ? 30.sp : 20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: context.scaffoldBackgroundColor),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30.sp),
                  ),
                ),
              ),
            ),
          if (showAppBar) ...[
            if (type == AppBarBackgroundType.expanded)
              Positioned.fill(
                child: Center(
                  child: Image.asset(
                    'assets/images/logo_transparent.png',
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                    height: 110.h,
                    width: 110.h,
                  ),
                ),
              ),
            if (appBarTitle != null ||
                appBarLeading != null ||
                appBarActions != null)
              Container(
                margin: EdgeInsets.only(top: Paddings.viewPadding.top),
                height: kToolbarHeight,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          8.widthSp,
                          appBarLeading ?? 56.widthSp,
                        ],
                      ),
                    ),
                    appBarTitleWidget ??
                        Text(
                          appBarTitle ?? '',
                          style: Styles.poppins(
                            fontSize: 18.sp,
                            color: Colors.white,
                            fontWeight: Styles.semiBold,
                            height: 1.2,
                          ),
                        ),
                    // Expanded(
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       appBarTitleWidget ??
                    //           Text(
                    //             appBarTitle ?? '',
                    //             style: context.appBarTitleTextStyle,
                    //           ),
                    //     ],
                    //   ),
                    // ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ...appBarActions ?? [56.widthSp],
                          8.widthSp,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ],
      ),
    );
  }

  bool get showAppBar => Paddings.showAppBar || !resizeToAvoidBottomInset;
}
