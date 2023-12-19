import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceCandidate {
  PlaceCandidate({
    required this.formattedAddress,
    required this.location,
    required this.name,
    required this.placeId,
    required this.types,
  });

  final String formattedAddress;
  final LatLng location;
  final String name;
  final String placeId;
  final List<String> types;

  factory PlaceCandidate.fromJson(Map<dynamic, dynamic> json) => PlaceCandidate(
        formattedAddress: json['formatted_address'],
        location: LatLng(
          json['geometry']['location']['lat'],
          json['geometry']['location']['lng'],
        ),
        name: json['name'],
        placeId: json['place_id'],
        types: List<String>.from(json['types'].map((x) => x)),
      );
}
