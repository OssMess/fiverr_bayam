import 'dart:convert';

import 'package:bayam/src/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../tools.dart';
import '../../controller/hives.dart';
import '../../controller/services.dart';
import '../models.dart';

Message jsonToMessage(
  Map<dynamic, dynamic> json,
  String discussionId,
  String uid,
) =>
    Message.fromMap(json, discussionId, uid);

class Message with ChangeNotifier {
  String id;
  final String discussionId;
  final bool isMine;
  bool isSeen;
  String message;
  final List<ImageProvider<Object>> images;
  final List<String> imagesUrl;
  final List<XFile> imageFiles;
  final String? isEncrypted;
  final DateTime createdAt;
  final DateTime updatedAt;
  bool isSending;
  bool isError;

  Message({
    required this.id,
    required this.discussionId,
    required this.isMine,
    required this.isSeen,
    required this.message,
    required this.images,
    required this.imagesUrl,
    required this.imageFiles,
    required this.isEncrypted,
    required this.createdAt,
    required this.updatedAt,
    required this.isSending,
    required this.isError,
  });

  factory Message.initChatBotMessage(bool isMine, String message) => Message(
        id: 'chatbot_${DateTime.now().millisecondsSinceEpoch}',
        discussionId: 'chatbot',
        isMine: isMine,
        isSeen: true,
        message: message,
        images: [],
        imagesUrl: [],
        imageFiles: [],
        isEncrypted: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isSending: false,
        isError: false,
      );

  factory Message.initChatBotAwaitingMessage() => Message(
        id: 'chatbot_${DateTime.now().millisecondsSinceEpoch}',
        discussionId: 'chatbot',
        isMine: false,
        isSeen: true,
        message: '',
        images: [],
        imagesUrl: [],
        imageFiles: [],
        isEncrypted: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isSending: true,
        isError: false,
      );

  factory Message.init({
    required String discussionId,
    required String? message,
    required List<XFile>? images,
  }) =>
      Message(
        id: '',
        discussionId: discussionId,
        isMine: true,
        isSeen: true,
        message: message ?? '',
        images: (images ?? []).map((e) => Image.file(e.toFile).image).toList(),
        imagesUrl: [],
        imageFiles: images ?? [],
        isEncrypted: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isSending: true,
        isError: false,
      );

  factory Message.fromMap(
    Map<dynamic, dynamic> json,
    String? discussionId,
    String uid,
  ) =>
      Message(
        id: json['uuid'],
        discussionId: discussionId ?? json['discussionId'],
        isMine: json['isMine'] ?? json['sender']['uuid'] == uid,
        isSeen: json['is_seen'] ?? true,
        message: json['message'],
        images: List.from(json['images'] ?? [])
            .map((e) => CachedNetworkImageProvider(e))
            .toList(),
        imagesUrl: List.from(json['images'] ?? []),
        imageFiles: [],
        isEncrypted: json['isEncrypted'],
        createdAt: DateTimeUtils.parseDateTime(json['createdAt'])!,
        updatedAt: DateTimeUtils.parseDateTime(json['updatedAt'])!,
        isSending: false,
        isError: json['isError'] ?? false,
      );

  Map<String, dynamic> get toMap => {
        'uuid': id,
        'discussionId': discussionId,
        'isMine': isMine,
        'message': message,
        'images': imagesUrl,
        'isError': isError,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };

  bool get isText => images.isEmpty;

  bool get isImage => images.isNotEmpty;

  // void updateSent() {
  //   isSending = false;
  //   notifyListeners();
  // }

  void updateError() {
    isError = true;
    isSending = false;
    notifyListeners();
  }

  void updateWithMessage(Message message) {
    id = message.id;
    images.clear();
    images.addAll(message.images);
    imagesUrl.clear();
    imagesUrl.addAll(message.imagesUrl);
    imageFiles.clear();
    isSending = false;
    isError = false;
    notifyListeners();
    HiveMessages.save(message);
  }

  void updateWithChatBotMessage(Message message) {
    this.message = message.message;
    isSending = false;
    notifyListeners();
    HiveMessages.save(message);
  }

  static Message fromResponse(
    String response,
    String? discussionId,
    String uid,
  ) =>
      Message.fromMap(jsonDecode(response), discussionId, uid);

  Future<void> markAsSeen(UserSession userSession) async {
    if (await MessageServices.of(userSession).markAsSeen(this)) {
      isSeen = true;
      notifyListeners();
    }
  }

  Map<String, String> get toChatGPTMap => {
        'role': isMine ? 'user' : 'assistant',
        'content': message,
      };
}
