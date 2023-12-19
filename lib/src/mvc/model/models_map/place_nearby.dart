import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceNearby {
  PlaceNearby({
    required this.location,
    required this.name,
    required this.placeId,
    required this.types,
    required this.vicinity,
  });

  final LatLng location;
  final String name;
  final String placeId;
  final List<String> types;
  final String vicinity;

  factory PlaceNearby.fromMap(Map<dynamic, dynamic> json) => PlaceNearby(
        location: LatLng(
          json['geometry']['location']['lat'],
          json['geometry']['location']['lng'],
        ),
        name: json['name'],
        placeId: json['place_id'],
        types: List<String>.from(json['types'].map((x) => x)),
        vicinity: json['vicinity'] ?? '',
      );
}
