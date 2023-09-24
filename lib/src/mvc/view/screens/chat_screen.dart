//
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:badges/badges.dart' as badge;

import '../../../extensions.dart';
import '../../../tools.dart';
import '../../model/enums.dart';
import '../../model/list_models.dart';
import '../model_widgets.dart';
import '../model_widgets_screens.dart';
import '../tiles.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    super.key,
    required this.displayName,
    required this.photoUrl,
    required this.isOnline,
    required this.lastSeen,
  });

  final String displayName;
  final String photoUrl;
  final bool? isOnline;
  final DateTime? lastSeen;

  @override
  Widget build(BuildContext context) {
    bool online = isOnline ?? Random().nextBool();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            badge.Badge(
              badgeStyle: badge.BadgeStyle(
                badgeColor: Styles.green[500]!,
                elevation: 0,
                borderSide: BorderSide(
                  color: context.scaffoldBackgroundColor,
                  width: 2.sp,
                ),
                padding: EdgeInsets.all(7.sp),
              ),
              badgeAnimation: const badge.BadgeAnimation.scale(
                toAnimate: false,
              ),
              position: badge.BadgePosition.topEnd(
                top: 0.sp,
                end: 0.sp,
              ),
              showBadge: online,
              child: CircleAvatar(
                radius: 25.sp,
                backgroundColor: Styles.green[200],
                backgroundImage: CachedNetworkImageProvider(
                  photoUrl,
                ),
              ),
            ),
            8.widthSp,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    displayName,
                    style: Styles.poppins(
                      fontSize: 16.sp,
                      fontWeight: Styles.semiBold,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  Text(
                    online
                        ? 'Online'
                        : DateTimeUtils.of(context).formatElapsedAgo(
                            DateTime.now().subtract(
                              Duration(
                                minutes: Random().nextInt(1000),
                              ),
                            ),
                          )!,
                    style: Styles.poppins(
                      fontSize: 12.sp,
                      fontWeight: Styles.regular,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        leading: IconButton(
          icon: Icon(
            context.backButtonIcon,
            color: Colors.white,
            size: 20.sp,
          ),
          onPressed: context.pop,
        ),
        actions: [
          IconButton(
            icon: Icon(
              AwesomeIcons.phone,
              color: Colors.white,
              size: 20.sp,
            ),
            onPressed: context.pop,
          ),
          AppBarActionButton(
            icon: AwesomeIcons.magnifying_glass,
            onTap: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          const CustomAppBarBackground(
            type: AppBarBackgroundType.shrink,
          ),
          Expanded(
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              reverse: true,
              padding: EdgeInsets.all(16.sp),
              itemCount: ListData.aiChat.length,
              separatorBuilder: (context, index) => 8.heightSp,
              itemBuilder: (context, index) => MessageTile(
                message: ListData.aiChat.elementAt(index),
                lastMessage: index > 0 ? ListData.aiChat[index - 1] : null,
              ),
            ),
          ),
          const ChatSendMessage(),
        ],
      ),
    );
  }
}
