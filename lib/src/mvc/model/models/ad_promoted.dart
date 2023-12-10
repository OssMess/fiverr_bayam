import 'dart:convert';

import 'package:flutter/material.dart';

AdPromoted jsonToAdPromoted(Map<dynamic, dynamic> json) =>
    AdPromoted.fromMap(json);

class AdPromoted with ChangeNotifier {
  final String id;
  final String content;
  final String startDate;
  final String endDate;
  final num budget;
  final bool isValid;
  final DateTime createdAt;
  final DateTime updatedAt;

  AdPromoted({
    required this.id,
    required this.content,
    required this.startDate,
    required this.endDate,
    required this.budget,
    required this.isValid,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AdPromoted.fromMap(Map<dynamic, dynamic> json) => AdPromoted(
        id: json['uuid'],
        content: json['content'],
        startDate: json['startDate'],
        endDate: json['endDate'],
        budget: json['budget'],
        isValid: json['isValid'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
      );

  static AdPromoted fromResponse(String response) =>
      AdPromoted.fromMap(jsonDecode(response));
}
