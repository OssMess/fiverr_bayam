import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import '../../../extensions.dart';
import '../../model/models.dart';
import '../model_widgets.dart';
import '../../../tools.dart';
import '../model_widgets_screens.dart';
import '../screens.dart';

class DetailsAdDescriptionBanner extends StatelessWidget {
  const DetailsAdDescriptionBanner({
    super.key,
    required this.userSession,
    required this.ad,
  });

  final UserSession userSession;
  final Ad ad;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedContainer(
      padding: EdgeInsets.all(16.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppLocalizations.of(context)!.description,
            style: Styles.poppins(
              fontSize: 16.sp,
              fontWeight: Styles.semiBold,
              color: context.textTheme.displayLarge!.color,
            ),
          ),
          8.heightSp,
          Text(
            ad.content,
            style: Styles.poppins(
              fontSize: 14.sp,
              fontWeight: Styles.medium,
              color: context.textTheme.displayLarge!.color,
            ),
          ),
          CustomDivider(
            height: 24.sp,
          ),
          DescriptionInfoTile(
            icon: AwesomeIcons.location_dot_outlined,
            label: ad.location,
          ),
          8.heightSp,
          DescriptionInfoTile(
            icon: AwesomeIcons.calendar_clock_outlined,
            label: DateFormat('dd-MM-yy').format(ad.createdAt),
          ),
          CustomDivider(
            height: 24.sp,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  direction: Axis.horizontal,
                  runAlignment: WrapAlignment.start,
                  runSpacing: 8.sp,
                  spacing: 8.sp,
                  children: ad.tags
                      .map(
                        (tag) => CustomFlatButton(
                          color: Styles.green[50],
                          child: Text(
                            tag.name,
                            style: Styles.poppins(
                              fontSize: 14.sp,
                              fontWeight: Styles.medium,
                              color: Styles.green,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
          CustomDivider(
            height: 24.sp,
          ),
          Row(
            children: [
              if (!ad.isMine) ...[
                CustomFlatButton(
                  onTap: () => ad.like(userSession),
                  child: Row(
                    children: [
                      Icon(
                        AwesomeIcons.heart,
                        color: Styles.green,
                        size: 20.sp,
                      ),
                      8.widthSp,
                      Text(
                        AppLocalizations.of(context)!.nb_likes(ad.likes),
                        style: Styles.poppins(
                          fontSize: 14.sp,
                          fontWeight: Styles.medium,
                          color: context.textTheme.displayLarge!.color,
                        ),
                      ),
                    ],
                  ),
                ),
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
                16.widthSp,
              ],
              CustomFlatButton(
                icon: AwesomeIcons.share_from_square,
                iconColor: Styles.green,
                color: context.scaffoldBackgroundColor,
                addBorder: true,
                onTap: () => Share.share(
                  'Share example, what to write here will be changed later',
                  subject: 'Title share',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
