import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../extensions.dart';
import '../../../../tools.dart';
import '../../../model/models_ui.dart';
import '../../model_widgets.dart';

class CustomAlertDialog<T> extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    this.header,
    this.headerColor,
    required this.title,
    this.subtitle,
    required this.yesAct,
    this.noAct,
    this.children,
    this.onComplete,
  }) : assert(header != null || subtitle != null);

  final String? header;
  final Color? headerColor;
  final String title;
  final String? subtitle;
  final ModelTextButton yesAct;
  final ModelTextButton? noAct;
  final List<Widget>? children;
  final void Function(T)? onComplete;

  @override
  Widget build(BuildContext context) {
    double width = 1.sw - 24.w * 2;
    return Padding(
      padding: EdgeInsets.zero,
      // padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 40.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!header.isNullOrEmpty)
            Stack(
              children: [
                Container(
                  height: 130.sp,
                  width: width,
                  color: headerColor ?? Styles.green,
                ),
                Positioned(
                  bottom: 0,
                  width: width,
                  height: 80.sp,
                  child: Image.asset(
                    'assets/images/background_top.png',
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter,
                    width: width,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  width: width,
                  child: Container(
                    height: 20.sp,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(14.sp),
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.sp),
                    alignment: Alignment.center,
                    child: Text(
                      header!,
                      textAlign: TextAlign.center,
                      style: Styles.poppins(
                        fontSize: 14.sp,
                        fontWeight: Styles.medium,
                        color: context.textTheme.displayLarge!.color,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          // const SizedBox(width: double.infinity),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 40.sp),
            child: Column(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Styles.poppins(
                    fontSize: 20.sp,
                    fontWeight: Styles.semiBold,
                    color: context.textTheme.displayLarge!.color,
                  ),
                ),
                if (!subtitle.isNullOrEmpty) ...[
                  24.heightSp,
                  Text(
                    subtitle!,
                    textAlign: TextAlign.center,
                    style: Styles.poppins(
                      fontSize: 16.sp,
                      fontWeight: Styles.regular,
                      color: context.textTheme.displayLarge!.color,
                    ),
                  ),
                ],
                if (children != null) ...[
                  12.heightSp,
                  ...children!,
                ],
                32.heightSp,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (noAct != null)
                      CustomElevatedButton(
                        label: noAct!.label,
                        color: noAct!.color,
                        fontColor: noAct!.fontColor,
                        elevation: 0,
                        fontSize: 16.sp,
                        minimumSize: Size(0.3.sw, 50.sp),
                        maximumSize: Size(0.38.sw, 50.sp),
                        // fixedSize: Size(0.35.sw, 50.sp),
                        onPressed: () {
                          context.pop();
                          if (noAct!.onPressed != null) {
                            noAct!.onPressed!();
                          }
                        },
                      ),
                    16.widthW,
                    CustomElevatedButton(
                      label: yesAct.label,
                      color: yesAct.color,
                      fontColor: yesAct.fontColor,
                      elevation: 0,
                      fontSize: 16.sp,
                      minimumSize: Size(0.3.sw, 50.sp),
                      maximumSize: Size(0.38.sw, 50.sp),
                      // fixedSize: Size(noAct != null ? 0.35.sw : 0.4.sw, 50.sp),
                      onPressed: () {
                        context.pop();
                        dynamic result;
                        if (yesAct.onPressed != null) {
                          result = yesAct.onPressed!();
                        }
                        if (onComplete != null) {
                          onComplete!(result);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
