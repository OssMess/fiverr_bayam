import '../../../extensions.dart';
import '../enums.dart';

class AppNotification {
  final List<String> leadingPhotoUrls;
  final String trailingPhotourl;
  final String displayName;
  final AppNotificationType type;
  final bool hasBorderRadius;
  final DateTime createdAt;

  AppNotification({
    required this.leadingPhotoUrls,
    required this.trailingPhotourl,
    required this.displayName,
    required this.type,
    required this.hasBorderRadius,
    required this.createdAt,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) =>
      AppNotification(
        leadingPhotoUrls: json['leadingPhotoUrls'],
        trailingPhotourl: json['trailingPhotourl'],
        displayName: json['displayName'],
        type: (json['type'] as String).toAppNotificationType,
        hasBorderRadius: json['hasBorderRadius'],
        createdAt: json['createdAt'],
      );
}
