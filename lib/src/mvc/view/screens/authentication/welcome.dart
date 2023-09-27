import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../extensions.dart';
import '../../../../settings.dart';
import '../../../../tools.dart';
import '../../model_widgets.dart';
import '../../screens.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key, required this.settingsController});

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: context.viewPadding.top,
            ),
          ),
          16.heightSp,
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.sp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.sp),
                  border: Border.all(
                    color: context.textTheme.displaySmall!.color!,
                    width: 1.sp,
                  ),
                ),
                child: DropdownButton(
                  dropdownColor: context.textTheme.headlineSmall!.color,
                  value: settingsController.localeMode.languageCode,
                  style: Styles.poppins(
                    fontSize: 16.sp,
                    fontWeight: Styles.medium,
                    color: context.textTheme.displayMedium!.color,
                  ),
                  iconEnabledColor: context.textTheme.displayMedium!.color,
                  iconDisabledColor: context.textTheme.displayMedium!.color,
                  underline: const SizedBox.shrink(),
                  items: [
                    'en',
                    'fr',
                  ]
                      .map(
                        (language) => DropdownMenuItem(
                          value: language,
                          child: Text(
                            Functions.of(context).translateKey(language),
                            style: Styles.poppins(
                              fontSize: 16.sp,
                              color: context.textTheme.displayMedium!.color,
                            ),
                          ),
                          onTap: () {
                            settingsController
                                .updateLocaleMode(Locale(language));
                          },
                        ),
                      )
                      .toList(),
                  onChanged: (language) {},
                ),
              ),
              16.widthSp,
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.welcometo,
                  style: Styles.poppins(
                    fontSize: 18.sp,
                    fontWeight: Styles.semiBold,
                    color: context.textTheme.displayLarge!.color,
                  ),
                ),
                64.heightSp,
                Image.asset(
                  'assets/images/logo_transparent.png',
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                  height: 200.h,
                ),
              ],
            ),
          ),
          Container(
            height: 0.35.sh,
            width: 1.sw,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/background_bottom.png',
                ),
                fit: BoxFit.cover,
                scale: 4,
                alignment: Alignment.topCenter,
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 32.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomElevatedButton(
                  label: AppLocalizations.of(context)!.agree_and_continue,
                  onPressed: () =>
                      settingsController.updateShowOnboarding(false),
                  borderColor: Colors.white,
                ),
                16.heightSp,
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: Styles.poppins(
                      fontSize: 14.sp,
                      fontWeight: Styles.bold,
                      color: Colors.white,
                    ),
                    children: [
                      TextSpan(
                        text: '${AppLocalizations.of(context)!.terms_tap} ',
                        style: Styles.poppins(
                          fontSize: 14.sp,
                          fontWeight: Styles.medium,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context)!.agree_and_continue,
                        style: Styles.poppins(
                          fontSize: 14.sp,
                          fontWeight: Styles.bold,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text:
                            ' ${AppLocalizations.of(context)!.terms_to_accept} ',
                        style: Styles.poppins(
                          fontSize: 14.sp,
                          fontWeight: Styles.medium,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context)!.terms_bayan,
                        style: Styles.poppins(
                          fontSize: 14.sp,
                          fontWeight: Styles.bold,
                          color: Colors.white,
                          textDecoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap =
                              () => context.push(widget: const PrivacyPolicy()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
