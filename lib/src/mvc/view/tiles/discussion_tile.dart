import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:badges/badges.dart' as badge;

import '../../../tools.dart';
import '../../../extensions.dart';
import '../../model/models.dart';
import '../screens.dart';

class DiscussionTile extends StatelessWidget {
  const DiscussionTile({
    super.key,
    required this.discussion,
  });

  final Discussion discussion;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () => context.push(
        widget: DiscussionScreen(
          displayName: discussion.displayName,
          photoUrl: discussion.imageUrl,
          isOnline: discussion.isOnline,
          lastSeen: null,
        ),
      ),
      child: Container(
        color:
            discussion.isSeen ? null : context.textTheme.headlineSmall!.color,
        padding: EdgeInsetsDirectional.only(end: 16.sp),
        child: Row(
          children: [
            Container(
              width: 5.sp,
              height: 80.sp,
              color: discussion.isSeen ? null : Styles.green,
            ),
            16.widthSp,
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
              position: badge.BadgePosition.topEnd(
                top: -1.sp,
                end: -1.sp,
              ),
              showBadge: discussion.isOnline,
              child: CircleAvatar(
                radius: 30.sp,
                backgroundColor: context.textTheme.headlineMedium!.color,
                backgroundImage: discussion.image,
              ),
            ),
            16.widthSp,
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          discussion.displayName,
                          overflow: TextOverflow.ellipsis,
                          style: Styles.poppins(
                            fontSize: 14.sp,
                            fontWeight: Styles.bold,
                            color: context.textTheme.displayLarge!.color,
                          ),
                        ),
                        Text(
                          discussion.lastMessage,
                          overflow: TextOverflow.ellipsis,
                          style: Styles.poppins(
                            fontSize: 12.sp,
                            fontWeight: Styles.regular,
                            color: context.textTheme.displayMedium!.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                  16.widthSp,
                  Text(
                    DateTimeUtils.of(context).formatElapsedAgo(
                      discussion.updatedAt,
                    )!,
                    style: Styles.poppins(
                      fontSize: 12.sp,
                      fontWeight: Styles.regular,
                      color: context.textTheme.displayMedium!.color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
