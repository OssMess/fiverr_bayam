import 'package:bayam/src/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBackgroundTop extends StatelessWidget {
  const CustomBackgroundTop({
    super.key,
    this.showLogo = false,
    this.height,
    this.addTopPadding,
  });

  final bool showLogo;
  final double? height;
  final double? addTopPadding;

  @override
  Widget build(BuildContext context) {
    Column column = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: context.viewPadding.top + (addTopPadding ?? 100.h),
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
      height: height ?? 0.4.sh,
      decoration: BoxDecoration(
        color: context.primary,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.elliptical(300, 200),
        ),
      ),
      child: showLogo
          ? Stack(
              children: [
                column,
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
            )
          : column,
    );
  }
}
