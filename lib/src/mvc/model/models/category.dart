class Category {
  final String name;
  final String description;
  final String uuid;
  // final String createdAt;
  // final String updatedAt;
  // final String subCategories;

  Category({
    required this.name,
    required this.description,
    required this.uuid,
    // required this.createdAt,
    // required this.updatedAt,
    // required this.subCategories,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json['name'],
        description: json['description'],
        uuid: json['uuid'],
        // createdAt: json['created_at'],
        // updatedAt: json['updated_at'],
        // category: json['subCategories'],
      );
}
