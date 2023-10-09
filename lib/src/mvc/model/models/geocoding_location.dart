import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

import '../../../tools.dart';
import '../../controller/services.dart';
import '../models.dart';

Future<GeoCodingLocation?> getGeoCodingLocation(BuildContext context) async {
  String languageCode = DateTimeUtils.of(context).languageCode;
  IPLocation? ipLocation = await OtherServices.getIPLocation();
  if (ipLocation == null) return null;
  List<Placemark> placemarks = await placemarkFromCoordinates(
    ipLocation.lat,
    ipLocation.lon,
    localeIdentifier: languageCode,
  );
  if (placemarks.isNotEmpty) {
    Placemark placemark = placemarks.first;
    return GeoCodingLocation(
      city: placemark.locality,
      country: placemark.country,
      countryCode: placemark.isoCountryCode ?? ipLocation.countryCode,
      postalCode: ipLocation.zip, // ?? placemark.postalCode,
      streetAddress: placemark.street,
    );
  }
  return null;
}

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
}
