// TODO: translate

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../../extensions.dart';
import '../../../../tools.dart';
import '../../../model/enums.dart';
import '../../../model/models.dart';
import '../../model_widgets.dart';

class CompleteRegistrationForm extends StatefulWidget {
  const CompleteRegistrationForm({
    super.key,
    required this.userSession,
    required this.accountType,
  });

  final UserSession userSession;
  final AccountType accountType;

  @override
  State<CompleteRegistrationForm> createState() =>
      _CompleteRegistrationFormState();
}

class _CompleteRegistrationFormState extends State<CompleteRegistrationForm> {
  final GlobalKey<FormState> _keyForm = GlobalKey();
  TextEditingController dateController = TextEditingController();
  String? firstName;
  String? lastName;
  String? companyName;
  String? imagePath;
  String? registrationNumber;
  String? town;
  String? zip;
  String? country;
  String? state;
  DateTime? dob;
  DateTime? startup;

  @override
  void dispose() {
    dateController.dispose();
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
        title: Text(
          isCompany
              ? AppLocalizations.of(context)!.company_details
              : AppLocalizations.of(context)!.customer_details,
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
                      if (isCustomer) ...[
                        NewTextFormField(
                          labelText:
                              AppLocalizations.of(context)!.first_name_id_label,
                          hintText:
                              AppLocalizations.of(context)!.first_name_id_hint,
                          keyboardType: TextInputType.name,
                          validator: Validators.validateNotNull,
                          onSaved: (value) {
                            firstName = value;
                          },
                          textInputAction: TextInputAction.next,
                        ),
                        16.heightSp,
                        NewTextFormField(
                          labelText:
                              AppLocalizations.of(context)!.last_name_id_label,
                          hintText:
                              AppLocalizations.of(context)!.last_name_id_hint,
                          keyboardType: TextInputType.name,
                          validator: Validators.validateNotNull,
                          onSaved: (value) {
                            lastName = value;
                          },
                          textInputAction: TextInputAction.next,
                        ),
                        16.heightSp,
                        NewTextFormField(
                          labelText:
                              AppLocalizations.of(context)!.reg_num_label,
                          hintText: AppLocalizations.of(context)!.reg_num_hint,
                          keyboardType: TextInputType.number,
                          onSaved: (value) {
                            registrationNumber = value;
                          },
                          textInputAction: TextInputAction.next,
                        ),
                        16.heightSp,
                        NewTextFormField(
                          controller: dateController,
                          labelText: AppLocalizations.of(context)!.dob_label,
                          hintText: AppLocalizations.of(context)!.date_format,
                          keyboardType: TextInputType.datetime,
                          validator: Validators.validateNotNull,
                          textInputAction: TextInputAction.next,
                          suffixIcon: Icons.calendar_month_outlined,
                          onTap: () => pickDate(dateController, dob).then(
                            (value) {
                              if (value == null) return;
                              startup = value;
                            },
                          ),
                        ),
                      ],
                      if (isCompany) ...[
                        NewTextFormField(
                          labelText:
                              AppLocalizations.of(context)!.company_name_label,
                          hintText:
                              AppLocalizations.of(context)!.company_name_hint,
                          keyboardType: TextInputType.name,
                          validator: Validators.validateNotNull,
                          onSaved: (value) {
                            companyName = value;
                          },
                          textInputAction: TextInputAction.next,
                        ),
                        16.heightSp,
                        //TODO upload company image
                        16.heightSp,
                        NewTextFormField(
                          labelText:
                              AppLocalizations.of(context)!.reg_num_label,
                          hintText: AppLocalizations.of(context)!.reg_num_hint,
                          keyboardType: TextInputType.number,
                          onSaved: (value) {
                            registrationNumber = value;
                          },
                          textInputAction: TextInputAction.next,
                        ),
                        16.heightSp,
                        NewTextFormField(
                          controller: dateController,
                          labelText: AppLocalizations.of(context)!
                              .company_startup_label,
                          hintText: AppLocalizations.of(context)!.date_format,
                          keyboardType: TextInputType.datetime,
                          validator: Validators.validateNotNull,
                          textInputAction: TextInputAction.next,
                          suffixIcon: Icons.calendar_month_outlined,
                          onTap: () => pickDate(dateController, startup).then(
                            (value) {
                              if (value == null) return;
                              startup = value;
                            },
                          ),
                        ),
                      ],
                      16.heightSp,
                      NewTextFormField(
                        labelText:
                            AppLocalizations.of(context)!.street_adr_label,
                        hintText: AppLocalizations.of(context)!.street_adr_hint,
                        keyboardType: TextInputType.streetAddress,
                        validator: Validators.validateNotNull,
                        onSaved: (value) {
                          lastName = value;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      16.heightSp,
                      NewTextFormField(
                        labelText: AppLocalizations.of(context)!.town_label,
                        hintText: AppLocalizations.of(context)!.town_hint,
                        keyboardType: TextInputType.name,
                        validator: Validators.validateNotNull,
                        onSaved: (value) {
                          town = value;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      16.heightSp,
                      NewTextFormField(
                        labelText: AppLocalizations.of(context)!.zip_label,
                        hintText: AppLocalizations.of(context)!.zip_hint,
                        keyboardType: TextInputType.name,
                        validator: Validators.validateNotNull,
                        onSaved: (value) {
                          zip = value;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      16.heightSp,
                      NewTextFormField(
                        labelText: AppLocalizations.of(context)!.state_label,
                        hintText: AppLocalizations.of(context)!.state_hint,
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
                      NewTextFormField(
                        labelText: AppLocalizations.of(context)!.country_label,
                        hintText: AppLocalizations.of(context)!.country_hint,
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
                      CustomElevatedButton(
                        onPressed: next,
                        label: AppLocalizations.of(context)!.continu,
                      ),
                      16.heightSp,
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: Styles.poppins(
                            fontSize: 14.sp,
                            fontWeight: Styles.medium,
                            color: Styles.green,
                          ),
                          children: [
                            TextSpan(
                              text: AppLocalizations.of(context)!.reg_terms_1,
                            ),
                            TextSpan(
                              text:
                                  ' ${AppLocalizations.of(context)!.reg_terms_2} ',
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
                            TextSpan(
                              text: AppLocalizations.of(context)!.reg_terms_3,
                            ),
                            TextSpan(
                              text:
                                  ' ${AppLocalizations.of(context)!.reg_terms_4}',
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

  Future<DateTime?> pickDate(
    TextEditingController controller,
    DateTime? initialDate,
  ) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime.parse('1950-01-01'),
      lastDate: DateTime.now(),
    );
    if (pickedDate == null) return null;
    controller.text = DateFormat('dd/MM/yyyy').format(pickedDate);
    return pickedDate;
  }

  Future<void> next() async {
    if (!_keyForm.currentState!.validate()) return;
    _keyForm.currentState!.save();
    FocusScope.of(context).unfocus();
    Dialogs.of(context).runAsyncAction(
      future: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      onComplete: (_) {},
      onError: (_) {},
    );
  }

  bool get isCustomer => widget.accountType == AccountType.customer;
  bool get isCompany => widget.accountType == AccountType.company;
}
