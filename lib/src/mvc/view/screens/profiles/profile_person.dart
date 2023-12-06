import 'package:bayam/src/mvc/view/screens.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../extensions.dart';
import '../../../model/enums.dart';
import '../../../model/models_ui.dart';
import '../../model_widgets.dart';
import '../../../../tools.dart';
import '../../model_widgets_screens.dart';

class ProfilePerson extends StatelessWidget {
  const ProfilePerson({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
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
                padding: EdgeInsets.symmetric(horizontal: 24.sp),
                child: Column(
                  children: [
                    ProfileHeader(
                      displayName: 'Pierre Owona',
                      email: 'pierre.owona@gmail.com',
                      imageProfile: const CachedNetworkImageProvider(
                          'https://i.pinimg.com/1200x/a1/1e/2a/a11e2a9d5803e4dc2c034819ce12a16e.jpg'),
                      isVerified: true,
                      isOnline: true,
                      actions: [
                        ModelIconButton(
                          icon: AwesomeIcons.chat,
                          onPressed: () => context.push(
                            widget: const ChatScreen(
                              displayName: 'Pierre Owona',
                              photoUrl:
                                  'https://i.pinimg.com/1200x/a1/1e/2a/a11e2a9d5803e4dc2c034819ce12a16e.jpg',
                              isOnline: null,
                              lastSeen: null,
                            ),
                          ),
                        ),
                        ModelIconButton(
                          icon: AwesomeIcons.phone,
                          color: context.scaffoldBackgroundColor,
                        ),
                        ModelIconButton(
                          icon: AwesomeIcons.video,
                          color: context.scaffoldBackgroundColor,
                        ),
                      ],
                      margin: EdgeInsets.zero,
                    ),
                    Padding(
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
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        AppLocalizations.of(context)!.about,
                        textAlign: TextAlign.center,
                        style: Styles.poppins(
                          fontSize: 16.sp,
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
                        fontSize: 16.sp,
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
