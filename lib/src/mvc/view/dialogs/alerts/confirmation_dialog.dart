import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../extensions.dart';
import '../../../../tools.dart';
import '../../../model/enums.dart';
import '../../../model/models_ui.dart';
import '../../dialogs.dart';

/// An `AdaptiveBottomSheet` as an alert dialog with a title, subtitle, icon,
/// and two buttons, used to confirm simple actions, or to inform the user about
/// an event
class ConfirmationDialog<T> extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    required this.dialogState,
    this.title,
    required this.subtitle,
    required this.continueButton,
    this.cancelButton,
  });

  /// dialog state, can be `confirmation`, `success`, or `error`. it defines the
  /// color of continue button as well as the primary icon on the dialog.
  final DialogState dialogState;

  /// dialog main title
  final String? title;

  /// dialog subtitle
  final String subtitle;

  /// Continue button
  final ModelTextButton continueButton;

  /// Cancel button
  final ModelTextButton? cancelButton;

  @override
  Widget build(BuildContext context) {
    LottieAnimation lottieAnimation = dialogState.toLottieAnimation;
    String dialogTitle = title ?? dialogState.toStringTitle(context);
    return AdaptiveBottomSheet(
      mainAxisSize: MainAxisSize.min,
      continueButton: ModelTextButton(
        label: continueButton.label,
        color: continueButton.color,
        fontColor: continueButton.fontColor ??
            (cancelButton != null
                ? Styles.red
                : context.textTheme.displayMedium!.color),
        onPressed: () async {
          context.pop();
          if (continueButton.onPressed != null) {
            continueButton.onPressed!();
          }
        },
      ),
      cancelButton: cancelButton != null
          ? ModelTextButton(
              label: cancelButton!.label,
              color: cancelButton!.color,
              fontColor: cancelButton!.fontColor,
              onPressed: () async {
                context.pop();
                if (cancelButton!.onPressed != null) {
                  cancelButton!.onPressed!();
                }
              },
            )
          : null,
      children: [
        SizedBox(height: 15.sp),
        Center(
          child: LottieBuilder.asset(
            lottieAnimation.valueToString,
            height: 100.sp,
            width: 100.sp,
            fit: BoxFit.cover,
            alignment: Alignment.center,
            repeat: true,
          ),
        ),
        SizedBox(height: 30.sp),
        Text(
          dialogTitle,
          style: Styles.poppins(
            fontSize: 22.sp,
            fontWeight: Styles.bold,
            color: context.textTheme.displayLarge!.color,
          ),
        ),
        SizedBox(height: 20.sp),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: Styles.poppins(
            fontSize: 16.sp,
            fontWeight: Styles.medium,
            color: context.textTheme.displayMedium!.color,
          ),
        ),
      ],
    );
  }
}
