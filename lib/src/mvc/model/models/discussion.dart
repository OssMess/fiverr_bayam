import 'package:flutter/material.dart';

import '../../../tools.dart';
import '../list_models.dart';
import '../models.dart';

Discussion jsonToDiscussion(
        Map<dynamic, dynamic> json, UserSession userSession) =>
    Discussion.fromJson(json, userSession);

class Discussion {
  final String id;
  final UserMin receiver;
  final UserMin sender;
  final List<Message> messages;
  final String? encryptionKey;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ListMessages listMessages;

  Discussion({
    required this.id,
    required this.receiver,
    required this.sender,
    required this.messages,
    required this.encryptionKey,
    required this.createdAt,
    required this.updatedAt,
    required this.listMessages,
  });

  factory Discussion.fromJson(
    Map<dynamic, dynamic> json,
    UserSession userSession,
  ) =>
      Discussion(
        id: json['uuid'],
        receiver: UserMin.fromMap(json['receiver']),
        sender: UserMin.fromMap(json['sender']),
        messages: List.from(json['messages'])
            .map((e) => Message.fromJson(e))
            .toList(),
        encryptionKey: json['encryption_key'],
        createdAt: DateTimeUtils.parseDateTime(json['createdAt'])!,
        updatedAt: DateTimeUtils.parseDateTime(json['updatedAt'])!,
        listMessages: ListMessages(
          userSession: userSession,
          discussionId: json['uuid'],
          lastDate: DateTime.now(),
        ),
      );

  String get displayName => receiver.displayName;

  bool get isOnline => false;

  bool get isSeen => true;

  ImageProvider<Object>? get image => receiver.image;

  String? get imageUrl => receiver.imageUrl;

  String get lastMessage => messages.isEmpty ? '' : messages.first.message;
}
