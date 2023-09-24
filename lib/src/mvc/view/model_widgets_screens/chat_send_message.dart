import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../extensions.dart';
import '../../../tools.dart';
import '../model_widgets.dart';

class ChatSendMessage extends StatefulWidget {
  const ChatSendMessage({
    super.key,
  });

  @override
  State<ChatSendMessage> createState() => _ChatSendMessageState();
}

class _ChatSendMessageState extends State<ChatSendMessage> {
  final TextEditingController _controller = TextEditingController();
  bool showEmojiPiker = true;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(
            16.sp,
            16.sp,
            16.sp,
            12.sp + (showEmojiPiker ? context.viewPadding.bottom : 0),
          ),
          decoration: BoxDecoration(
            color: context.scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Styles.black.shade500.withOpacity(0.3),
                offset: const Offset(0.0, 2.0),
                blurRadius: 5.0,
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  hideEmojiKeyboard();
                },
                visualDensity: VisualDensity.compact,
                icon: Icon(
                  AwesomeIcons.square_plus,
                  color: context.textTheme.headlineMedium!.color,
                  size: 24.sp,
                ),
              ),
              IconButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  showEmojiKeyboard();
                },
                visualDensity: VisualDensity.compact,
                icon: Icon(
                  AwesomeIcons.face_smile,
                  color: context.textTheme.headlineMedium!.color,
                  size: 24.sp,
                ),
              ),
              IconButton(
                onPressed: () {
                  hideEmojiKeyboard();
                },
                visualDensity: VisualDensity.compact,
                icon: Icon(
                  AwesomeIcons.microphone,
                  color: context.textTheme.headlineMedium!.color,
                  size: 24.sp,
                ),
              ),
              Expanded(
                child: CustomTextFormField(
                  controller: _controller,
                  onTap: () {
                    hideEmojiKeyboard();
                  },
                  hintText: AppLocalizations.of(context)!.type_something,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12.sp,
                    horizontal: 12.sp,
                  ),
                  border: InputBorder.none,
                  onEditingComplete: sendMessageText,
                  textInputAction: TextInputAction.send,
                  unfocusOnTapOutside: false,
                  fontSize: 16.sp,
                ),
              ),
              IconButton(
                onPressed: () {
                  hideEmojiKeyboard();
                },
                icon: Icon(
                  AwesomeIcons.paper_plane_top,
                  color: Styles.green,
                  size: 24.sp,
                ),
              ),
            ],
          ),
        ),
        Offstage(
          offstage: showEmojiPiker,
          child: SizedBox(
            height: 0.35.sh,
            child: EmojiPicker(
              textEditingController: _controller,
              onBackspacePressed: null,
              config: Config(
                columns: 7,
                emojiSizeMax: 28.sp * (Platform.isIOS ? 1.30 : 1.0),
                verticalSpacing: 0,
                horizontalSpacing: 0,
                gridPadding: EdgeInsets.only(
                  bottom: context.viewPadding.bottom,
                ),
                initCategory: Category.SMILEYS,
                bgColor: context.textTheme.headlineSmall!.color!,
                indicatorColor: Styles.blue,
                iconColor: context.textTheme.headlineLarge!.color!,
                iconColorSelected: Colors.blue,
                backspaceColor: Styles.blue,
                skinToneDialogBgColor: Colors.white,
                skinToneIndicatorColor: Colors.grey,
                enableSkinTones: true,
                recentTabBehavior: RecentTabBehavior.RECENT,
                recentsLimit: 28,
                replaceEmojiOnLimitExceed: false,
                noRecents: Text(
                  AppLocalizations.of(context)!.no_recents,
                  style: const TextStyle(fontSize: 20, color: Colors.black26),
                  textAlign: TextAlign.center,
                ),
                loadingIndicator: SpinKitRing(
                  color: Styles.green,
                  size: 20.sp,
                  lineWidth: 2.3.sp,
                ),
                tabIndicatorAnimDuration: kTabScrollDuration,
                categoryIcons: const CategoryIcons(),
                buttonMode: ButtonMode.MATERIAL,
                checkPlatformCompatibility: true,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> sendMessageText() async {
    if (_controller.text.isEmpty) return;
    _controller.text = '';
  }

  void hideEmojiKeyboard() {
    if (showEmojiPiker) return;
    setState(() {
      showEmojiPiker = true;
    });
  }

  void showEmojiKeyboard() {
    if (!showEmojiPiker) return;
    setState(() {
      showEmojiPiker = false;
    });
  }
}
