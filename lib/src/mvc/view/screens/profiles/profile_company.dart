import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../extensions.dart';
import '../../../model/enums.dart';
import '../../../model/models.dart';
import '../../../model/models_ui.dart';
import '../../model_widgets.dart';
import '../../../../tools.dart';
import '../../model_widgets_screens.dart';

class ProfileCompany extends StatelessWidget {
  const ProfileCompany({
    super.key,
    required this.userSession,
    required this.userMin,
  });

  final UserSession userSession;
  final UserMin userMin;

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
                      displayName: userMin.displayName,
                      email: userMin.email,
                      imageProfile: userMin.image,
                      isVerified: userMin.isVerified,
                      elapsedOnline: userMin.elapsedOnline(context),
                      actions: [
                        if (userMin.uid != userSession.uid)
                          ModelIconButton(
                            icon: AwesomeIcons.chat,
                            color: context.scaffoldBackgroundColor,
                            onPressed: () {
                              //FIXME get or create a discussion and opens screen
                            },
                          ),
                        ModelIconButton(
                          icon: AwesomeIcons.phone,
                          color: context.scaffoldBackgroundColor,
                          onPressed: () => launchUrl(
                            Uri.parse('tel:${userMin.phoneNumber}'),
                          ),
                        ),
                      ],
                      margin: EdgeInsets.zero,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 32.sp),
                      child: ProfileRowActions(
                        actions: [
                          if (userMin.facebookUrl.isNotNullOrEmpty)
                            ModelIconButton(
                              icon: AwesomeIcons.facebook_f,
                              color: const Color(0xFF3B5998),
                              onPressed: () => launchUrl(
                                Uri.parse(userMin.facebookUrl!),
                                mode: LaunchMode.externalApplication,
                              ),
                            ),
                          if (userMin.twitterUrl.isNotNullOrEmpty)
                            ModelIconButton(
                              icon: AwesomeIcons.twitter,
                              color: const Color(0xFF00ACEE),
                              onPressed: () => launchUrl(
                                Uri.parse(userMin.twitterUrl!),
                                mode: LaunchMode.externalApplication,
                              ),
                            ),
                          if (userMin.linkedinUrl.isNotNullOrEmpty)
                            ModelIconButton(
                              icon: AwesomeIcons.linkedin_in,
                              color: const Color(0xFF0A66C2),
                              onPressed: () => launchUrl(
                                Uri.parse(userMin.linkedinUrl!),
                                mode: LaunchMode.externalApplication,
                              ),
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
                    if (userMin.bio.isNotNullOrEmpty) ...[
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
                        userMin.bio!,
                        textAlign: TextAlign.center,
                        style: Styles.poppins(
                          fontSize: 16.sp,
                          fontWeight: Styles.medium,
                          color: context.textTheme.displayLarge!.color,
                        ),
                      ),
                    ],
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
