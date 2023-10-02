import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../settings.dart';
import '../../../../extensions.dart';
import '../../../../tools.dart';
import '../../../model/change_notifiers.dart';
import '../../../model/models.dart';
import '../../../model/models_ui.dart';
import '../../model_widgets.dart';
import '../../model_widgets_screens.dart';
import '../../screens.dart';

class Page5PersonProfile extends StatelessWidget {
  const Page5PersonProfile({
    super.key,
    required this.userSession,
    required this.settingsController,
    required this.pageNotifier,
  });

  final UserSession userSession;
  final SettingsController settingsController;
  final NotifierPage pageNotifier;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        const SliverToBoxAdapter(
          child: ProfileHeader(
            displayName: 'Pierre Owona',
            email: 'pierre.owona@gmail.com',
            photoUrl:
                'https://i.pinimg.com/1200x/a1/1e/2a/a11e2a9d5803e4dc2c034819ce12a16e.jpg',
            isVerified: false,
            isOnline: false,
            description:
                'Lorem ipsum dolor sit amet, consectetur adiing elit, sed do eiusmod tempor incididunt ut labore et dore magna alua. Ut enim ad minim venm, quis nostrud exercitation ullamco laboris nisi ut.',
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 32.sp),
            child: ProfileRowActions(
              actions: [
                ModelIconButton(
                  icon: AwesomeIcons.facebook_f,
                  color: const Color(0xFF3B5998),
                ),
                ModelIconButton(
                  icon: AwesomeIcons.twitter,
                  color: const Color(0xFF00ACEE),
                ),
                ModelIconButton(
                  icon: AwesomeIcons.linkedin_in,
                  color: const Color(0xFF0A66C2),
                ),
                ModelIconButton(
                  icon: AwesomeIcons.share_from_square,
                  color: Styles.green,
                  onPressed: () => Share.share(
                    'Share example, what to write here will be changed later',
                    subject: 'Title share',
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: CustomElevatedListTile(
            leadingIcon: AwesomeIcons.ads,
            title: AppLocalizations.of(context)!.manage_ads,
            onTap: () => pageNotifier.setCurrentPage(2),
            margin: EdgeInsets.symmetric(horizontal: 24.sp),
          ),
        ),
        16.sliverSp,
        SliverToBoxAdapter(
          child: CustomElevatedListTile(
            leadingIcon: AwesomeIcons.gear,
            title: AppLocalizations.of(context)!.settings,
            onTap: () => context.push(
              widget: SettingsScreen(
                userSession: userSession,
                settingsController: settingsController,
              ),
            ),
            margin: EdgeInsets.symmetric(horizontal: 24.sp),
          ),
        ),
        16.sliverSp,
        SliverToBoxAdapter(
          child: CustomElevatedListTile(
            leadingIcon: AwesomeIcons.door_exit,
            title: AppLocalizations.of(context)!.logout,
            onTap: () => Dialogs.of(context).showCustomDialog(
              title: AppLocalizations.of(context)!.logout,
              subtitle: AppLocalizations.of(context)!.logout_subtitle,
              yesAct: ModelTextButton(
                label: AppLocalizations.of(context)!.continu,
                color: Styles.red,
                onPressed: () {
                  userSession.onSignout();
                  context.popUntilFirst();
                },
              ),
              noAct: ModelTextButton(
                label: AppLocalizations.of(context)!.cancel,
                fontColor: context.textTheme.displayLarge!.color,
                color: Styles.red[50],
              ),
            ),
            margin: EdgeInsets.symmetric(horizontal: 24.sp),
          ),
        ),
        (context.viewPadding.bottom + 20.sp).sliver,
      ],
    );
  }
}
