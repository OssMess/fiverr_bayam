import 'package:bayam/src/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../tools.dart';
import '../../controller/hives.dart';

Message jsonToMessage(
        Map<dynamic, dynamic> json, String discussionId, String uid) =>
    Message.fromJson(json, discussionId, uid);

class Message with ChangeNotifier {
  String id;
  final String discussionId;
  final bool isMine;
  final String message;
  Iterable<ImageProvider<Object>> images;
  Iterable<String> imagesUrl;
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

  factory Message.init({
    required String discussionId,
    required String? message,
    required List<XFile>? images,
  }) =>
      Message(
        id: '',
        discussionId: discussionId,
        isMine: true,
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

  factory Message.fromJson(
    Map<dynamic, dynamic> json,
    String? discussionId,
    String uid,
  ) =>
      Message(
        id: json['uuid'],
        discussionId: discussionId ?? json['discussionId'],
        isMine: json['isMine'] ?? json['sender']['uuid'] == uid,
        message: json['message'],
        images: List.from(json['images'] ?? [])
            .map((e) => CachedNetworkImageProvider(e)),
        imagesUrl: List.from(json['images'] ?? []),
        imageFiles: [],
        isEncrypted: json['isEncrypted'],
        createdAt: DateTimeUtils.parseDateTime(json['createdAt'])!,
        updatedAt: DateTimeUtils.parseDateTime(json['updatedAt'])!,
        isSending: false,
        isError: false,
      );

  Map<String, dynamic> get toMap => {
        'uuid': id,
        'discussionId': discussionId,
        'isMine': isMine,
        'message': message,
        'images': imagesUrl,
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
    images = message.images;
    imagesUrl = message.imagesUrl;
    imageFiles.clear();
    isSending = false;
    isError = false;
    notifyListeners();
    HiveMessages.save(message);
  }
}
