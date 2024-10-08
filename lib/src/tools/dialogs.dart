import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../mvc/model/enums.dart';
import '../extensions.dart';
import '../mvc/model/models.dart';
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
        continueButton: ModelTextButton(
          label: continueLabel ?? AppLocalizations.of(context)!.yes,
          onPressed: onContinue,
        ),
        cancelButton: ModelTextButton(
          label: AppLocalizations.of(context)!.cancel,
        ),
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
        continueButton: ModelTextButton(
          label: continueLabel,
          onPressed: future,
        ),
        cancelButton: ModelTextButton(
          label: AppLocalizations.of(context)!.cancel,
        ),
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
      builder: (_) => const PopScope(
        canPop: false,
        child: Column(
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
        } on BackendException catch (e) {
          if (kDebugMode) {
            print(e.code);
          }
          Dialogs.of(context).handleBackendException(
            exception: e,
          );
        } on Exception catch (e) {
          if (kDebugMode) {
            print(e);
          }
          Dialogs.of(context).handleBackendException(
            exception: BackendException(
              code: '',
              statusCode: 0,
            ),
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
    required String imagePath,
    required String buttonLabel,
    required void Function() onPressendButton,
    bool barrierDismissible = true,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.sp),
          ),
          child: CustomAlertDialog(
            header: subtitle,
            title: title,
            yesAct: ModelTextButton(
              label: buttonLabel,
              onPressed: onPressendButton,
              color: Styles.red,
              fontColor: Colors.white,
            ),
            children: [
              Container(
                padding: EdgeInsets.all(16.sp),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Styles.green[400],
                ),
                child: Image.asset(
                  imagePath,
                  width: 40.sp,
                  height: 40.sp,
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                ),
              ),
            ],
          ),
        );
      },
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
    required BackendException exception,
  }) async {
    Dialogs.of(context).showCustomDialog(
      header: AppLocalizations.of(context)!.error_contact_support,
      headerColor: Styles.red,
      title: AppLocalizations.of(context)!.failed,
      subtitle: Functions.of(context).translateException(exception),
      yesAct: ModelTextButton(
        label: AppLocalizations.of(context)!.close,
        color: Styles.green,
      ),
    );
    // await context.showAdaptiveModalBottomSheet(
    //   builder: (_) => ConfirmationDialog(
    //     dialogState: DialogState.error,
    //     subtitle: Functions.of(context).translateException(exception),
    //     continueButton: ModelTextButton(
    //       label: AppLocalizations.of(context)!.close,
    //       fontColor: Styles.red,
    //     ),
    //   ),
    // );
  }

  /// Shows a custom alert dialog with [title], [subtitle], [yesAct] button as
  /// a confirmation button, [noAct] as a cancel button, and [onComplete] function.
  Future<void> showCustomDialog<T>({
    String? header,
    Color? headerColor,
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
        return PopScope(
          canPop: false,
          child: Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.sp),
            ),
            child: CustomAlertDialog(
              header: header,
              headerColor: headerColor,
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

  Future<void> showMultiImageSlideShow({
    required List<ImageProvider<Object>> images,
    required int initialPage,
  }) async {
    await showModalBottomSheet(
      context: context,
      builder: (_) => MultiImageSlideshow(
        images: images,
        initialPage: initialPage,
      ),
      backgroundColor: Colors.black,
      enableDrag: true,
      isScrollControlled: true,
      isDismissible: true,
    );
  }

  Future<void> showProfileImageSlideShow(ImageProvider<Object> image) async {
    await showModalBottomSheet(
      context: context,
      builder: (_) => ProfileImageSlideshow(
        image: image,
      ),
      backgroundColor: Colors.transparent,
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
    required MainAxisSize mainAxisSize,
  }) async {
    await context.showAdaptiveModalBottomSheet(
      builder: (context) => SingleValuePickerDialog(
        title: title,
        hintText: hintText,
        values: values,
        searchable: searchable,
        searchStartsWith: searchStartsWith,
        initialValue: initialvalue,
        mainAxisSize: mainAxisSize,
        physics: const ClampingScrollPhysics(),
        onPick: onPick,
      ),
    );
  }

  Future<void> showTextValuePickerDialog({
    required String title,
    required String? initialvalue,
    required String hintText,
    bool showPasteButton = false,
    required void Function(String?) onPick,
    String? Function(String?)? validator,
    int? maxLines,
    int? maxLength,
    TextInputType? textInputType,
  }) async {
    await context.showAdaptiveModalBottomSheet(
      builder: (context) => TextValuePickerDialog(
        title: title,
        hintText: hintText,
        initialValue: initialvalue,
        showPasteButton: showPasteButton,
        mainAxisSize: MainAxisSize.min,
        onPick: onPick,
        validator: validator,
        maxLines: maxLines,
        maxLength: maxLength,
        textInputType: textInputType,
      ),
    );
  }

  Future<void> showDialogAdsOptions(
    BuildContext parentContent,
    UserSession userSession,
    Ad ad,
  ) async {
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
                parentContent.push(
                  widget: PromoteSubscribe(
                    userSession: userSession,
                    ad: ad,
                  ),
                );
              },
            ),
            16.heightSp,
            CustomElevatedListTile(
              leadingIcon: AwesomeIcons.pen_to_square,
              title: AppLocalizations.of(context)!.modify,
              onTap: () {
                context.pop();
                parentContent.push(
                  widget: CreateAd(
                    userSession: userSession,
                    ad: ad,
                  ),
                );
              },
            ),
            16.heightSp,
            CustomElevatedListTile(
              leadingIcon: AwesomeIcons.trash_outlined,
              title: AppLocalizations.of(context)!.delete,
              leadingIconColor: Styles.red,
              onTap: () {
                context.pop();
                Dialogs.of(parentContent).showCustomDialog(
                  title: AppLocalizations.of(context)!.warning,
                  subtitle: AppLocalizations.of(context)!.delete_ad_subtitle,
                  yesAct: ModelTextButton(
                    label: AppLocalizations.of(context)!.continu,
                    color: Styles.red,
                    onPressed: () {
                      Dialogs.of(parentContent).runAsyncAction(
                        future: () async {
                          await ad.delete(userSession);
                        },
                        onComplete: (_) {
                          Dialogs.of(context).showCustomDialog(
                            header: AppLocalizations.of(context)!
                                .error_contact_support,
                            title: AppLocalizations.of(context)!.success,
                            subtitle: AppLocalizations.of(context)!.ad_deleted,
                            yesAct: ModelTextButton(
                              label: AppLocalizations.of(context)!.close,
                              color: Styles.green,
                            ),
                          );
                        },
                      );
                    },
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
