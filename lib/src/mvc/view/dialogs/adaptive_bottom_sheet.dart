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
    required this.continueButton,
    required this.cancelButton,
    required this.mainAxisSize,
  });

  /// continue button
  final ModelTextButton continueButton;

  /// cancel or no button. if `null`, don't show it
  final ModelTextButton? cancelButton;

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
        context.viewInsets.bottom > 0
            ? 0
            : min(30.h, 15.h + Paddings.viewPadding.bottom),
      ),
      margin: EdgeInsets.only(
        bottom: context.viewInsets.bottom,
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
          10.heightSp,
          ...children,
          20.heightSp,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (showTextButton) ...[
                Expanded(
                  child: CustomTextButton(
                    button: cancelButton!,
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
                  button: continueButton,
                ),
              ),
            ],
          ),
          20.heightSp,
        ],
      ),
    );
  }

  bool get showTextButton => cancelButton != null;
}
