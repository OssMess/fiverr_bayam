import '../../../tools.dart';
import '../list_models.dart';

Discussion jsonToDiscussion(Map<dynamic, dynamic> json) =>
    Discussion.fromJson(json);

class Discussion {
  final String id;
  final String receiverId;
  final String senderId;
  final String messages;
  final String encryptionKey;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ListMessages listMessages;

  Discussion({
    required this.id,
    required this.receiverId,
    required this.senderId,
    required this.messages,
    required this.encryptionKey,
    required this.createdAt,
    required this.updatedAt,
    required this.listMessages,
  });

  factory Discussion.fromJson(Map<dynamic, dynamic> json) => Discussion(
        id: json['uuid'],
        receiverId: json['receiver'],
        senderId: json['sender'],
        messages: json['messages'],
        encryptionKey: json['encryption_key'],
        createdAt: DateTimeUtils.getDateTimefromTimestamp(json['createdAt'])!,
        updatedAt: DateTimeUtils.getDateTimefromTimestamp(json['updatedAt'])!,
        listMessages: ListMessages(discussionId: json['uuid']),
      );
}
