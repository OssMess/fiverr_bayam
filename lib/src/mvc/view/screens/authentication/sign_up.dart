// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../extensions.dart';
import '../../../../tools.dart';
import '../../../model/enums.dart';
import '../../../model/models.dart';
import '../../model_widgets.dart';
import '../../screens.dart';

class SignUp extends StatefulWidget {
  const SignUp({
    super.key,
    required this.userSession,
    required this.geocodingLocation,
  });

  final UserSession userSession;
  final GeoCodingLocation? geocodingLocation;

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _keyForm = GlobalKey();
  AccountType accountType = AccountType.person;
  String? firstName, lastName;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: Column(
        children: [
          const CustomAppBarBackground(
            type: AppBarBackgroundType.expanded,
          ),
          Expanded(
            child: Form(
              key: _keyForm,
              autovalidateMode: AutovalidateMode.disabled,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.sp,
                  vertical: 10.sp,
                ).copyWith(bottom: 20.sp),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.sign_up_title,
                        style: Styles.poppins(
                            fontSize: 22.sp,
                            color: context.textTheme.displayLarge!.color,
                            fontWeight: Styles.bold),
                      ),
                      Text(
                        AppLocalizations.of(context)!.sign_up_subtitle,
                        style: Styles.poppins(
                          fontSize: 14.sp,
                          color: context.textTheme.displayMedium!.color,
                          fontWeight: Styles.regular,
                        ),
                      ),
                      if (accountType == AccountType.person) ...[
                        32.heightSp,
                        CustomTextFormFieldBounded(
                          labelText:
                              AppLocalizations.of(context)!.first_name_label,
                          hintText:
                              AppLocalizations.of(context)!.first_name_hint,
                          labelPrefixIcon: AwesomeIcons.user_large_outlined,
                          keyboardType: TextInputType.name,
                          validator: Validators.validateNotNull,
                          onSaved: (value) {
                            firstName = value;
                          },
                          textInputAction: TextInputAction.next,
                        ),
                        16.heightSp,
                        CustomTextFormFieldBounded(
                          labelText:
                              AppLocalizations.of(context)!.last_name_label,
                          hintText:
                              AppLocalizations.of(context)!.last_name_hint,
                          labelPrefixIcon: AwesomeIcons.user_large_outlined,
                          keyboardType: TextInputType.name,
                          validator: Validators.validateNotNull,
                          onSaved: (value) {
                            lastName = value;
                          },
                          onEditingComplete: next,
                        ),
                        16.heightSp,
                      ],
                      16.heightSp,
                      Text(
                        AppLocalizations.of(context)!.i_am_a,
                        style: Styles.poppins(
                          fontSize: 14.sp,
                          color: context.textTheme.displayLarge!.color,
                          fontWeight: Styles.medium,
                        ),
                      ),
                      16.heightSp,
                      Row(
                        children: [
                          Expanded(
                            child: AccountTypePicker(
                              value: AccountType.person,
                              groupValue: accountType,
                              onChange: (type) => setState(() {
                                accountType = type;
                              }),
                            ),
                          ),
                          16.widthSp,
                          Expanded(
                            child: AccountTypePicker(
                              value: AccountType.company,
                              groupValue: accountType,
                              onChange: (type) => setState(() {
                                accountType = type;
                              }),
                            ),
                          ),
                        ],
                      ),
                      32.heightSp,
                      CustomElevatedButton(
                        onPressed: next,
                        label: AppLocalizations.of(context)!.sign_up,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          context.viewPadding.bottom.height,
        ],
      ),
    );
  }

  Future<void> next() async {
    if (!_keyForm.currentState!.validate()) return;
    _keyForm.currentState!.save();
    widget.userSession.firstName = null;
    widget.userSession.lastName = null;
    widget.userSession.companyName = null;
    widget.userSession.preferences = null;
    widget.userSession.email = null;
    widget.userSession.bio = null;
    widget.userSession.birthDate = null;
    widget.userSession.city = null;
    widget.userSession.postalCode = null;
    widget.userSession.region = null;
    widget.userSession.streetAddress = null;
    widget.userSession.country = null;
    widget.userSession.registrationNumber = null;
    widget.userSession.uniqueRegistrationNumber = null;
    widget.userSession.facebookUrl = null;
    widget.userSession.linkedinUrl = null;
    widget.userSession.twitterUrl = null;

    switch (accountType) {
      case AccountType.company:
        context.push(
          widget: CompleteRegistrationPageC1(
            userSession: widget.userSession,
            geocodingLocation: widget.geocodingLocation,
          ),
        );
        break;
      case AccountType.person:
        widget.userSession.firstName = firstName;
        widget.userSession.firstName = lastName;
        context.push(
          widget: CompletePreferences(
            userSession: widget.userSession,
            accountType: accountType,
          ),
        );
        break;
      default:
    }
  }
}

class AccountTypePicker extends StatelessWidget {
  const AccountTypePicker({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChange,
  });

  final AccountType value;
  final AccountType groupValue;
  final void Function(AccountType) onChange;

  @override
  Widget build(BuildContext context) {
    bool isSelected = value == groupValue;
    return InkResponse(
      onTap: () => onChange(value),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 16.sp),
        decoration: BoxDecoration(
          color: Styles.green[50],
          borderRadius: BorderRadius.circular(8.sp),
          border: isSelected
              ? Border.all(
                  color: Styles.green,
                )
              : const Border.fromBorderSide(BorderSide.none),
        ),
        child: Text(
          value.translate(context),
          style: Styles.poppins(
            fontSize: 16.sp,
            color: Styles.green,
            fontWeight: Styles.semiBold,
          ),
        ),
      ),
    );
  }
}
