import 'package:bayam/src/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:badges/badges.dart' as badge;

import '../../../tools.dart';
import '../../model/models.dart';
import '../model_widgets.dart';
import '../tiles_models.dart';

class MessageTile extends StatefulWidget {
  const MessageTile({
    super.key,
    required this.message,
    required this.lastMessage,
  });

  final Message message;
  final Message? lastMessage;

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  late bool showAvatar, showTime;
  @override
  void initState() {
    showAvatar = widget.lastMessage?.senderId != widget.message.senderId;
    showTime = widget.lastMessage == null ||
        widget.lastMessage!.isMine != widget.message.isMine ||
        widget.lastMessage!.createdAt
                .difference(widget.message.createdAt)
                .inMinutes
                .abs() >=
            threshold;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var rowChildren = [
      if (!widget.message.isMine)
        CircleAvatar(
          radius: 18.sp,
          backgroundColor: context.scaffoldBackgroundColor,
          foregroundImage: showAvatar ? widget.message.senderAvatar : null,
        ),
      12.widthSp,
      Container(
        constraints: BoxConstraints(
          maxWidth: 0.65.sw,
          minWidth: 70.sp,
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 12.sp),
        decoration: BoxDecoration(
          color: widget.message.isMine
              ? Styles.green
              : context.textTheme.headlineSmall!.color,
          borderRadius: BorderRadius.vertical(top: Radius.circular(12.sp)).add(
            BorderRadiusDirectional.only(
              bottomEnd:
                  widget.message.isMine ? Radius.zero : Radius.circular(12.sp),
              bottomStart:
                  !widget.message.isMine ? Radius.zero : Radius.circular(12.sp),
            ),
          ),
        ),
        child: Text(
          widget.message.message!,
          style: Styles.poppins(
            color: widget.message.isMine
                ? Colors.white
                : context.textTheme.displayMedium!.color,
            fontSize: 14.sp,
            fontWeight: Styles.medium,
          ),
        ),
      ),
      widget.message.isMine ? 0.widthSp : 60.widthSp,
    ];
    return Column(
      crossAxisAlignment: widget.message.isMine
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        badge.Badge(
          badgeStyle: const badge.BadgeStyle(
            badgeColor: Colors.transparent,
            elevation: 0,
            padding: EdgeInsets.zero,
          ),
          showBadge: widget.message.isSending,
          position: badge.BadgePosition.bottomEnd(
            bottom: -10,
            end: -2,
          ),
          badgeContent: Container(
            width: 10.sp,
            height: 10.sp,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: Theme.of(context).primaryColor,
                width: 2.sp,
              ),
              shape: BoxShape.circle,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: widget.message.isMine
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: widget.message.isMine
                ? rowChildren.reversed.toList()
                : rowChildren,
          ),
        ),

        /// I am not the send, show time bellow message
        if (!widget.message.isMine && showTime) ...[
          Row(
            children: [
              48.widthSp,
              Text(
                DateTimeUtils.of(context).format(widget.message.createdAt),
                style: Styles.poppins(
                  fontSize: 12.sp,
                  fontWeight: Styles.regular,
                  color: context.textTheme.displayMedium!.color,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ],

        /// I am the sender, show sending icon, avatar, and time bellow message
        if (widget.message.isMine &&
            (widget.message.isSending || showAvatar || showTime)) ...[
          4.heightSp,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: widget.message.isMine
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              if (showTime) ...[
                Text(
                  DateTimeUtils.of(context).format(widget.message.createdAt),
                  style: Styles.poppins(
                    fontSize: 12.sp,
                    fontWeight: Styles.regular,
                    color: context.textTheme.displayMedium!.color,
                    height: 1.2,
                  ),
                ),
              ],
              if (showAvatar) ...[
                8.widthSp,
                CircleAvatar(
                  radius: 10.sp,
                  backgroundColor: context.textTheme.headlineSmall!.color,
                  foregroundImage: widget.message.senderAvatar,
                ),
              ],
              4.widthSp,
              8.widthSp,
              // widget.message.isSending
              //     ? Container(
              //         width: 8.sp,
              //         height: 8.sp,
              //         decoration: BoxDecoration(
              //           color: Colors.transparent,
              //           border: Border.all(
              //             color: Styles.green,
              //             width: 1.5.sp,
              //           ),
              //           shape: BoxShape.circle,
              //         ),
              //       )
              //     : 8.widthSp,
            ],
          ),
        ],
      ],
    );
  }

  int get threshold => 15;
}
