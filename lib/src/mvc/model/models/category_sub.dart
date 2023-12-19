import 'dart:convert';

import '../models.dart';

class CategorySub {
  final String name;
  final String description;
  final String uuid;
  // final String createdAt;
  // final String updatedAt;
  final Category category;

  CategorySub({
    required this.name,
    required this.description,
    required this.uuid,
    // required this.createdAt,
    // required this.updatedAt,
    required this.category,
  });

  factory CategorySub.fromMap(Map<dynamic, dynamic> json) => CategorySub(
        name: json['name'],
        description: json['description'],
        uuid: json['uuid'],
        category: Category.fromMap(json['category']),
      );

  static CategorySub fromResponse(String body) =>
      CategorySub.fromMap(jsonDecode(body));
}
