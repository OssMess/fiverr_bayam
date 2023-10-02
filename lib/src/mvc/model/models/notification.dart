import '../enums.dart';

class Notification {
  final List<String> leadingPhotoUrls;
  final String trailingPhotourl;
  final String displayName;
  final NotificationType type;
  final bool hasBorderRadius;
  final DateTime createdAt;

  Notification({
    required this.leadingPhotoUrls,
    required this.trailingPhotourl,
    required this.displayName,
    required this.type,
    required this.hasBorderRadius,
    required this.createdAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        leadingPhotoUrls: json['leadingPhotoUrls'],
        trailingPhotourl: json['trailingPhotourl'],
        displayName: json['displayName'],
        type: json['type'],
        hasBorderRadius: json['hasBorderRadius'],
        createdAt: json['createdAt'],
      );
}
