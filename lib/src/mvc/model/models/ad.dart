import 'package:flutter/material.dart';

import '../enums.dart';

class Ad with ChangeNotifier {
  final String name;
  final String logoUrl;
  final String coverUrl;
  final String field;
  final bool isVerified;
  final AdType adType;

  Ad({
    required this.name,
    required this.logoUrl,
    required this.coverUrl,
    required this.field,
    required this.isVerified,
    required this.adType,
  });

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
        name: json['name'],
        logoUrl: json['logoUrl'],
        coverUrl: json['coverUrl'],
        field: json['field'],
        isVerified: json['isVerified'],
        adType: json['adType'],
      );
}
