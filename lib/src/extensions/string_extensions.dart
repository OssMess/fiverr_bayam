import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../mvc/model/enums.dart';

extension StringExtension on String {
  /// capitalize first letter
  String get capitalizeFirstLetter {
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  AccountType get toAccountType => {
        'company': AccountType.company,
        'person': AccountType.person,
      }[this]!;

  AdType get toAdType => {
        'rent': AdType.rent,
        'sell': AdType.sell,
        'want': AdType.want,
      }[this]!;

  AccountPreference get toAccountPreference => {
        'paddyrice': AccountPreference.paddyrice,
        'hulledrice': AccountPreference.hulledrice,
        'freshcassava': AccountPreference.freshcassava,
        'driedcassava': AccountPreference.driedcassava,
        'sweetpotatoes': AccountPreference.sweetpotatoes,
        'potatoes': AccountPreference.potatoes,
        'bananas': AccountPreference.bananas,
        'blantains': AccountPreference.blantains,
      }[this]!;

  PlanDuration get toPlanDuration => {
        'monthly': PlanDuration.monthly,
        'biannual': PlanDuration.biannual,
        'annual': PlanDuration.annual,
      }[this]!;

  AdCategory get toCategory => {
        'agriculture': AdCategory.agriculture,
        'livestock': AdCategory.livestock,
        'fishing': AdCategory.fishing,
        'phytosnitary': AdCategory.phytosnitary,
        'localFoodProducts': AdCategory.localFoodProducts,
        'rentalStorageFacilities': AdCategory.rentalStorageFacilities,
      }[this]!;

  PlanType get toPlanType => {
        'by_city': PlanType.byCity,
        'by_country': PlanType.byCountry,
      }[this]!;
  PlanName get toPlanName => {
        'basic': PlanName.basic,
        'advanced': PlanName.advanced,
        'unlimited': PlanName.unlimited,
      }[this]!;

  AppNotificationType get toAppNotificationType => {
        'notification_created_ad': AppNotificationType.createdAd,
        'notification_liked_ad': AppNotificationType.likedAd,
        'notification_liked_ad_many': AppNotificationType.likedAdMany,
        'notification_liked_profile': AppNotificationType.likedProfile,
        'notification_liked_profile_many': AppNotificationType.likedProfileMany,
        'notification_saved_ad': AppNotificationType.savedAd,
        'notification_saved_ad_many': AppNotificationType.savedAdMany,
      }[this]!;

  Image get toImageFromBase64String =>
      Image.memory(const Base64Decoder().convert(this));
}

extension StringNullableExtension on String? {
  /// return `true` if `String` is null
  bool get isNull => this == null;

  /// return `true` if `String` is not null
  bool get isNotNull => this != null;

  /// return `true` if `String` is null or empty, after trimming String
  bool get isNullOrEmpty => (this ?? '').trim().isEmpty;

  /// return `true` if `String` is not null or empty, after trimming String
  bool get isNotNullOrEmpty => (this ?? '').trim().isNotEmpty;

  Image? get toImageFromBase64String =>
      this == null ? null : Image.memory(const Base64Decoder().convert(this!));

  ImageProvider<Object>? get toImageProvider =>
      isNullOrEmpty ? null : CachedNetworkImageProvider(this!);
}
