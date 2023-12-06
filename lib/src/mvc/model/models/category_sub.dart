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

  factory CategorySub.fromJson(Map<String, dynamic> json) => CategorySub(
        name: json['name'],
        description: json['description'],
        uuid: json['uuid'],
        // createdAt: json['created_at'],
        // updatedAt: json['updated_at'],
        category: Category.fromJson(json['category']),
      );
}
