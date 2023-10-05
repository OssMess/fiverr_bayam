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
import '../../screens.dart';

class ProfileCompany extends StatelessWidget {
  const ProfileCompany({
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
                padding: EdgeInsets.symmetric(horizontal: 16.sp),
                child: Column(
                  children: [
                    ProfileHeader(
                      displayName: 'BigMop',
                      email: 'Bigmop@gmail.com',
                      photoUrl:
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDLL2FyAeYaShg5h1YrW3gEyDHDCUb5o2_lw&usqp=CAU',
                      isVerified: true,
                      isOnline: true,
                      actions: [
                        ModelIconButton(
                          icon: AwesomeIcons.chat,
                          color: context.scaffoldBackgroundColor,
                          onPressed: () => context.push(
                            widget: const ChatScreen(
                              displayName: 'BigMop',
                              photoUrl:
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDLL2FyAeYaShg5h1YrW3gEyDHDCUb5o2_lw&usqp=CAU',
                              isOnline: null,
                              lastSeen: null,
                            ),
                          ),
                        ),
                        ModelIconButton(
                          icon: AwesomeIcons.phone,
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
                        AppLocalizations.of(context)!.company_description,
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
