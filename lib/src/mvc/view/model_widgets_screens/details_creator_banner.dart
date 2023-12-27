import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../extensions.dart';
import '../../model/models.dart';
import '../model_widgets.dart';
import '../../../tools.dart';
import '../screens.dart';

class DetailsCreatorBanner extends StatelessWidget {
  const DetailsCreatorBanner({
    super.key,
    required this.userSession,
    required this.ad,
  });

  final UserSession userSession;
  final Ad ad;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedContainer(
      onTap: () => context.push(
        widget: ProfilePerson(
          userSession: userSession,
          userMin: ad.author,
        ),
      ),
      padding: EdgeInsets.all(16.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.creator_information,
            style: Styles.poppins(
              fontSize: 16.sp,
              fontWeight: Styles.semiBold,
              color: context.textTheme.displayLarge!.color,
            ),
          ),
          8.heightSp,
          Row(
            children: [
              CircleAvatar(
                radius: 24.sp,
                backgroundColor: context.textTheme.headlineSmall!.color,
                backgroundImage: ad.author.image,
              ),
              16.widthSp,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          ad.author.displayName,
                          style: Styles.poppins(
                            fontSize: 14.sp,
                            fontWeight: Styles.semiBold,
                            color: context.textTheme.displayLarge!.color,
                            height: 1.2,
                          ),
                        ),
                        8.widthSp,
                        Icon(
                          AwesomeIcons.badge_check,
                          size: 16.sp,
                          color: Styles.blue,
                        ),
                      ],
                    ),
                    Text(
                      AppLocalizations.of(context)!.agriculture,
                      style: Styles.poppins(
                        fontSize: 12.sp,
                        fontWeight: Styles.regular,
                        color: context.textTheme.displayMedium!.color,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              16.widthSp,
              CustomFlatButton(
                icon: AwesomeIcons.thumbs_up,
                iconColor: context.textTheme.headlineMedium!.color,
                onTap: () {},
              ),
              if (!ad.isMine) ...[
                16.widthSp,
                CustomFlatButton(
                  icon: AwesomeIcons.flag_pennant,
                  iconColor: Styles.red,
                  onTap: () => context.push(
                    widget: ReportScreen(
                      userSession: userSession,
                      ad: ad,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
