import 'dart:ui';

import 'package:badges/badges.dart' as badge;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../extensions.dart';
import '../../../tools.dart';
import '../../model/models.dart';
import '../tiles.dart';

class MessageTile extends StatefulWidget {
  const MessageTile({
    super.key,
    required this.avatar,
    required this.message,
    required this.lastMessage,
  });

  final ImageProvider<Object>? avatar;
  final Message message;
  final Message? lastMessage;

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  late bool showAvatar, showTime;
  @override
  void initState() {
    showAvatar = widget.lastMessage?.isMine != widget.message.isMine;
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
    return ChangeNotifierProvider.value(
      value: widget.message,
      child: Consumer<Message>(
        builder: (context, message, _) {
          var rowChildren = [
            if (!widget.message.isMine)
              CircleAvatar(
                radius: 18.sp,
                backgroundColor: context.scaffoldBackgroundColor,
                foregroundImage: showAvatar ? widget.avatar : null,
              ),
            12.widthSp,
            ClipRRect(
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(12.sp)).add(
                BorderRadiusDirectional.only(
                  bottomEnd: widget.message.isMine
                      ? Radius.zero
                      : Radius.circular(12.sp),
                  bottomStart: !widget.message.isMine
                      ? Radius.zero
                      : Radius.circular(12.sp),
                ),
              ),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 0.65.sw,
                  minWidth: 70.sp,
                ),
                padding: widget.message.isText
                    ? EdgeInsets.symmetric(horizontal: 16.sp, vertical: 12.sp)
                    : null,
                decoration: BoxDecoration(
                  color: widget.message.isMine
                      ? Styles.green
                      : context.textTheme.headlineSmall!.color,
                ),
                child: Builder(
                  builder: (context) {
                    // if (widget.message.isAudio) {
                    //   return VoiceMessage(
                    //     audioSrc: widget.message.audioUrl!,
                    //     played: false,
                    //     me: true,
                    //     onPlay: () {},
                    //     meBgColor: Styles.green,
                    //     meFgColor: Colors.white,
                    //   );
                    // }
                    if (widget.message.isImage) {
                      return Builder(
                        builder: (context) {
                          if (widget.message.images.length == 1) {
                            return InkResponse(
                              onTap: () =>
                                  Dialogs.of(context).showSingleImageSlideShow(
                                widget.message.images.first,
                              ),
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Image(
                                  image: widget.message.images.first,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }
                          return Column(
                            children: [
                              AspectRatio(
                                aspectRatio: 2,
                                child: Row(
                                  children: [
                                    ChatImageCard(
                                      aspectRatio: 1,
                                      index: 0,
                                      images: widget.message.images,
                                    ),
                                    ChatImageCard(
                                      aspectRatio: 1,
                                      index: 1,
                                      images: widget.message.images,
                                    ),
                                  ],
                                ),
                              ),
                              if (widget.message.images.length == 3)
                                ChatImageCard(
                                  aspectRatio: 2,
                                  index: 2,
                                  images: widget.message.images,
                                ),
                              if (widget.message.images.length > 3)
                                AspectRatio(
                                  aspectRatio: 2,
                                  child: Row(
                                    children: [
                                      ChatImageCard(
                                        aspectRatio: 1,
                                        index: 2,
                                        images: widget.message.images,
                                      ),
                                      ChatImageCard(
                                        aspectRatio: 1,
                                        index: 3,
                                        images: widget.message.images,
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          );
                        },
                      );
                    }
                    return Text(
                      widget.message.message,
                      style: Styles.poppins(
                        color: widget.message.isMine
                            ? Colors.white
                            : context.textTheme.displayMedium!.color,
                        fontSize: 16.sp,
                        fontWeight: Styles.medium,
                      ),
                    );
                  },
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
                showBadge: message.isSending || message.isError,
                position: message.isSending
                    ? badge.BadgePosition.bottomEnd(
                        bottom: -10,
                        end: -2,
                      )
                    : badge.BadgePosition.bottomEnd(
                        bottom: -16,
                        end: -4,
                      ),
                badgeContent: message.isSending
                    ? Container(
                        width: 10.sp,
                        height: 10.sp,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: context.primaryColor,
                            width: 2.sp,
                          ),
                          shape: BoxShape.circle,
                        ),
                      )
                    : message.isError
                        ? Icon(
                            Icons.info_outline,
                            size: 16.sp,
                            color: Styles.red,
                          )
                        : null,
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
                      DateTimeUtils.of(context)
                          .format(widget.message.createdAt),
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
                        DateTimeUtils.of(context)
                            .format(widget.message.createdAt),
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
                        foregroundImage: widget.avatar,
                      ),
                    ],
                    4.widthSp,
                    8.widthSp,
                  ],
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  int get threshold => 15;
}
