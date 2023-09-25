import 'dart:io';
import 'dart:math';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';

import 'package:dotted_line/dotted_line.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';

import '../../../extensions.dart';
import '../../../tools.dart';
import '../../model/change_notifiers.dart';
import '../../model/models_ui.dart';
import '../model_widgets.dart';

class ChatSendMessage extends StatefulWidget {
  const ChatSendMessage({
    super.key,
    required this.onSendMessage,
  });

  final Future<void> Function(String?, String?, String?) onSendMessage;

  @override
  State<ChatSendMessage> createState() => _ChatSendMessageState();
}

class _ChatSendMessageState extends State<ChatSendMessage> {
  final TextEditingController _controller = TextEditingController();
  final record = Record();
  NotifierBool isRecording = NotifierBool.init(false);
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
          child: ValueListenableBuilder(
              valueListenable: isRecording.notifier,
              builder: (context, isRecording, _) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (isRecording) ...[
                      IconButton(
                        onPressed: () {
                          hideEmojiKeyboard();
                          stopRecording(save: false);
                        },
                        visualDensity: VisualDensity.compact,
                        icon: Icon(
                          AwesomeIcons.trash_outlined,
                          color: context.textTheme.headlineMedium!.color,
                          size: 24.sp,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 50.sp,
                          decoration: BoxDecoration(
                            color: context.textTheme.headlineSmall!.color,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(11.sp),
                                margin: EdgeInsets.all(4.sp),
                                width: 40.sp,
                                height: 40.sp,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.transparent,
                                  ),
                                  child: Icon(
                                    AwesomeIcons.microphone,
                                    color: Styles.green,
                                    size: 20.sp,
                                  ),
                                ),
                              ),
                              // const Expanded(child: DotterProgressIndicator()),
                              const Expanded(
                                child: RecorderIndicatorStreamBuilder(
                                  maxDuration: Duration(seconds: 10),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                    if (!isRecording) ...[
                      IconButton(
                        onPressed: sendImage,
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
                          startRecording();
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
                          fontSize: 16.sp,
                          height: 50.sp,
                          onTap: hideEmojiKeyboard,
                          hintText:
                              AppLocalizations.of(context)!.type_something,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 12.sp,
                            horizontal: 12.sp,
                          ),
                          border: InputBorder.none,
                          onEditingComplete: sendText,
                          textInputAction: TextInputAction.send,
                          unfocusOnTapOutside: false,
                        ),
                      ),
                    ],
                    IconButton(
                      onPressed: sendMessage,
                      icon: Icon(
                        AwesomeIcons.paper_plane_top,
                        color: Styles.green,
                        size: 24.sp,
                      ),
                    ),
                  ],
                );
              }),
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

  Future<void> startRecording() async {
    await Permissions.of(context)
        .showMicrophonePermission()
        .then((value) async {
      if (value) {
        return;
      }
      await record.start(
        path: '${(await getTemporaryDirectory()).path}/audio_1.m4a',
        encoder: AudioEncoder.aacLc,
        bitRate: 128000,
      );
      isRecording.setValue(true);
    });
  }

  Future<String?> stopRecording({required bool save}) async {
    bool recording = await record.isRecording();
    String? filePath;
    if (recording) {
      filePath = await record.stop();
    }
    isRecording.setValue(false);
    if (save && filePath != null && filePath.isNotEmpty) {
      return filePath;
    } else {
      return null;
    }
  }

  Future<void> sendRecording() async {
    String? filePath = await stopRecording(save: true);
    if (filePath != null) {
      widget.onSendMessage(
        null,
        filePath,
        null,
      );
    }
  }

  Future<void> sendText() async {
    if (_controller.text.isEmpty) return;
    hideEmojiKeyboard();
    widget.onSendMessage(
      _controller.text,
      null,
      null,
    );
    _controller.text = '';
  }

  Future<void> sendImage() async {
    hideEmojiKeyboard();
    ImagePicker()
        .pickImage(
      source: ImageSource.gallery,
      maxHeight: 1080,
      maxWidth: 1080,
      imageQuality: 80,
    )
        .then(
      (xfile) {
        if (xfile == null) return;
        widget.onSendMessage(
          null,
          null,
          xfile.path,
        );
      },
    );
  }

  Future<void> sendMessage() async {
    if (isRecording.value) {
      sendRecording();
    } else if (_controller.text.isNotEmpty) {
      hideEmojiKeyboard();
      widget.onSendMessage(
        _controller.text,
        null,
        null,
      );
      _controller.text = '';
    }
  }
}

class RecorderIndicatorStreamBuilder extends StatefulWidget {
  const RecorderIndicatorStreamBuilder({
    Key? key,
    required this.maxDuration,
  }) : super(key: key);

  final Duration maxDuration;

  @override
  State<RecorderIndicatorStreamBuilder> createState() =>
      _RecorderIndicatorStreamBuilderState();
}

class _RecorderIndicatorStreamBuilderState
    extends State<RecorderIndicatorStreamBuilder> {
  late TimerLoop timer;

  @override
  void initState() {
    super.initState();
    timer = TimerLoop();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: timer,
      child: Consumer<TimerLoop>(builder: (context, timer, _) {
        timer.run();
        Duration duration = timer.duration;
        double value = (1.sw - 215.sp) *
            (duration >= widget.maxDuration
                ? 1
                : min(
                    1,
                    min(duration.inSeconds, widget.maxDuration.inSeconds) /
                        widget.maxDuration.inSeconds,
                  ));
        return Row(
          children: [
            SizedBox(
              width: value,
              child: DottedLine(
                direction: Axis.horizontal,
                lineLength: double.infinity,
                lineThickness: 8.sp,
                dashLength: 4.sp,
                dashColor: Styles.green,
                dashRadius: 5.sp,
                dashGapLength: 4.sp,
                dashGapColor: Colors.transparent,
                dashGapRadius: 0.0,
              ),
            ),
            const Spacer(),
            Container(
              width: 45.sp,
              alignment: Alignment.center,
              child: Text(
                '${duration.inMinutes}:${NumberFormat('00').format(duration.inSeconds - (duration.inMinutes * 60))}',
                style: Styles.poppins(
                  fontSize: 17.sp,
                  color: context.textTheme.displayLarge!.color,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
