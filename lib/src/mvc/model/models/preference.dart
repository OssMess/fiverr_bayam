class Preference {
  final String name;
  final String description;
  final String uuid;
  // final String createdAt;
  // final String updatedAt;
  // final String category;

  Preference({
    required this.name,
    required this.description,
    required this.uuid,
    // required this.createdAt,
    // required this.updatedAt,
    // required this.category,
  });

  factory Preference.fromJson(Map<String, dynamic> json) => Preference(
        name: json['name'],
        description: json['description'],
        uuid: json['uuid'],
        // createdAt: json['created_at'],
        // updatedAt: json['updated_at'],
        // category: json['category'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'uuid': uuid,
        // 'created_at': createdAt,
        // 'updated_at': updatedAt,
        // 'category': category,
      };
}
