import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../extensions.dart';
import '../../../../settings.dart';
import '../../../model/enums.dart';
import '../../../model/models.dart';
import '../../model_widgets.dart';
import '../../../../tools.dart';
import '../../screens.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
    required this.userSession,
    required this.settingsController,
  });

  final UserSession userSession;
  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.sp),
                child: Column(
                  children: [
                    CustomElevatedListTile(
                      leadingIcon: AwesomeIcons.user_rounded,
                      title: AppLocalizations.of(context)!.edit_profile,
                      showContainerDecoration: false,
                      showTrailing: false,
                      padding: EdgeInsets.all(12.sp),
                      onTap: () => context.push(
                        widget: const EditProfile(),
                      ),
                    ),
                    16.heightSp,
                    CustomElevatedListTile(
                      leadingIcon: AwesomeIcons.bell,
                      title:
                          AppLocalizations.of(context)!.notification_settings,
                      showContainerDecoration: false,
                      showTrailing: false,
                      padding: EdgeInsets.all(12.sp),
                      onTap: () => context.push(
                        widget: const NotificationSettings(),
                      ),
                    ),
                    16.heightSp,
                    CustomElevatedListTile(
                      leadingIcon: AwesomeIcons.lock_rounded,
                      title: AppLocalizations.of(context)!.security_settings,
                      showContainerDecoration: false,
                      showTrailing: false,
                      padding: EdgeInsets.all(12.sp),
                      onTap: () => context.push(
                        widget: SecuritySettings(
                          userSession: userSession,
                        ),
                      ),
                    ),
                    16.heightSp,
                    CustomElevatedListTile(
                      leadingIcon: AwesomeIcons.shield,
                      title: AppLocalizations.of(context)!.privacy_policy,
                      showContainerDecoration: false,
                      showTrailing: false,
                      padding: EdgeInsets.all(12.sp),
                      onTap: () => context.push(
                        widget: const PrivacyPolicy(),
                      ),
                    ),
                    16.heightSp,
                    CustomElevatedListTile(
                      leadingIcon: AwesomeIcons.heart,
                      title: AppLocalizations.of(context)!.my_favorites,
                      showContainerDecoration: false,
                      showTrailing: false,
                      padding: EdgeInsets.all(12.sp),
                      onTap: () {
                        //TODO my favorites
                      },
                    ),
                    16.heightSp,
                    CustomElevatedListTile(
                      leadingIcon: AwesomeIcons.language,
                      title: AppLocalizations.of(context)!.language,
                      showContainerDecoration: false,
                      showTrailing: false,
                      padding: EdgeInsets.all(12.sp),
                      onTap: () => context.push(
                        widget: LanguageSettings(
                          settingsController: settingsController,
                        ),
                      ),
                    ),
                    16.heightSp,
                    CustomElevatedListTile(
                      leadingIcon: AwesomeIcons.id_card_rounded,
                      title: AppLocalizations.of(context)!
                          .document_id_verification,
                      showContainerDecoration: false,
                      showTrailing: false,
                      padding: EdgeInsets.all(12.sp),
                      onTap: () =>
                          context.push(widget: const DumentsIdVerification()),
                    ),
                    16.heightSp,
                    CustomElevatedListTile(
                      leadingIcon: AwesomeIcons.circle_question,
                      title: AppLocalizations.of(context)!.faq_and_support,
                      showContainerDecoration: false,
                      showTrailing: false,
                      padding: EdgeInsets.all(12.sp),
                      onTap: () => context.push(widget: const FAQSupport()),
                    ),
                    16.heightSp,
                    CustomElevatedListTile(
                      leadingIcon: AwesomeIcons.id_card_close,
                      title: AppLocalizations.of(context)!.deactive_account,
                      showContainerDecoration: false,
                      showTrailing: false,
                      padding: EdgeInsets.all(12.sp),
                      onTap: () {},
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
}
