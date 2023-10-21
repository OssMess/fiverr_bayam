import '../../../tools.dart';

Discussion jsonToDiscussion(Map<dynamic, dynamic> json) =>
    Discussion.fromJson(json);

class Discussion {
  final String id;
  final String receinverId;
  final String senderId;
  final String messages;
  final DateTime createdAt;
  final DateTime updatedAt;

  Discussion({
    required this.id,
    required this.receinverId,
    required this.senderId,
    required this.messages,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Discussion.fromJson(Map<dynamic, dynamic> json) => Discussion(
        id: json['uuid'],
        receinverId: json['receinver'],
        senderId: json['sender'],
        messages: json['messages'],
        createdAt: DateTimeUtils.getDateTimefromTimestamp(json['createdAt'])!,
        updatedAt: DateTimeUtils.getDateTimefromTimestamp(json['updatedAt'])!,
      );
}
