import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../extensions.dart';
import '../../../../tools.dart';
import '../../../model/enums.dart';
import '../../../model/models.dart';
import '../../model_widgets.dart';
import '../../screens.dart';

class CompleteRegistrationForm1 extends StatefulWidget {
  const CompleteRegistrationForm1({
    super.key,
    required this.userSession,
    required this.accountType,
  });

  final UserSession userSession;
  final AccountType accountType;

  @override
  State<CompleteRegistrationForm1> createState() =>
      _CompleteRegistrationForm1State();
}

class _CompleteRegistrationForm1State extends State<CompleteRegistrationForm1> {
  final GlobalKey<FormState> _keyForm = GlobalKey();
  TextEditingController dateController = TextEditingController();
  String? firstName;
  String? lastName;
  String? companyName;
  XFile? companyImage;
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
                        CustomTextFormFieldBounded(
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
                        CustomTextFormFieldBounded(
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
                        CustomTextFormFieldBounded(
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
                        CustomTextFormFieldBounded(
                          controller: dateController,
                          labelText: AppLocalizations.of(context)!.dob_label,
                          hintText: AppLocalizations.of(context)!.date_format,
                          keyboardType: TextInputType.datetime,
                          validator: Validators.validateNotNull,
                          textInputAction: TextInputAction.next,
                          suffixIcon: AwesomeIcons.calendar,
                          onTap: () => pickDate(dateController, dob).then(
                            (value) {
                              if (value == null) return;
                              startup = value;
                            },
                          ),
                        ),
                      ],
                      if (isCompany) ...[
                        CustomTextFormFieldBounded(
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
                        InkResponse(
                          onTap: () async {
                            if (await Permissions.of(context)
                                .showPhotoLibraryPermission()) return;
                            ImagePicker()
                                .pickImage(
                              source: ImageSource.gallery,
                              imageQuality: 80,
                              maxHeight: 1080,
                              maxWidth: 1080,
                            )
                                .then(
                              (xfile) {
                                if (xfile == null) return;
                                companyImage = xfile;
                              },
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: 0.15.sh,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: context.textTheme.headlineSmall!.color!,
                              borderRadius: BorderRadius.circular(14.sp),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  AwesomeIcons.cloud_arrow_up,
                                  color: Styles.green,
                                  size: 40.sp,
                                ),
                                Text(
                                  AppLocalizations.of(context)!
                                      .upload_company_image,
                                  style: Styles.poppins(
                                    fontSize: 12.sp,
                                    fontWeight: Styles.semiBold,
                                    color: Styles.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        16.heightSp,
                        CustomTextFormFieldBounded(
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
                        CustomTextFormFieldBounded(
                          controller: dateController,
                          labelText: AppLocalizations.of(context)!
                              .company_startup_label,
                          hintText: AppLocalizations.of(context)!.date_format,
                          keyboardType: TextInputType.datetime,
                          validator: Validators.validateNotNull,
                          textInputAction: TextInputAction.next,
                          suffixIcon: AwesomeIcons.calendar,
                          onTap: () => pickDate(dateController, startup).then(
                            (value) {
                              if (value == null) return;
                              startup = value;
                            },
                          ),
                        ),
                      ],
                      16.heightSp,
                      CustomTextFormFieldBounded(
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
                      CustomTextFormFieldBounded(
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
                      CustomTextFormFieldBounded(
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
                      CustomTextFormFieldBounded(
                        labelText: AppLocalizations.of(context)!.state_label,
                        hintText: AppLocalizations.of(context)!.state_hint,
                        keyboardType: TextInputType.name,
                        validator: Validators.validateNotNull,
                        suffixIcon: Icons.arrow_drop_down,
                        onSaved: (value) {
                          state = value;
                        },
                        textInputAction: TextInputAction.next,
                        // onTap: () {},
                      ),
                      16.heightSp,
                      CustomTextFormFieldBounded(
                        labelText: AppLocalizations.of(context)!.country_label,
                        hintText: AppLocalizations.of(context)!.country_hint,
                        keyboardType: TextInputType.name,
                        validator: Validators.validateNotNull,
                        suffixIcon: Icons.arrow_drop_down,
                        onSaved: (value) {
                          country = value;
                        },
                        textInputAction: TextInputAction.next,
                        // onTap: () {},
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
                                ..onTap = () =>
                                    context.push(widget: const PrivacyPolicy()),
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
                                ..onTap = () =>
                                    context.push(widget: const PrivacyPolicy()),
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
    Dialogs.of(context).runAsyncAction(
      future: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      onComplete: (_) {
        switch (widget.accountType) {
          case AccountType.person:
            context.push(
              widget: CompleteRegistrationFormP2(
                userSession: widget.userSession,
              ),
            );
            break;
          case AccountType.company:
            context.push(
              widget: CompleteRegistrationFormC2(
                userSession: widget.userSession,
              ),
            );
            break;
          default:
        }
        // Dialogs.of(context).showCustomDialog(
        //   title: AppLocalizations.of(context)!.success,
        //   subtitle: AppLocalizations.of(context)!.signup_success_subtitle,
        //   yesAct: ModelTextButton(
        //     label: AppLocalizations.of(context)!.continu,
        //   ),
        //   onComplete: (_) {
        //     switch (widget.accountType) {
        //       case AccountType.customer:
        //         break;
        //       case AccountType.company:
        //         context.push(
        //           widget: CompleteRegistrationFormC2(
        //             userSession: widget.userSession,
        //           ),
        //         );
        //         break;
        //       default:
        //     }
        //   },
        // );
      },
      onError: (_) {},
    );
  }

  bool get isCustomer => widget.accountType == AccountType.person;
  bool get isCompany => widget.accountType == AccountType.company;
}
