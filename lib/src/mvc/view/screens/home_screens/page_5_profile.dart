//TODO translate
import 'package:bayam/src/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../tools.dart';
import '../../../model/models.dart';
import '../../../model/models_ui.dart';
import '../../model_widgets.dart';

class Page5Profile extends StatelessWidget {
  const Page5Profile({
    super.key,
    required this.userSession,
  });

  final UserSession userSession;

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
                  Text(
                    'Pierre Owona',
                    style: Styles.poppins(
                      fontSize: 20.sp,
                      fontWeight: Styles.bold,
                      color: context.textTheme.displayLarge!.color,
                    ),
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
          const SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomRectangleIconButton(
                  icon: AwesomeIcons.facebook_f,
                  color: Color(0xFF3B5998),
                ),
                CustomRectangleIconButton(
                  icon: AwesomeIcons.twitter,
                  color: Color(0xFF00ACEE),
                ),
                CustomRectangleIconButton(
                  icon: AwesomeIcons.linkedin_in,
                  color: Color(0xFF0A66C2),
                ),
                CustomRectangleIconButton(
                  icon: AwesomeIcons.share_from_square,
                  color: Styles.green,
                ),
              ],
            ),
          ),
          24.sliverSp,
          SliverToBoxAdapter(
            child: CustomElevatedListTile(
              icon: AwesomeIcons.ads,
              title: AppLocalizations.of(context)!.manage_ads,
              onTap: () {},
            ),
          ),
          16.sliverSp,
          SliverToBoxAdapter(
            child: CustomElevatedListTile(
              icon: AwesomeIcons.gear,
              title: AppLocalizations.of(context)!.settings,
              onTap: () {},
            ),
          ),
          16.sliverSp,
          SliverToBoxAdapter(
            child: CustomElevatedListTile(
              icon: AwesomeIcons.door_exit,
              title: AppLocalizations.of(context)!.logout,
              onTap: () => Dialogs.of(context).showCustomDialog(
                title: AppLocalizations.of(context)!.logout,
                subtitle: AppLocalizations.of(context)!.logout_subtitle,
                yesAct: ModelTextButton(
                  label: AppLocalizations.of(context)!.continu,
                  color: Styles.red,
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
