import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../settings.dart';
import '../../../../extensions.dart';
import '../../../../tools.dart';
import '../../../model/models.dart';
import '../../../model/models_ui.dart';
import '../../model_widgets.dart';
import '../../screens.dart';

class Page5Profile extends StatelessWidget {
  const Page5Profile({
    super.key,
    required this.userSession,
    required this.settingsController,
  });

  final UserSession userSession;
  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.sp),
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: CustomElevatedContainer(
              padding: EdgeInsets.all(16.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 45.sp,
                    backgroundColor: context.textTheme.headlineSmall!.color,
                    foregroundImage: const CachedNetworkImageProvider(
                      'https://i.pinimg.com/1200x/a1/1e/2a/a11e2a9d5803e4dc2c034819ce12a16e.jpg',
                    ),
                  ),
                  12.heightSp,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Pierre Owona',
                        style: Styles.poppins(
                          fontSize: 20.sp,
                          fontWeight: Styles.bold,
                          color: context.textTheme.displayLarge!.color,
                        ),
                      ),
                      8.widthSp,
                      Icon(
                        AwesomeIcons.badge_check,
                        color: Styles.blue,
                        size: 20.sp,
                      ),
                    ],
                  ),
                  Text(
                    'pierre.owona@gmail.com',
                    style: Styles.poppins(
                      fontSize: 14.sp,
                      fontWeight: Styles.regular,
                      color: context.textTheme.displaySmall!.color,
                    ),
                  ),
                  CustomDivider(
                    height: 25.sp,
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adiing elit, sed do eiusmod tempor incididunt ut labore et dore magna alua. Ut enim ad minim venm, quis nostrud exercitation ullamco laboris nisi ut.',
                    textAlign: TextAlign.center,
                    style: Styles.poppins(
                      fontSize: 12.sp,
                      fontWeight: Styles.medium,
                      color: context.textTheme.displayLarge!.color,
                    ),
                  ),
                ],
              ),
            ),
          ),
          24.sliverSp,
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomFlatButton(
                  icon: AwesomeIcons.facebook_f,
                  iconColor: const Color(0xFF3B5998),
                  iconSize: 30.sp,
                  addBorder: true,
                  color: context.scaffoldBackgroundColor,
                ),
                16.widthSp,
                CustomFlatButton(
                  icon: AwesomeIcons.twitter,
                  iconColor: const Color(0xFF00ACEE),
                  iconSize: 30.sp,
                  addBorder: true,
                  color: context.scaffoldBackgroundColor,
                ),
                16.widthSp,
                CustomFlatButton(
                  icon: AwesomeIcons.linkedin_in,
                  iconColor: const Color(0xFF0A66C2),
                  iconSize: 30.sp,
                  addBorder: true,
                  color: context.scaffoldBackgroundColor,
                ),
                16.widthSp,
                CustomFlatButton(
                  icon: AwesomeIcons.share_from_square,
                  iconColor: Styles.green,
                  iconSize: 30.sp,
                  addBorder: true,
                  color: context.scaffoldBackgroundColor,
                  onTap: () => Share.share(
                    'Share example, what to write here will be changed later',
                    subject: 'Title share',
                  ),
                ),
              ],
            ),
          ),
          24.sliverSp,
          SliverToBoxAdapter(
            child: CustomElevatedListTile(
              leadingIcon: AwesomeIcons.ads,
              title: AppLocalizations.of(context)!.manage_ads,
              onTap: () {},
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
              )),
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
            ),
          ),
          (context.viewPadding.bottom + 20.sp).sliver,
        ],
      ),
    );
  }
}
