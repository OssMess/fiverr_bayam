import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../extensions.dart';
import '../../../tools.dart';
import '../../model/models_ui.dart';
import '../model_widgets.dart';

/// shows an bottomsheet adaptive to its content, will take full screen
/// or only part of the screen
class AdaptiveBottomSheet extends StatelessWidget {
  const AdaptiveBottomSheet({
    super.key,
    required this.children,
    required this.continueAct,
    required this.cancelAct,
    required this.mainAxisSize,
  });

  /// continue button
  final ModelTextButton continueAct;

  /// cancel or no button. if `null`, don't show it
  final ModelTextButton? cancelAct;

  /// content of the bottom sheet
  final List<Widget> children;

  /// defines the size of the bottom sheet, `MainAxisSize.max` to take full screen,
  /// or `MainAxisSize.min` to take only part of the screen
  final MainAxisSize mainAxisSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.loose(
        Size(
          1.sw,
          1.sh - Paddings.viewPadding.top,
        ),
      ),
      padding: EdgeInsets.fromLTRB(
        35.w,
        5.h,
        35.w,
        min(30.h, 15.h + Paddings.viewPadding.bottom),
      ),
      decoration: BoxDecoration(
        color: context.scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(50.sp),
        ),
      ),
      child: Column(
        mainAxisSize: mainAxisSize,
        children: [
          Container(
            height: 5.sp,
            width: 150.sp,
            decoration: BoxDecoration(
              color: context.textTheme.displayMedium!.color,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          SizedBox(height: 10.sp),
          ...children,
          SizedBox(height: 40.sp),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (showTextButton) ...[
                Expanded(
                  child: CustomTextButton(
                    button: cancelAct!,
                  ),
                ),
                SizedBox(
                  height: 20.sp,
                  child: VerticalDivider(
                    color: context.textTheme.headlineMedium!.color,
                    width: 1.sp,
                    thickness: 1.sp,
                  ),
                ),
              ],
              Expanded(
                child: CustomTextButton(
                  button: continueAct,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.sp),
        ],
      ),
    );
  }

  bool get showTextButton => cancelAct != null;
}
