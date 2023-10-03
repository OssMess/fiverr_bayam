import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../mvc/model/enums.dart';

extension AppNotificationTypeExtensions on AppNotificationType {
  String translate(BuildContext context) => {
        AppNotificationType.createdAd:
            AppLocalizations.of(context)!.notification_created_ad,
        AppNotificationType.likedAd:
            AppLocalizations.of(context)!.notification_liked_ad,
        AppNotificationType.likedAdMany:
            AppLocalizations.of(context)!.notification_liked_ad_many,
        AppNotificationType.likedProfile:
            AppLocalizations.of(context)!.notification_liked_profile,
        AppNotificationType.likedProfileMany:
            AppLocalizations.of(context)!.notification_liked_profile_many,
        AppNotificationType.savedAd:
            AppLocalizations.of(context)!.notification_saved_ad,
        AppNotificationType.savedAdMany:
            AppLocalizations.of(context)!.notification_saved_ad_many,
      }[this]!;

  String get key => {
        AppNotificationType.createdAd: 'notification_created_ad',
        AppNotificationType.likedAd: 'notification_liked_ad',
        AppNotificationType.likedAdMany: 'notification_liked_ad_many',
        AppNotificationType.likedProfile: 'notification_liked_profile',
        AppNotificationType.likedProfileMany: 'notification_liked_profile_many',
        AppNotificationType.savedAd: 'notification_saved_ad',
        AppNotificationType.savedAdMany: 'notification_saved_ad_many',
      }[this]!;
}
