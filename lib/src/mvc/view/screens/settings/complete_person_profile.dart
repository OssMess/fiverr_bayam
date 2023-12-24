import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../../extensions.dart';
import '../../../../tools.dart';
import '../../../controller/services.dart';
import '../../../model/enums.dart';
import '../../../model/models.dart';
import '../../../model/models_ui.dart';
import '../../model_widgets.dart';
import '../../screens.dart';

class CompletePersonProfile extends StatefulWidget {
  const CompletePersonProfile({
    super.key,
    required this.userSession,
  });

  final UserSession userSession;

  @override
  State<CompletePersonProfile> createState() => _CompletePersonProfileState();
}

class _CompletePersonProfileState extends State<CompletePersonProfile> {
  final GlobalKey<FormState> _keyForm = GlobalKey();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  String? firstName;
  String? lastName;
  String? streetAddress;
  String? city;
  String? postalCode;
  String? country;
  String? region;
  String? uniqueRegisterNumber;
  DateTime? birthDate;

  @override
  void initState() {
    firstName = widget.userSession.firstName;
    lastName = widget.userSession.lastName;
    postalCode = widget.userSession.postalCode;
    city = widget.userSession.city;
    country = widget.userSession.country;
    region = widget.userSession.region;
    streetAddress = widget.userSession.streetAddress;
    uniqueRegisterNumber = widget.userSession.uniqueRegisterNumber;
    birthDate = DateTime.tryParse(widget.userSession.birthDate ?? '');
    dateController.text = widget.userSession.birthDate ?? '';
    super.initState();
  }

  @override
  void dispose() {
    countryController.dispose();
    cityController.dispose();
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
        children: [
          CustomAppBarBackground(
            type: AppBarBackgroundType.shrink,
            appBarTitle: AppLocalizations.of(context)!.customer_details,
            appBarLeading: AppBarActionButton(
              icon: context.backButtonIcon,
              onTap: () => context.pop(),
            ),
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
                      CustomTextFormFieldBounded(
                        initialValue: firstName,
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
                        initialValue: lastName,
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
                        initialValue: uniqueRegisterNumber,
                        labelText: AppLocalizations.of(context)!.reg_num_label,
                        hintText: AppLocalizations.of(context)!.reg_num_hint,
                        keyboardType: TextInputType.name,
                        validator: (value) =>
                            Validators.validateLength(value, 14),
                        onSaved: (value) {
                          uniqueRegisterNumber = value;
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
                        onTap: () => pickDate(dateController, birthDate).then(
                          (value) {
                            if (value == null) return;
                            birthDate = value;
                          },
                        ),
                      ),
                      16.heightSp,
                      CustomTextFormFieldBounded(
                        initialValue: streetAddress,
                        labelText:
                            AppLocalizations.of(context)!.street_adr_label,
                        hintText: AppLocalizations.of(context)!.street_adr_hint,
                        keyboardType: TextInputType.streetAddress,
                        validator: Validators.validateNotNull,
                        onSaved: (value) {
                          streetAddress = value;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      16.heightSp,
                      CustomTextFormFieldBounded(
                        initialValue: city,
                        labelText: AppLocalizations.of(context)!.town_label,
                        hintText: AppLocalizations.of(context)!.town_hint,
                        keyboardType: TextInputType.name,
                        validator: Validators.validateNotNull,
                        onSaved: (value) {
                          city = value;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      16.heightSp,
                      CustomTextFormFieldBounded(
                        initialValue: postalCode,
                        labelText: AppLocalizations.of(context)!.zip_label,
                        hintText: AppLocalizations.of(context)!.zip_hint,
                        keyboardType: TextInputType.name,
                        validator: Validators.validateNotNull,
                        onSaved: (value) {
                          postalCode = value;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      16.heightSp,
                      CustomTextFormFieldBounded(
                        controller: cityController,
                        labelText: AppLocalizations.of(context)!.state_label,
                        hintText: AppLocalizations.of(context)!.state_hint,
                        keyboardType: TextInputType.name,
                        validator: Validators.validateNotNull,
                        suffixIcon: Icons.arrow_drop_down,
                        onSaved: (value) {
                          region = value;
                        },
                        textInputAction: TextInputAction.next,
                        onTap: () {
                          Dialogs.of(context).runAsyncAction(
                            future: () async {
                              await widget.userSession.listCities!
                                  .initData(callGet: true);
                            },
                            onComplete: (_) {
                              Dialogs.of(context).showSingleValuePickerDialog(
                                title: AppLocalizations.of(context)!.state_hint,
                                values: widget.userSession.listCities!.list
                                    .map((e) => e.name)
                                    .toList(),
                                initialvalue: country,
                                onPick: (region) {
                                  this.region = region;
                                  cityController.text = region;
                                },
                                mainAxisSize: MainAxisSize.max,
                              );
                            },
                          );
                        },
                      ),
                      16.heightSp,
                      CustomTextFormFieldBounded(
                        controller: countryController,
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
                          Dialogs.of(context).runAsyncAction(
                            future: () async {
                              await widget.userSession.listCountries!
                                  .initData(callGet: true);
                            },
                            onComplete: (_) {
                              Dialogs.of(context).showSingleValuePickerDialog(
                                title:
                                    AppLocalizations.of(context)!.country_hint,
                                values: widget.userSession.listCountries!.list
                                    .map((e) => e.name)
                                    .toList(),
                                initialvalue: country,
                                onPick: (country) {
                                  this.country = country;
                                  countryController.text = country;
                                },
                                mainAxisSize: MainAxisSize.max,
                              );
                            },
                          );
                        },
                      ),
                      32.heightSp,
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
        widget.userSession.firstName = firstName;
        widget.userSession.lastName = lastName;
        widget.userSession.streetAddress = streetAddress;
        widget.userSession.postalCode = postalCode;
        widget.userSession.city = city;
        widget.userSession.country = country;
        widget.userSession.region = region;
        widget.userSession.uniqueRegisterNumber = uniqueRegisterNumber;
        widget.userSession.birthDate = dateController.text;
        await UserServices.of(widget.userSession).post();
      },
      onComplete: (_) {
        Dialogs.of(context).showCustomDialog(
          title: AppLocalizations.of(context)!.success,
          subtitle:
              AppLocalizations.of(context)!.your_information_has_been_saved,
          yesAct: ModelTextButton(
            label: AppLocalizations.of(context)!.continu,
            onPressed: () {
              context.popUntilFirst();
              context.push(
                widget: DocumentsPersonVerification(
                  userSession: widget.userSession,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
