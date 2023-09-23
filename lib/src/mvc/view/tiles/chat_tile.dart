import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:badges/badges.dart' as badge;

import '../../../tools.dart';
import '../../../extensions.dart';
import '../../model/models.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({
    super.key,
    required this.chat,
  });

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: chat.seen ? null : context.textTheme.headlineSmall!.color,
      padding: EdgeInsetsDirectional.only(end: 16.sp),
      child: Row(
        children: [
          Container(
            width: 5.sp,
            height: 80.sp,
            color: chat.seen ? null : Styles.green,
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
            showBadge: chat.isOnline,
            child: CircleAvatar(
              radius: 30.sp,
              backgroundColor: context.textTheme.headlineMedium!.color,
              backgroundImage: chat.photo,
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
                        chat.displayName,
                        overflow: TextOverflow.ellipsis,
                        style: Styles.poppins(
                          fontSize: 14.sp,
                          fontWeight: Styles.bold,
                          color: context.textTheme.displayLarge!.color,
                        ),
                      ),
                      Text(
                        chat.lastMessage,
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
                    chat.updatedAt,
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
    );
  }
}
