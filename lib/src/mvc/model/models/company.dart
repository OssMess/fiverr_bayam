//FIXME change to author
import 'package:bayam/src/extensions.dart';
import 'package:flutter/material.dart';

import '../enums.dart';

class Company with ChangeNotifier {
  final String name;
  final String logoUrl;
  final String coverUrl;
  final AdCategory category;
  final bool isVerified;

  Company({
    required this.name,
    required this.logoUrl,
    required this.coverUrl,
    required this.category,
    required this.isVerified,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        name: json['name'],
        logoUrl: json['logoUrl'],
        coverUrl: json['coverUrl'],
        category: (json['category'] as String).toCategory,
        isVerified: json['isVerified'],
      );
}
