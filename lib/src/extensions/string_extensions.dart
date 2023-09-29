import 'package:flutter/material.dart';

import '../mvc/model/enums.dart';
import '../tools.dart';

extension StringExtension on String {
  /// capitalize first letter
  String get capitalizeFirstLetter {
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Convert `String` to minutes (`int`)
  int get timeToMinutes {
    List<int> values = split(':').map((e) => int.parse(e)).toList();
    values.first = values.first * 60;
    return values.reduce((value, element) => value + element);
  }

  /// Convert String to `Color` for `AppointementState`.
  Color get appointmentStateToColor {
    Map<String, Color> colors = {
      'pending': Styles.yellow,
      'accepted': Styles.green,
      'canceled': Styles.red,
      'declined': Styles.red,
      'completed': Styles.green,
    };
    return colors[this]!;
  }

  /// Convert String to shaded `Color` for `AppointementState`.
  Color get appointmentStateToColorShaded {
    Map<String, Color> colors = {
      'pending': Styles.yellow.shade50,
      'accepted': Styles.green.shade50,
      'canceled': Styles.red.shade50,
      'declined': Styles.red.shade50,
      'completed': Styles.green.shade50,
    };
    return colors[this]!;
  }

  AccountType get toAccountType => {
        'company': AccountType.company,
        'person': AccountType.person,
      }[this]!;

  AdType get toAdType => {
        'for_rent': AdType.forRent,
        'for_sale': AdType.forSell,
        'want_to_buy': AdType.wantToBuy,
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
}

extension StringNullableExtension on String? {
  /// return `true` if `String` is null
  bool get isNull => this == null;

  /// return `true` if `String` is not null
  bool get isNotNull => this != null;

  /// return `true` if `String` is null or empty, after trimming String
  bool get isNullOrEmpty => (this ?? '').trim().isEmpty;
}
