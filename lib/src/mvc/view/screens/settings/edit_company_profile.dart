import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phone_number/phone_number.dart';

import '../../../../extensions.dart';
import '../../../model/enums.dart';
import '../../../model/models_ui.dart';
import '../../model_widgets.dart';
import '../../../../tools.dart';
import '../../model_widgets_screens.dart';

class EditCompanyProfile extends StatefulWidget {
  const EditCompanyProfile({super.key});

  @override
  State<EditCompanyProfile> createState() => _EditCompanyProfileState();
}

class _EditCompanyProfileState extends State<EditCompanyProfile> {
  final GlobalKey<FormState> _keyForm = GlobalKey();
  TextEditingController dateController = TextEditingController();
  String? companyName, email, phoneNumber;

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
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
                        title: AppLocalizations.of(context)!.edit_profile,
                      ),
                      16.heightSp,
                      CustomTextFormFieldLabel(
                        initialValue: companyName,
                        labelText:
                            AppLocalizations.of(context)!.company_name_label,
                        hintText:
                            AppLocalizations.of(context)!.company_name_hint,
                        keyboardType: TextInputType.name,
                        validator: Validators.validateNotNull,
                        onSave: (value) {
                          companyName = value;
                        },
                      ),
                      CustomTextFormFieldLabel(
                        initialValue: email,
                        labelText: AppLocalizations.of(context)!.email,
                        hintText: AppLocalizations.of(context)!.email_hint,
                        keyboardType: TextInputType.emailAddress,
                        validator: Validators.validateEmail,
                        onSave: (value) {
                          email = value;
                        },
                      ),
                      CustomTextFormFieldLabel(
                        initialValue: phoneNumber,
                        labelText: AppLocalizations.of(context)!.phone_number,
                        hintText:
                            AppLocalizations.of(context)!.phone_number_hint,
                        keyboardType: TextInputType.phone,
                        validator: Validators.validatePhoneNumber,
                        onSave: (value) {
                          phoneNumber = value;
                        },
                        textInputAction: TextInputAction.done,
                      ),
                      64.heightSp,
                      CustomElevatedButton(
                        onPressed: next,
                        label: AppLocalizations.of(context)!.save,
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
    validatePhoneNumber().then(
      (isPhoneNumberValide) {
        if (!isPhoneNumberValide) {
          Dialogs.of(context).showSnackBar(
            message: AppLocalizations.of(context)!.snackbar_invlid_phone_number,
          );
          return;
        }
        Dialogs.of(context).runAsyncAction(
          future: () async {
            await Future.delayed(const Duration(seconds: 1));
          },
          onComplete: (_) {
            Dialogs.of(context).showCustomDialog(
              title: AppLocalizations.of(context)!.success,
              subtitle:
                  AppLocalizations.of(context)!.your_information_has_been_saved,
              yesAct: ModelTextButton(
                label: AppLocalizations.of(context)!.continu,
              ),
              onComplete: (_) {
                context.pop();
              },
            );
          },
          onError: (_) {},
        );
      },
    );
  }

  Future<bool> validatePhoneNumber() async {
    try {
      bool isValid = await PhoneNumberUtil().validate(
        phoneNumber!,
      );
      if (isValid) {
        PhoneNumber number = await PhoneNumberUtil().parse(
          phoneNumber!,
        );
        phoneNumber = number.international;
      }
      return isValid;
    } catch (e) {
      return false;
    }
  }
}
