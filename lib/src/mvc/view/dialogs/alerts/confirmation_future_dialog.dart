import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';

import '../../../../extensions.dart';
import '../../../../tools.dart';
import '../../../model/enums.dart';
import '../../../model/models_ui.dart';
import '../adaptive_bottom_sheet.dart';

/// An `AdaptiveBottomSheet` as an alert dialog with a title, subtitle, icon,
/// and two buttons, used to confirm async actions, or to inform the user about
/// after an async event
class ConfirmationFutureDialog<T> extends StatelessWidget {
  const ConfirmationFutureDialog({
    super.key,
    required this.dialogState,
    this.title,
    required this.subtitle,
    required this.continueLabel,
    required this.onContinue,
    this.cancelLabel,
    this.onComplete,
    required this.messageOnComplete,
    this.onError,
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
  final Future<T> Function() onContinue;

  /// cancel button label
  final String? cancelLabel;

  /// takes the result of the async function `onContinue` to perform a behavior.
  final void Function(T?)? onComplete;

  /// a message to show in a snackbar on completion
  final String? messageOnComplete;

  /// handle exception in `onContinue`.
  final void Function(Exception)? onError;

  @override
  Widget build(BuildContext context) {
    Color primary = dialogState.toColorPrimary;
    LottieAnimation lottieAnimation = dialogState.toLottieAnimation;
    String dialogTitle = title ?? dialogState.toStringTitle(context);
    return AdaptiveBottomSheet(
      mainAxisSize: MainAxisSize.min,
      continueAct: ModelTextButton(
        label: continueLabel,
        fontColor: primary,
        onPressed: () async {
          await Dialogs.of(context).runAsyncAction(
            future: onContinue,
            onComplete: (value) {
              context.pop();
              if (onComplete != null) {
                onComplete!(value);
              }
              if (!messageOnComplete.isNullOrEmpty) {
                context.showSnackBar(
                  message: messageOnComplete!,
                );
              }
            },
            onError: onError,
            popOnError: true,
          );
        },
      ),
      cancelAct: ModelTextButton(
        label: cancelLabel ?? AppLocalizations.of(context)!.close,
        onPressed: () => context.pop(),
      ),
      children: [
        SizedBox(height: 30.sp),
        Center(
          child: LottieBuilder.asset(
            lottieAnimation.valueToString,
            height: 100.sp,
            width: 100.sp,
            fit: BoxFit.fitWidth,
            alignment: Alignment.center,
            repeat: true,
          ),
        ),
        SizedBox(height: 45.sp),
        Text(
          dialogTitle,
          style: Styles.poppins(
            fontSize: 22.sp,
            fontWeight: Styles.bold,
            color: context.textTheme.displayLarge!.color,
          ),
        ),
        SizedBox(height: 20.sp),
        SizedBox(
          height: 60.sp,
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: Styles.poppins(
              fontSize: 18.sp,
              fontWeight: Styles.medium,
              color: context.textTheme.displayLarge!.color,
            ),
          ),
        ),
      ],
    );
  }
}
