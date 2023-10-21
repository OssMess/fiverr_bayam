import '../mvc/model/models.dart';

extension Mapextensions on Map<dynamic, dynamic> {
  Ad get toAd => Ad.fromJson(this);
}
