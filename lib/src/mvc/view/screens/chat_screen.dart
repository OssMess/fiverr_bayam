import 'dart:io';
import 'dart:math';

import 'package:badges/badges.dart' as badge;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../extensions.dart';
import '../../../tools.dart';
import '../../model/enums.dart';
import '../../model/list_models.dart';
import '../../model/models.dart';
import '../model_widgets.dart';
import '../model_widgets_screens.dart';
import '../tiles.dart';

class DiscussionScreen extends StatefulWidget {
  const DiscussionScreen({
    super.key,
    required this.userSession,
    required this.discussion,
  });

  final UserSession userSession;
  final Discussion discussion;

  @override
  State<DiscussionScreen> createState() => _DiscussionScreenState();
}

class _DiscussionScreenState extends State<DiscussionScreen> {
  @override
  void initState() {
    super.initState();
    widget.discussion.listMessages.initData(callGet: true);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: widget.discussion.listMessages,
        ),
        ChangeNotifierProvider.value(
          value: widget.discussion,
        ),
      ],
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: kToolbarHeight,
          backgroundColor: Colors.transparent,
          titleSpacing: 0,
          title: Consumer<Discussion>(
            builder: (context, discussion, _) {
              return Row(
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
                    showBadge: widget.discussion.isOnline,
                    child: CircleAvatar(
                      radius: 25.sp,
                      backgroundColor: Styles.green[200],
                      backgroundImage: discussion.image,
                    ),
                  ),
                  8.widthSp,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          discussion.receiver.displayName,
                          style: Styles.poppins(
                            fontSize: 16.sp,
                            fontWeight: Styles.semiBold,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                        Text(
                          discussion.isOnline
                              ? AppLocalizations.of(context)!.online
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
              );
            },
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
        body: NotificationListener<ScrollNotification>(
          onNotification: widget.discussion.listMessages.onMaxScrollExtent,
          child: Column(
            children: [
              const CustomAppBarBackground(
                type: AppBarBackgroundType.shrink,
              ),
              Consumer<ListMessages>(
                builder: (context, listMessages, _) {
                  if (listMessages.isNull) {
                    return const Expanded(
                      child: CustomLoadingIndicator(
                        isSliver: false,
                      ),
                    );
                  }
                  if (listMessages.isNotEmpty) {
                    return Expanded(
                      child: ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        reverse: true,
                        padding: EdgeInsets.all(16.sp),
                        itemCount: listMessages.length,
                        separatorBuilder: (context, index) => 8.heightSp,
                        itemBuilder: (context, index) => Builder(
                          builder: (context) {
                            Message message = listMessages.elementAt(index);
                            return MessageTile(
                              avatar: message.isMine
                                  ? widget.userSession.image
                                  : widget.discussion.receiver.image,
                              message: message,
                              lastMessage: index > 0
                                  ? listMessages.elementAt(index - 1)
                                  : null,
                            );
                          },
                        ),
                      ),
                    );
                    //FIXME add trailing tile
                  }
                  return const Spacer();
                },
              ),
              ChatSendMessage(
                onSendMessage: onSendMessage,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onSendMessage(
    String? msg,
    String? audioPath,
    List<XFile>? images,
  ) async {
    if (msg.isNullOrEmpty &&
        audioPath.isNullOrEmpty &&
        (images ?? []).isEmpty) {
      return;
    }
    widget.discussion.sendMessage(
      userSession: widget.userSession,
      text: msg ??
          AppLocalizations.of(context)!.sent_nb_messages(
            widget.userSession.displayName,
            images!.length,
          ),
      images: images,
    );
    // if (!msg.isNullOrEmpty) {
    //   widget.discussion.listMessages.inse
    //   ListData.aiChat.insert(
    //     0,
    //     Message2.fromJson(
    //       {
    //         'senderId': 'myid',
    //         'senderAvatarUrl':
    //             'https://i.pinimg.com/1200x/a1/1e/2a/a11e2a9d5803e4dc2c034819ce12a16e.jpg',
    //         'message': msg,
    //         'createdAt': DateTime.now(),
    //         'photoUrl': null,
    //         'aspectRatio': null,
    //         'isSending': true,
    //       },
    //     ),
    //   );
    //   Future.delayed(
    //     const Duration(milliseconds: 500),
    //     () {
    //       ListData.aiChat.where((element) => element.isSending).forEach(
    //         (message) {
    //           message.isSending = false;
    //           setState(() {});
    //         },
    //       );
    //     },
    //   );
    // } else if (!audioPath.isNullOrEmpty) {
    //   ListData.aiChat.insert(
    //     0,
    //     Message2.fromJson(
    //       {
    //         'senderId': 'myid',
    //         'senderAvatarUrl':
    //             'https://i.pinimg.com/1200x/a1/1e/2a/a11e2a9d5803e4dc2c034819ce12a16e.jpg',
    //         'message': null,
    //         'createdAt': DateTime.now(),
    //         'photoUrl': null,
    //         'aspectRatio': null,
    //         'audioUrl': audioPath,
    //         'isSending': true,
    //       },
    //     ),
    //   );
    //   Future.delayed(
    //     const Duration(milliseconds: 500),
    //     () {
    //       ListData.aiChat
    //           .where((element) =>
    //               element.audioUrl != null &&
    //               element.audioUrl!.contains('m4a') &&
    //               element.isSending)
    //           .forEach(
    //         (message) {
    //           File(message.audioUrl!).delete();
    //           message.audioUrl =
    //               'https://firebasestorage.googleapis.com/v0/b/weclickk.appspot.com/o/chatAudios%2FZk9ngZprqVVeHegAVuyENA2mQ963_1695579031.m4a?alt=media&token=3e882c90-f672-4733-80a8-0b6e240874f5';
    //           message.isSending = false;
    //           setState(() {});
    //         },
    //       );
    //     },
    //   );
    // } else if (!imagePath.isNullOrEmpty) {
    //   double? aspectRatio = await getImageAspectRatioFromPath(imagePath!);
    //   ListData.aiChat.insert(
    //     0,
    //     Message2.fromJson(
    //       {
    //         'senderId': 'myid',
    //         'senderAvatarUrl':
    //             'https://i.pinimg.com/1200x/a1/1e/2a/a11e2a9d5803e4dc2c034819ce12a16e.jpg',
    //         'message': null,
    //         'createdAt': DateTime.now(),
    //         'photoUrl': imagePath,
    //         'aspectRatio': aspectRatio,
    //         'audioUrl': null,
    //         'isSending': true,
    //       },
    //     ),
    //   );
    //   Future.delayed(
    //     const Duration(milliseconds: 500),
    //     () {
    //       ListData.aiChat.where((element) => element.isSending).forEach(
    //         (message) {
    //           message.isSending = false;
    //           setState(() {});
    //         },
    //       );
    //     },
    //   );
    // }
    // setState(() {});
  }

  Future<double> getImageAspectRatioFromPath(String imagePath) async {
    File image = File(imagePath);
    var decodedImage = await decodeImageFromList(image.readAsBytesSync());
    Size size =
        Size(decodedImage.width.toDouble(), decodedImage.height.toDouble());
    return size.aspectRatio;
  }
}
