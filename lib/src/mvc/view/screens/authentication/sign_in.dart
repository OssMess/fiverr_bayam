// ignore_for_file: dead_code

import 'dart:math';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phone_number/phone_number.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../extensions.dart';
import '../../../../tools.dart';
import '../../../controller/services.dart';
import '../../../model/change_notifiers.dart';
import '../../../model/enums.dart';
import '../../../model/models.dart';
import '../../../model/models_ui.dart';
import '../../model_widgets.dart';

class SignIn extends StatefulWidget {
  const SignIn({
    super.key,
    required this.userSession,
    required this.ipLocation,
  });

  final UserSession userSession;
  final IPLocation? ipLocation;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _keyForm = GlobalKey();
  late String countryCode;
  String? phoneNumber;
  String? pinCode;
  FocusNode focusNode = FocusNode();
  Bouncer? bouncer;
  NotifierInt? durationNotifier;

  @override
  void initState() {
    countryCode = widget.ipLocation?.countryCode ?? 'CM';
    super.initState();
  }

  @override
  void dispose() {
    bouncer?.cancel();
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
                ).copyWith(bottom: context.viewPadding.bottom + 20.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (otpSent) ...[
                      Text(
                        AppLocalizations.of(context)!.verify_phone_number_title,
                        style: Styles.poppins(
                            fontSize: 22.sp,
                            color: context.textTheme.displayLarge!.color,
                            fontWeight: Styles.bold),
                      ),
                      Text(
                        AppLocalizations.of(context)!
                            .verify_phone_number_subtitle,
                        style: Styles.poppins(
                          fontSize: 14.sp,
                          color: context.textTheme.displayMedium!.color,
                          fontWeight: Styles.regular,
                        ),
                      ),
                      32.heightSp,
                      PinCodeTextField(
                        focusNode: focusNode,
                        errorTextSpace: 8.sp,
                        appContext: context,
                        length: 6,
                        onChanged: (value) {
                          pinCode = value;
                        },
                        onCompleted: verifyOTP,
                        keyboardType: TextInputType.number,
                        textStyle: Styles.poppins(
                          fontSize: 24.w,
                          fontWeight: Styles.bold,
                          color: Styles.green,
                        ),
                        pinTheme: PinTheme(
                          borderWidth: 2.sp,
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(15.sp),
                          fieldHeight: 50.w, //70.w
                          fieldWidth: 50.w,
                          inactiveColor:
                              context.textTheme.headlineMedium!.color,
                          activeColor: Styles.green,
                          selectedColor: Styles.green,
                        ),
                      ),
                      16.heightSp,
                      Builder(
                        builder: (context) {
                          return ValueListenableBuilder(
                            valueListenable: durationNotifier!.notifier,
                            builder: (context, duration, _) {
                              return RichText(
                                text: TextSpan(
                                  style: Styles.poppins(
                                    fontSize: 15.sp,
                                    fontWeight: Styles.medium,
                                    color:
                                        context.textTheme.displayLarge!.color,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          '${AppLocalizations.of(context)!.didnt_receive_code} ',
                                    ),
                                    if (canResend)
                                      TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .resend,
                                        style: Styles.poppins(
                                          fontSize: 15.sp,
                                          fontWeight: Styles.medium,
                                          color: Styles.green,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = sendOTP,
                                      ),
                                    if (!canResend) ...[
                                      TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .resend_in,
                                      ),
                                      TextSpan(
                                        text:
                                            ' ${AppLocalizations.of(context)!.nb_seconds(duration)}',
                                        style: Styles.poppins(
                                          fontSize: 15.sp,
                                          fontWeight: Styles.medium,
                                          color: const Color(0xFFD80027),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                      16.heightSp,
                      Text(
                        AppLocalizations.of(context)!.check_sms_hint,
                        style: Styles.poppins(
                          fontSize: 15.sp,
                          color: context.textTheme.displayMedium!.color,
                          fontWeight: Styles.regular,
                        ),
                      ),
                      16.heightSp,
                      Row(
                        children: [
                          InkResponse(
                            onTap: canResend ? sendOTP : null,
                            child: ValueListenableBuilder(
                                valueListenable: durationNotifier!.notifier,
                                builder: (context, duration, _) {
                                  return CustomFlatButton(
                                    padding: EdgeInsets.all(16.sp),
                                    color:
                                        context.textTheme.headlineSmall!.color,
                                    child: Text(
                                      AppLocalizations.of(context)!.resend_code,
                                      style: Styles.poppins(
                                        fontSize: 14.sp,
                                        fontWeight: Styles.semiBold,
                                        color: canResend
                                            ? Styles.green
                                            : context
                                                .textTheme.headlineLarge!.color,
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Spacer(),
                      const Spacer(),
                      CustomElevatedButton(
                        onPressed: next,
                        label: AppLocalizations.of(context)!.continu,
                      ),
                      const Spacer(),
                    ],
                    if (otpNotSent) ...[
                      Text(
                        AppLocalizations.of(context)!.sign_in_title,
                        style: Styles.poppins(
                          fontSize: 22.sp,
                          color: context.textTheme.displayLarge!.color,
                          fontWeight: Styles.bold,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.sign_in_subtitle,
                        style: Styles.poppins(
                          fontSize: 14.sp,
                          color: context.textTheme.displayMedium!.color,
                          fontWeight: Styles.regular,
                        ),
                      ),
                      32.heightSp,
                      CustomTextFormFieldBounded(
                        labelText: AppLocalizations.of(context)!.phone_number,
                        hintText:
                            AppLocalizations.of(context)!.phone_number_hint,
                        addSpacer: false,
                        prefix: CountryCodePicker(
                          initialSelection: countryCode,
                          enabled: true,
                          favorite: const ['+237'],
                          comparator: (a, b) => b.name!.compareTo(a.name!),
                          boxDecoration: BoxDecoration(
                            color: context.scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(10.sp),
                          ),
                          textStyle: Styles.poppins(
                            fontWeight: Styles.medium,
                            color: context.textTheme.displayMedium!.color,
                            fontSize: 14.sp,
                            height: 1.2,
                          ),
                          onChanged: (code) {
                            countryCode = code.code ?? 'CM';
                          },
                          padding: EdgeInsets.zero,
                          flagWidth: 30.sp,
                        ),
                        keyboardType: TextInputType.phone,
                        onSaved: (value) {
                          phoneNumber = value;
                        },
                        validator: (value) =>
                            Validators.validatePhoneNumber(value),
                        onEditingComplete: next,
                      ),
                      const Spacer(),
                      const Spacer(),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.all(16.sp),
                        decoration: BoxDecoration(
                          color: Styles.green[50],
                          borderRadius: BorderRadius.circular(14.sp),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.sign_in_about,
                          textAlign: TextAlign.center,
                          style: Styles.poppins(
                            fontSize: 16.sp,
                            fontWeight: Styles.medium,
                            color: Styles.green,
                          ),
                        ),
                      ),
                      16.heightSp,
                      CustomElevatedButton(
                        onPressed: next,
                        label: AppLocalizations.of(context)!.sign_in,
                      ),
                      const Spacer(),
                    ],
                  ],
                ),
              ),
            ),
          ),
          context.viewInsets.bottom.height,
        ],
      ),
    );
  }

  bool get otpSent => bouncer != null && phoneNumber != null;

  bool get otpNotSent => !otpSent;

  bool get canResend => durationNotifier!.notifier.value <= 0;

  Future<void> next() async {
    if (otpNotSent) {
      if (false && !_keyForm.currentState!.validate()) return;
      _keyForm.currentState!.save();
      validatePhoneNumber().then(
        (isValide) {
          if (isValide) {
            sendOTP();
          } else {
            Dialogs.of(context).showSnackBar(
              message:
                  AppLocalizations.of(context)!.snackbar_invlid_phone_number,
            );
          }
        },
      );
    } else {
      if (false && (pinCode == null || pinCode!.length < 4)) {
        Dialogs.of(context).showSnackBar(
          message: AppLocalizations.of(context)!.snackbar_enter_otp,
        );
        return;
      }
      FocusScope.of(context).unfocus();
      verifyOTP(pinCode ?? '');
    }
  }

  Future<bool> validatePhoneNumber() async {
    try {
      bool isValid = await PhoneNumberUtil().validate(
        phoneNumber!,
        regionCode: countryCode,
      );
      if (isValid) {
        PhoneNumber number = await PhoneNumberUtil().parse(
          phoneNumber!,
          regionCode: countryCode,
        );
        phoneNumber = number.international.replaceAll(' ', '');
      }
      return isValid;
    } catch (e) {
      return false;
    }
  }

  Future<void> sendOTP() async {
    Dialogs.of(context).runAsyncAction(
      future: () async {
        await AuthServices.sendOTP(phoneNumber!);
      },
      onComplete: (_) {
        setState(() {
          startTimer();
        });
      },
    );
  }

  void startTimer() {
    bouncer = Bouncer(milliseconds: 1000);
    durationNotifier = NotifierInt.init(60);
    bouncer!.run(() {
      if (durationNotifier!.value == 1) {
        durationNotifier!.setValue(0);
        bouncer!.cancel();
      } else {
        durationNotifier!.setValue(max(0, durationNotifier!.value - 1));
      }
    });
  }

  Future<void> verifyOTP(String code) async {
    pinCode = code;
    Dialogs.of(context).runAsyncAction(
      future: () async {
        await AuthServices.verifyOTP(
          phoneNumber!,
          pinCode!,
        );
      },
      onComplete: (_) {
        widget.userSession.onSignInCompleted(phoneNumber: phoneNumber!);
      },
    );
  }
}
