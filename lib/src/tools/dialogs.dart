import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../mvc/model/enums.dart';
import '../extensions.dart';
import '../mvc/model/models_ui.dart';
import '../mvc/view/dialogs.dart';
import '../mvc/view/model_widgets.dart';
import '../mvc/view/screens.dart';
import '../tools.dart';

class Dialogs {
  final BuildContext context;

  Dialogs(this.context);

  static Dialogs of(BuildContext context) {
    assert(context.mounted);
    return Dialogs(context);
  }

  /// Shows a custom alert dialog, adaptive to screen size and also to dialog content.
  /// - [dialogState] : dialog type. It defaults to `DialogState.confirmation` if null.
  /// - [title] : dialog title. It defaults to `Confirmation` if null.
  /// - [subtitle] : dialog subtitle.
  /// - [continueLabel] : dialog main button label. It defaults to `Continue` if null.
  /// - [onContinue] : dialog main button onPressed behavior label.
  Future<void> showAlertDialog({
    DialogState? dialogState,
    String? title,
    required String subtitle,
    String? continueLabel,
    required void Function() onContinue,
  }) async {
    await context.showAdaptiveModalBottomSheet(
      builder: (_) => ConfirmationDialog(
        dialogState: dialogState ?? DialogState.confirmation,
        title: title,
        subtitle: subtitle,
        continueLabel: continueLabel ?? AppLocalizations.of(context)!.yes,
        cancelLabel: AppLocalizations.of(context)!.cancel,
        onContinue: onContinue,
      ),
    );
  }

  /// Shows a custom async alert dialog, adaptive to screen size and also to dialog content.
  /// Async meaning that we should show a loading indicator while waiting for onContinue to finish.
  /// - [dialogState] : dialog type. It defaults to `DialogState.confirmation` if null.
  /// - [title] : dialog title. It defaults to `Confirmation` if null.
  /// - [subtitle] : dialog subtitle.
  /// - [continueLabel] : dialog main button label.
  /// - [future] : dialog main button onPressed behavior label.
  /// - [onComplete] : execute this function after `future`.
  /// - [onError] : execute this function on `Exception` in `future`.
  /// - [messageOnComplete] : a message for snackbar to show after `onComplete`.
  Future<void> showAsyncAlertDialog<T>({
    DialogState? dialogState,
    String? title,
    required String subtitle,
    required String continueLabel,
    required Future<T> Function() future,
    void Function(T?)? onComplete,
    required String? messageOnComplete,
    void Function(Exception)? onError,
  }) async {
    await context.showAdaptiveModalBottomSheet(
      builder: (_) => ConfirmationFutureDialog(
        dialogState: dialogState ?? DialogState.confirmation,
        title: title,
        subtitle: subtitle,
        continueLabel: continueLabel,
        cancelLabel: AppLocalizations.of(context)!.cancel,
        onContinue: future,
        onComplete: onComplete,
        messageOnComplete: messageOnComplete,
        onError: onError,
      ),
    );
  }

  /// Show an alert adaptive dialog.
  /// - [isDismissible] : if `true, the dialog shouw be dissmisible by swiping down.
  /// - [enableDrag] : if `true, the dialog shouw be dragable.
  /// - [onComplete] : Execute after the dialog is dissmised.
  Future<void> showAdaptiveModalBottomSheet({
    required Widget Function(BuildContext) builder,
    bool isDismissible = true,
    bool enableDrag = true,
    void Function()? onComplete,
  }) async {
    await showModalBottomSheet(
      elevation: 0,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      context: context,
      builder: builder,
    ).whenComplete(onComplete ?? () {});
  }

  /// Show a dialog as a leading indicator.
  /// This dialog is used to block any user inputs until an async function finished.
  Future<void> showLoadingIndicator() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        onWillPop: () async => Future.value(false),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            CustomLoadingIndicator(
              margin: EdgeInsets.zero,
              isSliver: false,
            )
          ],
        ),
      ),
    );
  }

  /// Show the loading indicator while waiting for [future] function to finish.
  /// - [future] : An async funtion.
  /// - [onComplete] : Executre this function when `future` is finished.
  /// - [messageOnComplete] : show this message in a snackbar after `onComplete`.
  /// - [onError] : Execute on `Exception` in `future`.
  /// - [popOnError] : if `true`, pop the parent widget with `context` and close the screen.
  Future<T?> runAsyncAction<T>({
    required Future<T?> Function() future,
    void Function(T?)? onComplete,
    void Function(Exception)? onError,
    bool popOnError = false,
    String? messageOnComplete,
  }) async {
    try {
      showLoadingIndicator();
      return await future().then((result) {
        context.pop();
        if (onComplete != null) {
          onComplete(result);
        }
        if (!messageOnComplete.isNullOrEmpty) {
          context.showSnackBar(
            message: messageOnComplete!,
          );
        }
        return result;
      });
    } on Exception catch (e) {
      //pop loading widget
      context.pop();
      if (popOnError) {
        //if there is a dialog hehind, pop it
        context.pop();
      }
      if (onError != null) {
        onError(e);
      } else {
        try {
          rethrow;
        } on Exception catch (e) {
          if (kDebugMode) {
            print(e);
          }
          Dialogs.of(context).handleBackendException(
            exception: e,
          );
        }
      }
      return null;
    }
  }

  /// Show a dialog configured specifically for alerting the user to grant use of a permission.
  /// - [title] : dialog title.
  /// - [subtitle] : dialog subtitle.
  /// - [barrierDismissible] : if `true`, the dialog will be dissmisable by swiping down.
  Future<void> showPermissionDialog({
    required String title,
    required String subtitle,
    bool barrierDismissible = true,
  }) async {
    await context.showAdaptiveModalBottomSheet(
      builder: (_) => ConfirmationDialog(
        dialogState: DialogState.confirmation,
        title: title,
        subtitle: subtitle,
        continueLabel: AppLocalizations.of(context)!.close,
        onContinue: null,
      ),
    );
  }

  /// Show a snackbar message.
  /// - [message] : a message to show on the snackbar.
  /// - [duration] : show snackbar and dismiss it after duration (default to 4 seconds).
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar({
    required String message,
    Duration duration = const Duration(seconds: 4),
    double? paddingBottom,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Styles.green,
        duration: duration,
        content: Text(
          message,
          style: Styles.poppins(
            fontWeight: Styles.medium,
            fontSize: 16.sp,
            color: Colors.white,
          ),
        ),
        action: SnackBarAction(
          label: AppLocalizations.of(context)!.dismiss,
          onPressed: ScaffoldMessenger.of(context).hideCurrentSnackBar,
          textColor: Colors.white,
        ),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.fromLTRB(
          15.sp,
          5.sp,
          15.sp,
          paddingBottom ?? 10.sp,
        ),
      ),
    );
  }

  /// Handle backend [exception] and show an adaptive dialog explaining the problem.
  Future<void> handleBackendException({
    required Exception exception,
  }) async {
    // await context.showAdaptiveModalBottomSheet(
    //   builder: (_) => ConfirmationDialog(
    //     dialogState: DialogState.error,
    //     subtitle: exception is BookingHeroException
    //         ? exception.message
    //         : AppLocalizations.of(context)!.unknown_error,
    //     continueLabel: AppLocalizations.of(context)!.ignore_close,
    //     onContinue: null,
    //   ),
    // );
  }

  /// Shows a custom alert dialog with [title], [subtitle], [yesAct] button as
  /// a confirmation button, [noAct] as a cancel button, and [onComplete] function.
  Future<void> showCustomDialog<T>({
    required String title,
    required String subtitle,
    required ModelTextButton yesAct,
    ModelTextButton? noAct,
    void Function(T)? onComplete,
    List<Widget>? children,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () => Future.value(false),
          child: Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 32.sp),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.sp),
            ),
            child: CustomAlertDialog(
              title: title,
              subtitle: subtitle,
              yesAct: yesAct,
              noAct: noAct,
              onComplete: onComplete,
              children: children,
            ),
          ),
        );
      },
    );
  }

  Future<void> showSingleImageSlideShow(ImageProvider<Object> image) async {
    await showModalBottomSheet(
      context: context,
      builder: (_) => SingleImageSlideshow(
        image: image,
      ),
      backgroundColor: Colors.black,
      enableDrag: true,
      isScrollControlled: true,
      isDismissible: true,
    );
  }

  /// Shows a value picker dialog with
  /// dialog [title],
  /// [values] to pick one from,
  /// [initialvalue] initial picked value,
  /// [onPick] behavior
  /// [hintText] search text field hint,
  /// [searchable] if `true`, show a text field to search the values.
  /// [searchStartsWith]
  ///   - if `true`, search values and return those that start with the quesry test.
  ///   - if `false`, search values and return those that contain quesry test.
  Future<void> showSingleValuePickerDialog({
    required String title,
    required List<String> values,
    required String? initialvalue,
    String? hintText,
    bool searchable = false,
    bool searchStartsWith = false,
    required void Function(String) onPick,
  }) async {
    await context.showAdaptiveModalBottomSheet(
      builder: (context) => SingleValuePickerDialog(
        title: title,
        hintText: hintText,
        values: values,
        searchable: searchable,
        searchStartsWith: searchStartsWith,
        initialValue: initialvalue,
        mainAxisSize: MainAxisSize.min,
        physics: const ClampingScrollPhysics(),
        onPick: onPick,
      ),
    );
  }

  Future<void> showDialogAdsOptions() async {
    await context.showAdaptiveModalBottomSheet(
      builder: (_) => Container(
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
            top: Radius.circular(32.sp),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 5.sp,
              width: 150.sp,
              decoration: BoxDecoration(
                color: context.textTheme.displayMedium!.color,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            30.heightSp,
            CustomElevatedListTile(
              leadingIcon: AwesomeIcons.ads,
              title: AppLocalizations.of(context)!.promote,
              onTap: () {
                context.pop();
                //TODO promote ad
                // context.push(widget: ContactSupport());
              },
            ),
            16.heightSp,
            CustomElevatedListTile(
              leadingIcon: AwesomeIcons.pen_to_square,
              title: AppLocalizations.of(context)!.modify,
              onTap: () {
                context.pop();
                context.push(widget: const CreateAd());
              },
            ),
            16.heightSp,
            CustomElevatedListTile(
              leadingIcon: AwesomeIcons.trash_outlined,
              title: AppLocalizations.of(context)!.delete,
              leadingIconColor: Styles.red,
              onTap: () {
                context.pop();
                Dialogs.of(context).showCustomDialog(
                  title: AppLocalizations.of(context)!.warning,
                  subtitle: AppLocalizations.of(context)!.delete_ad_subtitle,
                  yesAct: ModelTextButton(
                    label: AppLocalizations.of(context)!.continu,
                    color: Styles.red,
                    onPressed: () {},
                  ),
                  noAct: ModelTextButton(
                    label: AppLocalizations.of(context)!.cancel,
                    fontColor: context.textTheme.displayLarge!.color,
                    color: Styles.red[50],
                  ),
                );
              },
            ),
            30.heightSp,
          ],
        ),
      ),
    );
  }
}
