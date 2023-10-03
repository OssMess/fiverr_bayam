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
    required this.continueLabel,
    this.onContinue,
    this.cancelLabel,
  });

  /// dialog state, can be `confirmation`, `success`, or `error`. it defines the
  /// color of continue button as well as the primary icon on the dialog.
  final DialogState dialogState;

  /// dialog main title
  final String? title;

  /// dialog subtitle
  final String subtitle;

  /// continue button label
  final String continueLabel;

  /// continue button onPressed behavior. a Future function with a return type of `T`.
  final void Function()? onContinue;

  /// cancel button label
  final String? cancelLabel;

  @override
  Widget build(BuildContext context) {
    LottieAnimation lottieAnimation = dialogState.toLottieAnimation;
    String dialogTitle = title ?? dialogState.toStringTitle(context);
    return AdaptiveBottomSheet(
      mainAxisSize: MainAxisSize.min,
      continueAct: ModelTextButton(
        label: continueLabel,
        fontColor: cancelLabel != null
            ? Styles.red
            : context.textThemeDisplayMedium!.color,
        onPressed: () async {
          context.pop();
          if (onContinue != null) {
            onContinue!();
          }
        },
      ),
      cancelAct: cancelLabel != null
          ? ModelTextButton(
              label: cancelLabel!,
              onPressed: () => context.pop(),
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
            fontSize: 14.sp,
            fontWeight: Styles.medium,
            color: context.textTheme.displayMedium!.color,
          ),
        ),
      ],
    );
  }
}
