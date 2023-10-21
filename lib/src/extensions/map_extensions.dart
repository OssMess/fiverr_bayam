import '../mvc/model/models.dart';

extension Mapextensions on Map<dynamic, dynamic> {
  Ad get toAd => Ad.fromMap(this);

  Author get toAuthor => Author.fromMap(this);

  Tag get toTag => Tag.fromMap(this);
}
