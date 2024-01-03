import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../extensions.dart';
import '../../../model/enums.dart';
import '../../model_widgets.dart';
import '../../../../tools.dart';

class ContactSupport extends StatefulWidget {
  const ContactSupport({super.key});

  @override
  State<ContactSupport> createState() => _ContactSupportState();
}

class _ContactSupportState extends State<ContactSupport> {
  TextEditingController departementController = TextEditingController();
  final GlobalKey<FormState> _keyForm = GlobalKey();
  bool msgSent = false;
  String? subject, departement, message;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (pop) {
        if (!pop) {
          context.popUntilFirst();
        }
      },
      canPop: !msgSent,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: AppBar(),
        body: Form(
          key: _keyForm,
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBarBackground(
                type: AppBarBackgroundType.shrink,
                appBarTitleWidget: const CustomAppBarLogo(),
                appBarLeading: AppBarActionButton(
                  icon: context.backButtonIcon,
                  onTap: msgSent ? context.popUntilFirst : context.pop,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: msgSent
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.start,
                    children: [
                      if (msgSent) ...[
                        SvgPicture.asset(
                          'assets/images/undraw_done_re_oak4.svg',
                          height: 0.25.sh,
                          fit: BoxFit.contain,
                          alignment: Alignment.center,
                        ),
                        32.heightSp,
                        Text(
                          AppLocalizations.of(context)!.msg_support_sent,
                          textAlign: TextAlign.center,
                          style: Styles.poppins(
                            fontSize: 16.sp,
                            fontWeight: Styles.medium,
                            color: context.textTheme.displayLarge!.color,
                          ),
                        ),
                        96.heightSp,
                        CustomElevatedButton(
                          label: AppLocalizations.of(context)!.back_to_profile,
                          onPressed: context.popUntilFirst,
                        ),
                        (context.viewPadding.bottom + 90.sp).height,
                      ],
                      if (!msgSent) ...[
                        CustomTextFormFieldBounded(
                          labelText: AppLocalizations.of(context)!.subject,
                          hintText: AppLocalizations.of(context)!.subject_hint,
                          keyboardType: TextInputType.text,
                          validator: Validators.validateNotNull,
                          onSaved: (value) {
                            subject = value;
                          },
                          textInputAction: TextInputAction.next,
                        ),
                        16.heightSp,
                        CustomTextFormFieldBounded(
                          controller: departementController,
                          labelText: AppLocalizations.of(context)!.departement,
                          hintText:
                              AppLocalizations.of(context)!.departement_hint,
                          keyboardType: TextInputType.text,
                          validator: Validators.validateNotNull,
                          onSaved: (value) {
                            departement = value;
                          },
                          textInputAction: TextInputAction.next,
                          suffixIcon: Icons.arrow_drop_down,
                          onTap: () =>
                              Dialogs.of(context).showSingleValuePickerDialog(
                            mainAxisSize: MainAxisSize.min,
                            title: AppLocalizations.of(context)!
                                .pick_a_department_hint,
                            values: [
                              'IT',
                              'Security',
                              'Performance',
                              'Payment',
                              'Refund',
                              'Other',
                            ],
                            initialvalue: departement,
                            onPick: (value) {
                              departementController.text = value;
                            },
                          ),
                        ),
                        16.heightSp,
                        CustomTextFormFieldBounded(
                          labelText: AppLocalizations.of(context)!.message,
                          hintText: AppLocalizations.of(context)!.message_hint,
                          keyboardType: TextInputType.multiline,
                          validator: Validators.validateNotNull,
                          onSaved: (value) {
                            message = value;
                          },
                          textInputAction: TextInputAction.done,
                          maxLines: 10,
                        ),
                        96.heightSp,
                        CustomElevatedButton(
                          label: AppLocalizations.of(context)!.submit_request,
                          onPressed: next,
                        ),
                        (context.viewPadding.bottom + 90.sp).height,
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> next() async {
    if (!_keyForm.currentState!.validate()) return;
    _keyForm.currentState!.save();
    Dialogs.of(context).runAsyncAction(
      future: () async {
        await Future.delayed(
          const Duration(seconds: 1),
        );
      },
      onComplete: (_) {
        setState(() {
          msgSent = true;
        });
      },
    );
  }
}
