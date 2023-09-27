import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:phone_number/phone_number.dart';

import '../../../../extensions.dart';
import '../../../model/enums.dart';
import '../../../model/models_ui.dart';
import '../../model_widgets.dart';
import '../../../../tools.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> _keyForm = GlobalKey();
  TextEditingController dateController = TextEditingController();
  String? fullName, email, phoneNumber;
  DateTime? borthDate;

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: CustomElevatedButton(
        onPressed: next,
        label: AppLocalizations.of(context)!.save,
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
                      Text(
                        AppLocalizations.of(context)!.edit_profile,
                        style: Styles.poppins(
                          fontSize: 16.sp,
                          fontWeight: Styles.semiBold,
                          color: context.textTheme.displayLarge!.color,
                        ),
                      ),
                      16.heightSp,
                      CustomTextFormFieldLabel(
                        initialValue: fullName,
                        labelText: AppLocalizations.of(context)!.full_name,
                        hintText: AppLocalizations.of(context)!.full_name_hint,
                        keyboardType: TextInputType.name,
                        validator: Validators.validateNotNull,
                        onSave: (value) {
                          fullName = value;
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
                      CustomTextFormFieldLabel(
                        controller: dateController,
                        initialValue: null,
                        labelText: AppLocalizations.of(context)!.date_of_birth,
                        hintText:
                            AppLocalizations.of(context)!.date_of_birth_hint,
                        keyboardType: TextInputType.datetime,
                        validator: Validators.validateNotNull,
                        onTap: () => pickDate(dateController, borthDate),
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

  Future<DateTime?> pickDate(
    TextEditingController controller,
    DateTime? initialDate,
  ) async {
    DateTime lastDate = DateTime.now().subtract(const Duration(days: 6480));
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate ?? lastDate,
      firstDate: DateTime.now().subtract(const Duration(days: 36000)),
      lastDate: lastDate,
    );
    if (pickedDate == null) return null;
    controller.text = DateFormat('dd/MM/yyyy').format(pickedDate);
    return pickedDate;
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
                  AppLocalizations.of(context)!.edit_profile_sucess_subtitle,
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
