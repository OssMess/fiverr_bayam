import 'dart:convert';

import 'package:bayam/src/extensions.dart';

import '../enums.dart';

Plan jsonToPlan(Map<String, dynamic> json) => Plan.fromMap(json);

class Plan {
  final String uuid;
  final PlanDuration duration;
  final PlanType type;
  final PlanPlace place;
  final int budget;
  final String description;

  Plan({
    required this.uuid,
    required this.duration,
    required this.type,
    required this.place,
    required this.budget,
    required this.description,
  });

  factory Plan.fromMap(Map<dynamic, dynamic> json) => Plan(
        uuid: json['uuid'],
        duration: (json['duration'] as String).toPlanDuration,
        type: (json['plan_type'] as String).toPlanType,
        place: (json['place'] as String).toPlanPlace,
        budget: int.parse(json['budget']),
        description: json['description'],
      );

  static Plan fromResponse(String body) => Plan.fromMap(jsonDecode(body));

  String get price => '$budget\$';

  int get months => duration.months;
}
