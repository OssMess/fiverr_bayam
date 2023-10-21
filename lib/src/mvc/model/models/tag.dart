import '../../../extensions.dart';

Tag jsonToTag(Map<String, dynamic> json) => Tag.fromMap(json);

class Tag {
  final String id;
  final String name;
  final String description;

  Tag({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Tag.fromMap(Map<dynamic, dynamic> json) => Tag(
        id: json['uuid'],
        name: json['name'],
        description: json['description'],
      );

  factory Tag.init(String name) => Tag(
        id: '',
        name: name,
        description: '',
      );

  Map<String, dynamic> get toMap => {
        if (id.isNotNullOrEmpty) 'uuid': id,
        'name': name,
        'description': description,
      };
}
