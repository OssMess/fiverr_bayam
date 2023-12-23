import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../extensions.dart';
import '../model_widgets.dart';
import '../../../tools.dart';
import '../screens.dart';

class DetailsCompanyBanner extends StatelessWidget {
  const DetailsCompanyBanner({
    super.key,
    required this.name,
    required this.logoUrl,
    required this.isMine,
  });

  final String name;
  final String? logoUrl;
  final bool isMine;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedContainer(
      onTap:
          !isMine ? () => context.push(widget: const ProfileCompany()) : null,
      padding: EdgeInsets.all(16.sp),
      child: Row(
        children: [
          Container(
            height: 65.sp,
            width: 65.sp,
            padding: EdgeInsets.all(4.sp),
            decoration: BoxDecoration(
              color: context.scaffoldBackgroundColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: context.textTheme.headlineMedium!.color!,
                width: 1.sp,
              ),
            ),
            child: CircleAvatar(
              backgroundColor: context.textTheme.headlineSmall!.color,
              backgroundImage: logoUrl.isNotNullOrEmpty
                  ? CachedNetworkImageProvider(
                      logoUrl!,
                    )
                  : null,
            ),
          ),
          16.widthSp,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.service_by,
                  style: Styles.poppins(
                    fontSize: 13.sp,
                    fontWeight: Styles.regular,
                    color: context.textTheme.displayMedium!.color,
                    height: 1.2,
                  ),
                ),
                Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  style: Styles.poppins(
                    fontSize: 16.sp,
                    fontWeight: Styles.semiBold,
                    color: context.textTheme.displayLarge!.color,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
          if (!isMine) ...[
            16.widthSp,
            IconButton(
              onPressed: () {
                //FIXME open discussion with user
              },
              // onPressed: () => context.push(
              //   widget: DiscussionScreen(
              //     displayName: name,
              //     photoUrl: logoUrl,
              //     isOnline: null,
              //     lastSeen: null,
              //   ),
              // ),
              icon: Icon(
                AwesomeIcons.chat_bold,
                color: Styles.green,
                size: 24.sp,
              ),
            )
          ],
        ],
      ),
    );
  }
}
