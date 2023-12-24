import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../controller/services.dart';
import '../models.dart';

class GeoCodingLocation {
  final String? city;
  final String? country;
  final String? countryCode;
  final String? postalCode;
  final String? streetAddress;

  GeoCodingLocation({
    required this.city,
    required this.country,
    required this.countryCode,
    required this.postalCode,
    required this.streetAddress,
  });

  static Future<GeoCodingLocation?> getIPGeoCodingLocation(
    String local,
  ) async {
    IPLocation? ipLocation = await OtherServices.getIPLocation();
    if (ipLocation == null) return null;
    return await getGeoCodingLocation(
      latlng: LatLng(ipLocation.lat, ipLocation.lon),
      local: local,
      countryCode: ipLocation.countryCode,
      zipCode: ipLocation.zip,
    );
  }

  static Future<GeoCodingLocation?> getLatLngGeoCodingLocation(
    LatLng latlng,
    String local,
  ) async {
    return await getGeoCodingLocation(
      latlng: latlng,
      local: local,
    );
  }

  static Future<GeoCodingLocation?> getCurrentGeoCodingLocation(
    String local,
  ) async {
    Position location = await Geolocator.getCurrentPosition();
    return await getGeoCodingLocation(
      latlng: LatLng(location.latitude, location.longitude),
      local: local,
    );
  }

  static Future<GeoCodingLocation?> getGeoCodingLocation({
    required LatLng latlng,
    required String local,
    String? countryCode,
    String? zipCode,
  }) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      latlng.latitude,
      latlng.longitude,
      localeIdentifier: local,
    );
    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks.first;
      return GeoCodingLocation(
        city: placemark.administrativeArea,
        country: placemark.country,
        countryCode: placemark.isoCountryCode ?? countryCode,
        postalCode: zipCode ?? placemark.postalCode,
        streetAddress: placemark.street,
      );
    }
    return null;
  }
}
