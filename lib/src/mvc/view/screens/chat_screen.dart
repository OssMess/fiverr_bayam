import 'dart:io';
import 'dart:math';

import 'package:badges/badges.dart' as badge;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import '../../../extensions.dart';
import '../../../tools.dart';
import '../../model/enums.dart';
import '../../model/list_models.dart';
import '../../model/models.dart';
import '../model_widgets.dart';
import '../model_widgets_screens.dart';
import '../tiles.dart';

class ChatScreen extends StatefulWidget {
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
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    bool online = widget.isOnline ?? Random().nextBool();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: kToolbarHeight,
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
                  widget.photoUrl,
                ),
              ),
            ),
            8.widthSp,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.displayName,
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
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              AwesomeIcons.video,
              color: Colors.white,
              size: 20.sp,
            ),
            onPressed: () {},
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
          ChatSendMessage(
            onSendMessage: onSendMessage,
          ),
        ],
      ),
    );
  }

  Future<void> onSendMessage(
    String? msg,
    String? audioPath,
    String? imagePath,
  ) async {
    if (msg.isNullOrEmpty &&
        audioPath.isNullOrEmpty &&
        imagePath.isNullOrEmpty) {
      return;
    }
    if (!msg.isNullOrEmpty) {
      ListData.aiChat.insert(
        0,
        Message.fromJson(
          {
            'senderId': 'myid',
            'senderAvatarUrl':
                'https://i.pinimg.com/1200x/a1/1e/2a/a11e2a9d5803e4dc2c034819ce12a16e.jpg',
            'message': msg,
            'createdAt': DateTime.now(),
            'photoUrl': null,
            'aspectRatio': null,
            'isSending': true,
          },
        ),
      );
      Future.delayed(
        const Duration(milliseconds: 500),
        () {
          ListData.aiChat.where((element) => element.isSending).forEach(
            (message) {
              message.isSending = false;
              setState(() {});
            },
          );
        },
      );
    } else if (!audioPath.isNullOrEmpty) {
      ListData.aiChat.insert(
        0,
        Message.fromJson(
          {
            'senderId': 'myid',
            'senderAvatarUrl':
                'https://i.pinimg.com/1200x/a1/1e/2a/a11e2a9d5803e4dc2c034819ce12a16e.jpg',
            'message': null,
            'createdAt': DateTime.now(),
            'photoUrl': null,
            'aspectRatio': null,
            'audioUrl': audioPath,
            'isSending': true,
          },
        ),
      );
      Future.delayed(
        const Duration(milliseconds: 500),
        () {
          ListData.aiChat
              .where((element) =>
                  element.audioUrl != null &&
                  element.audioUrl!.contains('m4a') &&
                  element.isSending)
              .forEach(
            (message) {
              File(message.audioUrl!).delete();
              message.audioUrl =
                  'https://firebasestorage.googleapis.com/v0/b/weclickk.appspot.com/o/chatAudios%2FZk9ngZprqVVeHegAVuyENA2mQ963_1695579031.m4a?alt=media&token=3e882c90-f672-4733-80a8-0b6e240874f5';
              message.isSending = false;
              setState(() {});
            },
          );
        },
      );
    } else if (!imagePath.isNullOrEmpty) {
      double? aspectRatio = await getImageAspectRatioFromPath(imagePath!);
      ListData.aiChat.insert(
        0,
        Message.fromJson(
          {
            'senderId': 'myid',
            'senderAvatarUrl':
                'https://i.pinimg.com/1200x/a1/1e/2a/a11e2a9d5803e4dc2c034819ce12a16e.jpg',
            'message': null,
            'createdAt': DateTime.now(),
            'photoUrl': imagePath,
            'aspectRatio': aspectRatio,
            'audioUrl': null,
            'isSending': true,
          },
        ),
      );
      Future.delayed(
        const Duration(milliseconds: 500),
        () {
          ListData.aiChat.where((element) => element.isSending).forEach(
            (message) {
              message.isSending = false;
              setState(() {});
            },
          );
        },
      );
    }
    setState(() {});
  }

  Future<double> getImageAspectRatioFromPath(String imagePath) async {
    File image = File(imagePath);
    var decodedImage = await decodeImageFromList(image.readAsBytesSync());
    Size size =
        Size(decodedImage.width.toDouble(), decodedImage.height.toDouble());
    return size.aspectRatio;
  }
}
