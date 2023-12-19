import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place {
  final String formattedAddress;
  final Geometry geometry;
  final String placeId;
  final List<String> types;
  final String url;
  final int utcOffset;
  final String vicinity;

  Place({
    required this.formattedAddress,
    required this.geometry,
    required this.placeId,
    required this.types,
    required this.url,
    required this.utcOffset,
    required this.vicinity,
  });

  factory Place.fromJson(Map<dynamic, dynamic> json) => Place(
        formattedAddress: json['formatted_address'],
        geometry: Geometry.fromJson(json['geometry']),
        placeId: json['place_id'],
        types: List<String>.from(json['types'].map((x) => x)),
        url: json['url'],
        utcOffset: json['utc_offset'],
        vicinity: json['vicinity'],
      );

  LatLng get latlng => LatLng(
        geometry.location.lat,
        geometry.location.lng,
      );
}

class Geometry {
  final Location location;
  final Viewport viewport;

  Geometry({
    required this.location,
    required this.viewport,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        location: Location.fromJson(json['location']),
        viewport: Viewport.fromJson(json['viewport']),
      );

  Map<String, dynamic> toJson() => {
        'location': location.toJson(),
        'viewport': viewport.toJson(),
      };
}

class Location {
  final double lat;
  final double lng;

  Location({
    required this.lat,
    required this.lng,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json['lat']?.toDouble(),
        lng: json['lng']?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };
}

class Viewport {
  final Location northeast;
  final Location southwest;

  Viewport({
    required this.northeast,
    required this.southwest,
  });

  factory Viewport.fromJson(Map<String, dynamic> json) => Viewport(
        northeast: Location.fromJson(json['northeast']),
        southwest: Location.fromJson(json['southwest']),
      );

  Map<String, dynamic> toJson() => {
        'northeast': northeast.toJson(),
        'southwest': southwest.toJson(),
      };
}
