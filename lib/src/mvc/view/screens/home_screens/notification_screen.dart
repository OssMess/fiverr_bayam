import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../extensions.dart';
import '../../../../tools.dart';
import '../../../model/enums.dart';
import '../../../model/list_models.dart';
import '../../../model/models.dart';
import '../../model_widgets.dart';
import '../../model_widgets_screens.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBarBackground(
            type: AppBarBackgroundType.shrink,
            appBarTitleWidget: const CustomAppBarLogo(),
            appBarLeading: AppBarActionButton(
              icon: context.backButtonIcon,
              onTap: context.pop,
            ),
          ),
          16.heightSp,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            child: SettingsHeaderSubtitle(
              title: AppLocalizations.of(context)!.notifications,
              subtitle: AppLocalizations.of(context)!.nouveau,
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(
                horizontal: 16.sp,
                vertical: 20.sp,
              ).copyWith(
                bottom: context.viewPadding.bottom,
              ),
              itemBuilder: (context, index) => Builder(builder: (context) {
                AppNotification notification =
                    ListData.listNotifications[index];
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 48.sp,
                            child: ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => CircleAvatar(
                                radius: 24.sp,
                                backgroundColor:
                                    context.textTheme.headlineSmall!.color,
                                backgroundImage: CachedNetworkImageProvider(
                                  notification.leadingPhotoUrls[index],
                                ),
                              ),
                              separatorBuilder: (_, __) => 6.widthSp,
                              itemCount: notification.leadingPhotoUrls.length,
                            ),
                          ),
                        ),
                        Container(
                          height: 48.sp,
                          width: 48.sp,
                          decoration: BoxDecoration(
                            shape: notification.hasBorderRadius
                                ? BoxShape.rectangle
                                : BoxShape.circle,
                            borderRadius: notification.hasBorderRadius
                                ? BorderRadius.circular(12.sp)
                                : null,
                            color: context.textTheme.headlineSmall!.color,
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                notification.trailingPhotourl,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        6.widthSp,
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 16.sp,
                        ),
                      ],
                    ),
                    6.heightSp,
                    Row(
                      children: [
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: Styles.poppins(
                                fontSize: 14.sp,
                                fontWeight: Styles.medium,
                                color: context.textTheme.displayLarge!.color,
                              ),
                              children: [
                                TextSpan(
                                  text: '${notification.displayName} ',
                                ),
                                TextSpan(
                                  text: notification.type.translate(context),
                                  style: Styles.poppins(
                                    fontSize: 14.sp,
                                    fontWeight: Styles.regular,
                                    color:
                                        context.textTheme.displayLarge!.color,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        8.width,
                        Text(
                          DateTimeUtils.of(context).formatElapsedAgo(
                            notification.createdAt,
                          )!,
                          style: Styles.poppins(
                            fontSize: 14.sp,
                            fontWeight: Styles.regular,
                            color: context.textTheme.displayMedium!.color,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
              separatorBuilder: (_, __) => CustomDivider(
                height: 24.sp,
              ),
              itemCount: ListData.listNotifications.length,
            ),
          ),
        ],
      ),
    );
  }
}
