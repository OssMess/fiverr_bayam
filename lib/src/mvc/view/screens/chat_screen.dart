import 'dart:io';
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

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.userSession,
    required this.discussion,
  });

  final UserSession userSession;
  final Discussion discussion;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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
                    showBadge: widget.discussion.receiver.isOnline,
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
                        Builder(builder: (context) {
                          String? elapsed =
                              discussion.receiver.elapsedOnline(context);
                          return Text(
                            elapsed.isNullOrEmpty ? '' : elapsed!,
                            style: Styles.poppins(
                              fontSize: 12.sp,
                              fontWeight: Styles.regular,
                              color: Colors.white,
                              height: 1.2,
                            ),
                          );
                        }),
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
                      child: NotificationListener(
                        onNotification: listMessages.onMaxScrollExtent,
                        child: ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          reverse: true,
                          padding: EdgeInsets.all(16.sp),
                          itemCount: listMessages.childCount,
                          separatorBuilder: (context, index) => 8.heightSp,
                          itemBuilder: (context, index) => Builder(
                            builder: (context) {
                              if (index < listMessages.length) {
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
                              } else {
                                return CustomTrailingTile(
                                  isNotNull: listMessages.isNotNull,
                                  isLoading: listMessages.isLoading,
                                  hasMore: listMessages.hasMore,
                                  isSliver: false,
                                  quarterTurns: 2,
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    );
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
  }

  Future<double> getImageAspectRatioFromPath(String imagePath) async {
    File image = File(imagePath);
    var decodedImage = await decodeImageFromList(image.readAsBytesSync());
    Size size =
        Size(decodedImage.width.toDouble(), decodedImage.height.toDouble());
    return size.aspectRatio;
  }
}
