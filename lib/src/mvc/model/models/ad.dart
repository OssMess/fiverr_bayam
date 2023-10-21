import 'package:flutter/material.dart';

import '../../../extensions.dart';
import '../enums.dart';

class Ad with ChangeNotifier {
  final String id;
  final String name;
  final String title;
  final String description;
  final String location;
  final Category category;
  final String userPhotoUrl;
  final String logoUrl;
  final String coverUrl;
  final bool isVerified;
  final AdType adType;
  final List<String> tags;

  Ad({
    this.id = '',
    required this.name,
    required this.title,
    required this.description,
    required this.location,
    required this.category,
    required this.userPhotoUrl,
    required this.logoUrl,
    required this.coverUrl,
    required this.isVerified,
    required this.adType,
    required this.tags,
  });

  factory Ad.fromJson(Map<dynamic, dynamic> json) => Ad(
        name: json['name'],
        title: json['title'],
        description: json['description'],
        location: json['location'],
        category: (json['category'] as String).toCategory,
        userPhotoUrl: json['userPhotoUrl'],
        logoUrl: json['logoUrl'],
        coverUrl: json['coverUrl'],
        isVerified: json['isVerified'],
        adType: json['adType'],
        tags: json['tags'],
      );
}
