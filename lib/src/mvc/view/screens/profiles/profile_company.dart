// TODO: translate

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:badges/badges.dart' as badge;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../extensions.dart';
import '../../../model/enums.dart';
import '../../model_widgets.dart';
import '../../../../tools.dart';

class ProfileCompany extends StatelessWidget {
  const ProfileCompany({
    super.key,
  });

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
                    CustomElevatedContainer(
                      padding: EdgeInsets.all(16.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          badge.Badge(
                            badgeStyle: badge.BadgeStyle(
                              badgeColor: Styles.green[500]!,
                              elevation: 0,
                              borderSide: BorderSide(
                                color: context.scaffoldBackgroundColor,
                                width: 2.sp,
                              ),
                              padding: EdgeInsets.all(9.sp),
                            ),
                            badgeAnimation: const badge.BadgeAnimation.scale(
                              toAnimate: false,
                            ),
                            position: badge.BadgePosition.bottomEnd(
                              bottom: 2.sp,
                              end: 2.sp,
                            ),
                            showBadge: true,
                            child: CircleAvatar(
                              radius: 45.sp,
                              backgroundColor:
                                  context.textTheme.headlineSmall!.color,
                              foregroundImage: const CachedNetworkImageProvider(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDLL2FyAeYaShg5h1YrW3gEyDHDCUb5o2_lw&usqp=CAU',
                              ),
                            ),
                          ),
                          12.heightSp,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'BigMop',
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
                            'Bigmop@gmail.com',
                            style: Styles.poppins(
                              fontSize: 14.sp,
                              fontWeight: Styles.regular,
                              color: context.textTheme.displaySmall!.color,
                            ),
                          ),
                          CustomDivider(
                            height: 25.sp,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomFlatButton(
                                icon: AwesomeIcons.chat,
                                addBorder: true,
                                color: context.scaffoldBackgroundColor,
                              ),
                              16.widthSp,
                              CustomFlatButton(
                                icon: AwesomeIcons.phone,
                                addBorder: true,
                                color: context.scaffoldBackgroundColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    24.heightSp,
                    Row(
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
                        ),
                      ],
                    ),
                    24.heightSp,
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        AppLocalizations.of(context)!.company_description,
                        textAlign: TextAlign.center,
                        style: Styles.poppins(
                          fontSize: 14.sp,
                          fontWeight: Styles.semiBold,
                          color: context.textTheme.displayLarge!.color,
                        ),
                      ),
                    ),
                    12.heightSp,
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adiing elit, sed do eiusmod tempor incididunt ut labore et dore magna alua. Ut enim ad minim venm, quis nostrud exercitation ullamco laboris nisi ut.',
                      textAlign: TextAlign.center,
                      style: Styles.poppins(
                        fontSize: 14.sp,
                        fontWeight: Styles.medium,
                        color: context.textTheme.displayLarge!.color,
                      ),
                    ),
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
