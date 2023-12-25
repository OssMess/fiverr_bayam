import 'dart:convert';

import 'package:bayam/src/extensions.dart';
import 'package:flutter/material.dart';

import '../models.dart';

AdPromoted jsonToAdPromoted(
  Map<dynamic, dynamic> json,
  UserSession userSession,
) =>
    AdPromoted.fromMap(json, userSession);

class AdPromoted with ChangeNotifier {
  final String uuid;
  final Ad ad;
  final DateTime startDate;
  final DateTime endDate;
  final bool isValid;
  final City? city;
  final Country? country;
  final DateTime createdAt;
  final DateTime updatedAt;

  AdPromoted({
    required this.uuid,
    required this.ad,
    required this.startDate,
    required this.endDate,
    required this.isValid,
    required this.city,
    required this.country,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AdPromoted.fromMap(
    Map<dynamic, dynamic> json,
    UserSession userSession,
  ) =>
      AdPromoted(
        uuid: json['uuid'],
        ad: (json['post'] as Map<dynamic, dynamic>).toAdPost(userSession),
        startDate: DateTime.parse(json['startDate']),
        endDate: DateTime.parse(json['endDate']),
        isValid: json['isValid'],
        city: List.from(json['localization']).first['@type'] == 'Cities'
            ? City.fromMap(List.from(json['localization']).first)
            : null,
        country: List.from(json['localization']).first['@type'] != 'Cities'
            ? Country.fromMap(List.from(json['localization']).first)
            : null,
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
      );

  static AdPromoted fromResponse(
    String body,
    UserSession userSession,
  ) =>
      AdPromoted.fromMap(jsonDecode(body), userSession);
}
