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
    required this.userSession,
    required this.discussion,
  });

  final UserSession userSession;
  final Discussion discussion;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () => context.push(
        widget: ChatScreen(
          userSession: userSession,
          discussion: discussion,
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
            Builder(builder: (context) {
              String? elapsedOnline =
                  discussion.receiver.elapsedOnline(context);
              return badge.Badge(
                badgeStyle: badge.BadgeStyle(
                  shape: badge.BadgeShape.square,
                  borderRadius: BorderRadius.circular(50),
                  badgeColor: Styles.green[500]!,
                  elevation: 0,
                  borderSide: BorderSide(
                    color: context.scaffoldBackgroundColor,
                    width: 2.sp,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 4.sp,
                    horizontal: 6.sp,
                  ),
                ),
                badgeAnimation: const badge.BadgeAnimation.scale(
                  toAnimate: false,
                ),
                position: elapsedOnline == '0'
                    ? badge.BadgePosition.topEnd(
                        top: -4.sp,
                        end: -6.sp,
                      )
                    : badge.BadgePosition.topEnd(
                        top: -4.sp,
                        end: -6.sp,
                      ),
                badgeContent: Builder(
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        elapsedOnline ?? '0',
                        style: Styles.poppins(
                          fontSize: 12.sp,
                          fontWeight: Styles.semiBold,
                          color: elapsedOnline == '0'
                              ? Styles.green[500]!
                              : Colors.white,
                          height: 1.sp,
                        ),
                      ),
                    );
                  },
                ),
                showBadge: discussion.receiver.isOnline,
                child: CircleAvatar(
                  radius: 30.sp,
                  backgroundColor: context.textTheme.headlineMedium!.color,
                  backgroundImage: discussion.image,
                ),
              );
            }),
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
