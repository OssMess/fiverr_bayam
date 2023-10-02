import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../mvc/model/enums.dart';

extension NotificationTypeExtensions on NotificationType {
  String translate(BuildContext context) => {
        // NotificationType.createdAd:
        //     AppLocalizations.of(context)!.notification_created_ad,
        // NotificationType.likedAd:
        //     AppLocalizations.of(context)!.notification_liked_ad,
        // NotificationType.likedAdMany:
        //     AppLocalizations.of(context)!.notification_liked_ad_many,
        // NotificationType.likedProfile:
        //     AppLocalizations.of(context)!.notification_liked_profile,
        // NotificationType.likedProfileMany:
        //     AppLocalizations.of(context)!.notification_liked_profile_many,
        // NotificationType.savedAd:
        //     AppLocalizations.of(context)!.notification_saved_ad,
        // NotificationType.savedAdMany:
        //     AppLocalizations.of(context)!.notification_saved_ad_many,
      }[this]!;

  String get key => {
        NotificationType.createdAd: 'notification_created_ad',
        NotificationType.likedAd: 'notification_liked_ad',
        NotificationType.likedAdMany: 'notification_liked_ad_many',
        NotificationType.likedProfile: 'notification_liked_profile',
        NotificationType.likedProfileMany: 'notification_liked_profile_many',
        NotificationType.savedAd: 'notification_saved_ad',
        NotificationType.savedAdMany: 'notification_saved_ad_many',
      }[this]!;
}
