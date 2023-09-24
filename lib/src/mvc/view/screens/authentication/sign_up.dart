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
  });

  final UserSession userSession;

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
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        // leading: AppBarActionButton(
        //   icon: context.backButtonIcon,
        //   onTap: () {},
        // ),
      ),
      floatingActionButton: CustomElevatedButton(
        onPressed: next,
        label: AppLocalizations.of(context)!.sign_up,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                ).copyWith(bottom: context.viewPadding.bottom + 20.sp),
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
                    32.heightSp,
                    NewTextFormField(
                      labelText: AppLocalizations.of(context)!.first_name_label,
                      hintText: AppLocalizations.of(context)!.first_name_hint,
                      labelPrefixIcon: AwesomeIcons.user_large_outlined,
                      keyboardType: TextInputType.name,
                      validator: Validators.validateNotNull,
                      onSaved: (value) {
                        firstName = value;
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    16.heightSp,
                    NewTextFormField(
                      labelText: AppLocalizations.of(context)!.last_name_label,
                      hintText: AppLocalizations.of(context)!.last_name_hint,
                      labelPrefixIcon: AwesomeIcons.user_large_outlined,
                      keyboardType: TextInputType.name,
                      validator: Validators.validateNotNull,
                      onSaved: (value) {
                        lastName = value;
                      },
                      onEditingComplete: next,
                    ),
                    32.heightSp,
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
                    )
                  ],
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
    FocusScope.of(context).unfocus();
    Dialogs.of(context).runAsyncAction(
      future: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      onComplete: (_) {
        context.push(
          widget: CompleteRegistrationForm1(
            userSession: widget.userSession,
            accountType: accountType,
          ),
        );
      },
      onError: (_) {},
    );
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
            fontSize: 14.sp,
            color: Styles.green,
            fontWeight: Styles.medium,
          ),
        ),
      ),
    );
  }
}
