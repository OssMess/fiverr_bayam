// TODO: translate

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../extensions.dart';
import '../../../../tools.dart';
import '../../../model/enums.dart';
import '../../../model/models.dart';
import '../../model_widgets.dart';

class CompleteRegistrationCustomer extends StatefulWidget {
  const CompleteRegistrationCustomer({
    super.key,
    required this.userSession,
  });

  final UserSession userSession;

  @override
  State<CompleteRegistrationCustomer> createState() =>
      _CompleteRegistrationCustomerState();
}

class _CompleteRegistrationCustomerState
    extends State<CompleteRegistrationCustomer> {
  final GlobalKey<FormState> _keyForm = GlobalKey();
  AccountType accountType = AccountType.person;
  String? firstName;
  String? lastName;
  String? registrationNumber;
  String? town;
  String? zip;
  String? country;
  String? state;
  DateTime? dob;
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Customer Details',
        ),
        leading: AppBarActionButton(
          icon: context.backButtonIcon,
          onTap: () => context.pop(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        children: [
          const CustomAppBarBackground(
            type: AppBarBackgroundType.shrink,
          ),
          Expanded(
            child: SingleChildScrollView(
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
                      NewTextFormField(
                        labelText: 'First Name on your photo ID *',
                        hintText: 'Enter first name',
                        keyboardType: TextInputType.name,
                        validator: Validators.validateNotNull,
                        onSaved: (value) {
                          firstName = value;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      16.heightSp,
                      NewTextFormField(
                        labelText: 'Last Name on your photo ID *',
                        hintText: 'Enter last name',
                        keyboardType: TextInputType.name,
                        validator: Validators.validateNotNull,
                        onSaved: (value) {
                          lastName = value;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      16.heightSp,
                      NewTextFormField(
                        labelText: 'Unique Registration Number (NUM)',
                        hintText: 'Write here',
                        keyboardType: TextInputType.number,
                        // validator: Validators.validateNumberInt,
                        onSaved: (value) {
                          registrationNumber = value;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      16.heightSp,
                      NewTextFormField(
                        controller: controller,
                        labelText: 'DOB *',
                        hintText: 'DD/MM/YYYY',
                        keyboardType: TextInputType.datetime,
                        validator: Validators.validateNotNull,
                        textInputAction: TextInputAction.next,
                        suffixIcon: Icons.calendar_month_outlined,
                        onTap: () {
                          //TODO implement date picker
                        },
                      ),
                      16.heightSp,
                      NewTextFormField(
                        labelText: 'Street Address *',
                        hintText: 'Enter street address',
                        keyboardType: TextInputType.streetAddress,
                        validator: Validators.validateNotNull,
                        onSaved: (value) {
                          lastName = value;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      16.heightSp,
                      NewTextFormField(
                        labelText: 'Town *',
                        hintText: 'Enter your town here',
                        keyboardType: TextInputType.name,
                        validator: Validators.validateNotNull,
                        onSaved: (value) {
                          town = value;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      16.heightSp,
                      NewTextFormField(
                        labelText: 'ZIP Code',
                        hintText: 'Enter ZIP Code here',
                        keyboardType: TextInputType.name,
                        validator: Validators.validateNotNull,
                        onSaved: (value) {
                          zip = value;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      16.heightSp,
                      NewTextFormField(
                        labelText: 'Country *',
                        hintText: 'Choose your country',
                        keyboardType: TextInputType.name,
                        validator: Validators.validateNotNull,
                        suffixIcon: Icons.arrow_drop_down,
                        onSaved: (value) {
                          country = value;
                        },
                        textInputAction: TextInputAction.next,
                        onTap: () {
                          //TODO implement country picker
                        },
                      ),
                      16.heightSp,
                      NewTextFormField(
                        labelText: 'State *',
                        hintText: 'Choose your state',
                        keyboardType: TextInputType.name,
                        validator: Validators.validateNotNull,
                        suffixIcon: Icons.arrow_drop_down,
                        onSaved: (value) {
                          state = value;
                        },
                        textInputAction: TextInputAction.next,
                        onTap: () {
                          //TODO implement state picker
                        },
                      ),
                      16.heightSp,
                      CustomElevatedButton(
                        onPressed: next,
                        label: AppLocalizations.of(context)!.continu,
                      ),
                      16.heightSp,
                      RichText(
                        text: TextSpan(
                          style: Styles.poppins(
                            fontSize: 14.sp,
                            fontWeight: Styles.medium,
                            color: Styles.green,
                          ),
                          children: [
                            const TextSpan(
                              text:
                                  'By continuing, you agree to the company\'s',
                            ),
                            TextSpan(
                              text: ' privacy policy ',
                              style: Styles.poppins(
                                fontSize: 14.sp,
                                fontWeight: Styles.medium,
                                color: Styles.green,
                                textDecoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  //TODO open terms
                                },
                            ),
                            const TextSpan(
                              text: 'and',
                            ),
                            TextSpan(
                              text: ' terms',
                              style: Styles.poppins(
                                fontSize: 14.sp,
                                fontWeight: Styles.medium,
                                color: Styles.green,
                                textDecoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  //TODO open terms
                                },
                            ),
                            const TextSpan(
                              text: '.',
                            ),
                          ],
                        ),
                      )
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
    FocusScope.of(context).unfocus();
    Dialogs.of(context).runAsyncAction(
      future: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      onComplete: (_) {
        //TODO on complete register customer
      },
      onError: (_) {},
    );
  }
}
