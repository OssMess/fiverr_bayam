// TODO: translate
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../extensions.dart';
import '../../../../tools.dart';
import '../../../model/enums.dart';
import '../../../model/models.dart';
import '../../model_widgets.dart';

class Login extends StatefulWidget {
  const Login({
    super.key,
    required this.userSession,
  });

  final UserSession userSession;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String countryCode = '+237';

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
        onPressed: () {},
        label: AppLocalizations.of(context)!.sign_in,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        children: [
          const CustomAppBarBackground(
            type: AppBarBackgroundType.expanded,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20.sp,
                vertical: 10.sp,
              ).copyWith(bottom: context.viewPadding.bottom + 20.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    AppLocalizations.of(context)!.sign_in_title,
                    style: Styles.poppins(
                        fontSize: 22.sp,
                        color: context.textTheme.displayLarge!.color,
                        fontWeight: Styles.bold),
                  ),
                  Text(
                    AppLocalizations.of(context)!.sign_in_title,
                    style: Styles.poppins(
                      fontSize: 14.sp,
                      color: context.textTheme.displayMedium!.color,
                      fontWeight: Styles.regular,
                    ),
                  ),
                  30.heightSp,
                  NewTextFormField(
                    labelText: AppLocalizations.of(context)!.phone_number,
                    hintText: AppLocalizations.of(context)!.phone_number_hint,
                    prefix: CountryCodePicker(
                      initialSelection: 'CM',
                      enabled: false,
                      favorite: const ['+237'],
                      comparator: (a, b) => b.name!.compareTo(a.name!),
                      boxDecoration: BoxDecoration(
                        color: context.textTheme.headlineMedium!.color,
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                      textStyle: Styles.poppins(
                        fontWeight: Styles.medium,
                        color: context.textTheme.displayMedium!.color,
                        fontSize: 14.sp,
                      ),
                      onChanged: (code) {
                        countryCode = code.dialCode ?? '+237';
                      },
                      padding: EdgeInsets.zero,
                      flagWidth: 30.sp,
                    ),
                  ),
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
                        fontSize: 14.sp,
                        fontWeight: Styles.medium,
                        color: Styles.green,
                      ),
                    ),
                  ),
                  (context.viewPadding.bottom + 50.h).heightSp,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
