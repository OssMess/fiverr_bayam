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

  static Future<GeoCodingLocation?> getGeoCodingFromIP(
    String local,
  ) async {
    IPLocation? ipLocation = await OtherServices.getIPLocation();
    if (ipLocation == null) return null;
    return await getGeoCodingFromLatLng(
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
    return await getGeoCodingFromLatLng(
      latlng: latlng,
      local: local,
    );
  }

  static Future<GeoCodingLocation?> getGeoCodingFromCurrentLocation(
    String local,
  ) async {
    Position location = await Geolocator.getCurrentPosition();
    return await getGeoCodingFromLatLng(
      latlng: LatLng(location.latitude, location.longitude),
      local: local,
    );
  }

  static Future<GeoCodingLocation?> getGeoCodingFromLatLng({
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

  static Future<(Country?, City?)> getCountryCityFromIP(
    UserSession userSession,
    String local,
  ) async {
    IPLocation? ipLocation = await OtherServices.getIPLocation();
    if (ipLocation == null) {
      return (null, null);
    }
    return await getCountryCity(
      userSession,
      LatLng(ipLocation.lat, ipLocation.lon),
      local,
    );
  }

  /// geocode location from IP address to a `Country` and `City` in [local] language.
  static Future<(Country?, City?)> getCountryCityFromCurrentLocation(
    UserSession userSession,
    String local,
  ) async {
    Position location = await Geolocator.getCurrentPosition();
    return await getCountryCity(
      userSession,
      LatLng(location.latitude, location.longitude),
      local,
    );
  }

  /// geocode [latlng] to a `Country` and `City` in [local] language.
  static Future<(Country?, City?)> getCountryCity(
    UserSession userSession,
    LatLng latlng,
    String local,
  ) async {
    GeoCodingLocation? geoCodingLocation =
        await GeoCodingLocation.getLatLngGeoCodingLocation(latlng, local);
    if (geoCodingLocation == null) {
      return (null, null);
    }
    Country? country = (userSession.countries ?? [])
            .where((element) => element.name == geoCodingLocation.country)
            .isNotEmpty
        ? null
        : await CountriesServices.of(userSession)
            .find(search: geoCodingLocation.country!);
    City? city = (userSession.cities ?? [])
            .where((element) => element.name == geoCodingLocation.city)
            .isNotEmpty
        ? null
        : await CitiesServices.of(userSession)
            .find(search: geoCodingLocation.city!);
    return (country, city);
  }
}
