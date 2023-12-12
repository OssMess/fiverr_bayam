import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../tools.dart';

Message jsonToMessage(Map<dynamic, dynamic> json) => Message.fromJson(json);

class Message {
  final String id;
  final String discussionId;
  final String receiverId;
  final String senderId;
  final String message;
  final Iterable<ImageProvider<Object>> images;
  final String isEncrypted;
  final DateTime createdAt;
  final DateTime updatedAt;

  Message({
    required this.id,
    required this.discussionId,
    required this.receiverId,
    required this.senderId,
    required this.message,
    required this.images,
    required this.isEncrypted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Message.fromJson(Map<dynamic, dynamic> json) => Message(
        id: json['uuid'],
        discussionId: json['discussion'],
        receiverId: json['receiver'],
        senderId: json['sender'],
        message: json['message'],
        images: List.from(json['message'] ?? [])
            .map((e) => CachedNetworkImageProvider(e)),
        isEncrypted: json['isEncrypted'],
        createdAt: DateTimeUtils.parseDateTime(json['createdAt'])!,
        updatedAt: DateTimeUtils.parseDateTime(json['updatedAt'])!,
      );
}
