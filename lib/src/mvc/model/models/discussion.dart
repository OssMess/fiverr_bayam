import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../tools.dart';
import '../../controller/services.dart';
import '../list_models.dart';
import '../models.dart';

Discussion jsonToDiscussion(
  Map<dynamic, dynamic> json,
  UserSession userSession,
) =>
    Discussion.fromMap(json, userSession);

class Discussion with ChangeNotifier {
  final String id;
  final UserMin receiver;
  final List<Message> messages;
  final String? encryptionKey;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ListMessages listMessages;

  Discussion({
    required this.id,
    required this.receiver,
    required this.messages,
    required this.encryptionKey,
    required this.createdAt,
    required this.updatedAt,
    required this.listMessages,
  });

  factory Discussion.fromMap(
    Map<dynamic, dynamic> json,
    UserSession userSession,
  ) =>
      Discussion(
        id: json['uuid'],
        receiver: json['receiver']['uuid'] != userSession.uid
            ? UserMin.fromMap(
                json['receiver'],
                userSession,
              )
            : UserMin.fromMap(
                json['sender'],
                userSession,
              ),
        messages: List.from(json['messages'])
            .map(
              (e) => Message.fromMap(
                e,
                json['uuid'],
                userSession.uid!,
              ),
            )
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

  bool get isSeen => true;

  ImageProvider<Object>? get image => receiver.imageProfile;

  String? get imageUrl => receiver.imageProfileUrl;

  String get lastMessage => messages.isEmpty ? '' : messages.first.message;

  Future<void> sendMessage({
    required UserSession userSession,
    required String? text,
    required List<XFile>? images,
  }) async {
    Message message = Message.init(
      discussionId: id,
      message: text,
      images: images,
    );
    listMessages.insert(message);
    try {
      Message messageSent = await MessageServices.of(userSession).post(
        receiverId: receiver.uid,
        discussionId: id,
        message: message.message,
        images: message.imageFiles,
      );
      message.updateWithMessage(messageSent);
    } catch (e) {
      message.updateError();
    }
  }

  static Discussion fromResponse(String body, UserSession userSession) =>
      Discussion.fromMap(
        jsonDecode(body),
        userSession,
      );
}
