import 'package:flutter/material.dart';

class Company with ChangeNotifier {
  final String name;
  final String logoUrl;
  final String coverUrl;
  final String field;
  final bool isVerified;

  Company({
    required this.name,
    required this.logoUrl,
    required this.coverUrl,
    required this.field,
    required this.isVerified,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        name: json['name'],
        logoUrl: json['logoUrl'],
        coverUrl: json['coverUrl'],
        field: json['field'],
        isVerified: json['isVerified'],
      );
}
