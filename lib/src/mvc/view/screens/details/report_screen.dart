import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../extensions.dart';
import '../../../model/enums.dart';
import '../../../model/models_ui.dart';
import '../../model_widgets.dart';
import '../../../../tools.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final GlobalKey<FormState> _keyForm = GlobalKey();
  String? report;

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
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.why_report,
                      style: Styles.poppins(
                        fontSize: 16.sp,
                        fontWeight: Styles.semiBold,
                        color: context.textTheme.displayLarge!.color,
                      ),
                    ),
                    16.heightSp,
                    Text(
                      AppLocalizations.of(context)!.why_report_subtitle,
                      style: Styles.poppins(
                        fontSize: 14.sp,
                        fontWeight: Styles.semiBold,
                        color: context.textTheme.displayLarge!.color,
                      ),
                    ),
                    16.heightSp,
                    Form(
                      key: _keyForm,
                      autovalidateMode: AutovalidateMode.disabled,
                      child: CustomTextFormField(
                        hintText: AppLocalizations.of(context)!.why_report_hint,
                        keyboardType: TextInputType.multiline,
                        validator: Validators.validateNotNull,
                        onSaved: (value) {
                          report = value;
                        },
                        textInputAction: TextInputAction.newline,
                        maxLines: 10,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.sp,
                          vertical: 16.sp,
                        ),
                      ),
                    ),
                    60.heightH,
                    CustomElevatedButton(
                      onPressed: next,
                      label: AppLocalizations.of(context)!.report,
                      color: Styles.red,
                    ),
                    (context.viewPadding.bottom + 20.sp).height,
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
    Dialogs.of(context).runAsyncAction(
      future: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      onComplete: (_) {
        Dialogs.of(context).showCustomDialog(
          title: AppLocalizations.of(context)!.content_reported_title,
          subtitle: AppLocalizations.of(context)!.content_reported_subtitle,
          yesAct: ModelTextButton(
            label: AppLocalizations.of(context)!.continu,
            color: Styles.green,
            onPressed: context.pop,
          ),
        );
      },
      onError: (_) {},
    );
  }
}
