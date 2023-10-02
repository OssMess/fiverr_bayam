import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../extensions.dart';
import '../../../model/enums.dart';
import '../../model_widgets.dart';
import '../../../../tools.dart';
import '../../model_widgets_screens.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final GlobalKey<FormState> _keyForm = GlobalKey();
  String? oldPassword, newPassword, checkNewPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: CustomElevatedButton(
        onPressed: next,
        label: AppLocalizations.of(context)!.confirm,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBarBackground(
            type: AppBarBackgroundType.shrink,
            appBarTitleWidget: const CustomAppBarLogo(),
            appBarLeading: AppBarActionButton(
              icon: context.backButtonIcon,
              onTap: context.pop,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.sp),
                child: Form(
                  key: _keyForm,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SettingsHeaderSubtitle(
                        title: AppLocalizations.of(context)!.change_password,
                      ),
                      16.heightSp,
                      CustomTextFormFieldLabel(
                        initialValue: null,
                        labelText:
                            AppLocalizations.of(context)!.current_password,
                        hintText:
                            AppLocalizations.of(context)!.current_password_hint,
                        keyboardType: TextInputType.name,
                        validator: Validators.validateNotNull,
                        onSave: (value) {
                          oldPassword = value;
                        },
                      ),
                      CustomTextFormFieldLabel(
                        initialValue: null,
                        labelText: AppLocalizations.of(context)!.new_password,
                        hintText:
                            AppLocalizations.of(context)!.new_password_hint,
                        keyboardType: TextInputType.name,
                        validator: Validators.validateNotNull,
                        onSave: (value) {
                          newPassword = value;
                        },
                      ),
                      CustomTextFormFieldLabel(
                        initialValue: null,
                        labelText:
                            AppLocalizations.of(context)!.check_new_password,
                        hintText: AppLocalizations.of(context)!
                            .check_new_password_hint,
                        keyboardType: TextInputType.name,
                        validator: Validators.validateNotNull,
                        onSave: (value) {
                          checkNewPassword = value;
                        },
                      ),
                      16.heightSp,
                      Container(
                        padding: EdgeInsets.all(16.sp),
                        decoration: BoxDecoration(
                          color: Styles.green[50],
                          borderRadius: BorderRadius.circular(14.sp),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!
                              .check_information_confirm,
                          textAlign: TextAlign.center,
                          style: Styles.poppins(
                            fontSize: 16.sp,
                            fontWeight: Styles.medium,
                            color: Styles.green,
                          ),
                        ),
                      ),
                      (context.viewPadding.bottom + 20.sp).height,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> next() async {
    if (!_keyForm.currentState!.validate()) return;
    _keyForm.currentState!.save();
    if (newPassword != checkNewPassword) {
      Dialogs.of(context).showSnackBar(
        message: AppLocalizations.of(context)!.check_new_password_error,
      );
      return;
    }
    Dialogs.of(context).runAsyncAction(
      future: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      onComplete: (_) {},
      onError: (_) {},
    );
  }
}
