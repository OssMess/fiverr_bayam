import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';

import '../../model/models_map.dart';

///Include google map services.
class GoogleMapsApi {
  static String key = Platform.isAndroid
      ? 'AIzaSyChqfww86A2Z_YNU7xAqR4m0_-3oV9kyF0'
      : 'AIzaSyD_mt-tls5e1ZzSCQGnX9VkFT5IS3F2i70';

  static String nearbysearch =
      'https://maps.googleapis.com/maps/api/place/nearbysearch';
  static String geocode = 'https://maps.googleapis.com/maps/api/geocode';
  static String distancematrix =
      'https://maps.googleapis.com/maps/api/distancematrix';
  static String findplacefromtext =
      'https://maps.googleapis.com/maps/api/place/findplacefromtext';

  static String autoComplete =
      'https://maps.googleapis.com/maps/api/place/autocomplete';

  static String placeById =
      'https://maps.googleapis.com/maps/api/place/details';

  ///Returns a list of `PlaceNearby` based on a given [location] within [radius].
  ///User [pagetoken] for pagination if you want to retrieve nearby places in a specific page.
  static Future<List<PlaceNearby>> queryNearbyPlaces(
    LatLng location,
    int radius,
    String? pagetoken,
  ) async {
    late Request request;
    if (pagetoken == null) {
      request = Request(
        'GET',
        Uri.parse(
          '$nearbysearch/json?location=${location.latitude}, ${location.longitude}&radius=$radius&key=$key',
        ),
      );
    } else {
      request = Request(
        'GET',
        Uri.parse(
          '$nearbysearch/json?location=${location.latitude}, ${location.longitude}&radius=$radius&key=$key&pagetoken=$pagetoken',
        ),
      );
    }
    StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      Map<String, dynamic> result =
          jsonDecode(await response.stream.bytesToString());
      handleMapApiResult(result);
      List<PlaceNearby> list = List<PlaceNearby>.from(
          result['results'].map((json) => PlaceNearby.fromMap(json)));
      if (result['next_page_token'] != null) {
        var pagination = await queryNearbyPlaces(
            location, radius, result['next_page_token']);
        list.addAll(pagination);
      }
      return list;
    } else {
      log(response.reasonPhrase.toString());
      throw Exception(response.reasonPhrase);
    }
  }

  ///Translate a location on the map into a human-readable address, is known as reverse geocoding.
  ///Translates a given [location] coordinates to an address in the selected
  ///language defined in [locale]. The reverse geocoding API returns results of
  ///types: `route`, `street_address`, `plus_code`, or `political`, in this order,
  /// but we return the first result.
  static Future<String> queryReverseGeoCode(
    LatLng location,
    Locale locale,
  ) async {
    var request = Request(
        'GET',
        Uri.parse(
            '$geocode/json?latlng=${location.latitude},${location.longitude}&language=${locale.languageCode}&result_type=route|street_address|plus_code|political&key=$key'));
    StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      Map<String, dynamic> result =
          jsonDecode(await response.stream.bytesToString());
      handleMapApiResult(result);
      ReverseGeocode geocode = ReverseGeocode.fromMap(result);
      return geocode.formattedAddress;
    } else {
      log(response.reasonPhrase.toString());
      throw Exception(response.reasonPhrase);
    }
  }

  ///return distance between two points [origin] and [destination].
  static Future<int> queryDistanceMatrix(
    LatLng origin,
    LatLng destination,
  ) async {
    var request = Request(
        'GET',
        Uri.parse(
            '$distancematrix/json?origins=${origin.latitude},${origin.longitude}&destinations=${destination.latitude},${destination.longitude}&units=metric&language=en&key=$key'));
    StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      Map<String, dynamic> result =
          jsonDecode(await response.stream.bytesToString());
      handleMapApiResult(result);
      return DistanceMatrix.fromMap(result).distance;
    } else {
      log(response.reasonPhrase.toString());
      throw Exception(response.reasonPhrase);
    }
  }

  ///auto complete query with [text].
  static Future<List<PlaceAutoComplete>> queryAutoComplete(
    String text,
  ) async {
    Request request = Request(
      'GET',
      Uri.parse(
        '$autoComplete/json?input=$text&types=route|locality|street_address&fields=address_components&key=$key',
      ),
    );
    StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      Map<String, dynamic> result =
          jsonDecode(await response.stream.bytesToString());
      handleMapApiResult(result);
      var list = List<PlaceAutoComplete>.from(
        result['predictions'].map(
          (json) => PlaceAutoComplete.fromMap(json),
        ),
      );
      return list;
    } else {
      log(response.reasonPhrase.toString());
      throw Exception(response.reasonPhrase);
    }
  }

  ///Returns a list of places `PlaceCandidate` based on a user’s search string [text].
  ///Use [pagetoken] for pagination if you want to retrieve results from a specific page
  static Future<List<PlaceCandidate>> queryPlaceFromText(
    String text,
    String? pagetoken,
  ) async {
    late Request request;
    if (pagetoken == null) {
      request = Request(
        'GET',
        Uri.parse(
          '$findplacefromtext/json?fields=formatted_address%2Cname%2Cgeometry%2Cplace_id%2Ctype&input=$text&inputtype=textquery&key=$key',
        ),
      );
    } else {
      request = Request(
        'GET',
        Uri.parse(
          '$findplacefromtext/json?fields=formatted_address%2Cname%2Cgeometry%2Cplace_id%2Ctype&input=$text&inputtype=textquery&key=$key&pagetoken=$pagetoken',
        ),
      );
    }
    StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      Map<String, dynamic> result =
          jsonDecode(await response.stream.bytesToString());
      handleMapApiResult(result);
      var list = List<PlaceCandidate>.from(
        result['candidates'].map(
          (json) => PlaceCandidate.fromMap(json),
        ),
      );
      if (result['next_page_token'] != null) {
        var pagination =
            await queryPlaceFromText(text, result['next_page_token']);
        list.addAll(pagination);
      }
      return list;
    } else {
      log(response.reasonPhrase.toString());
      throw Exception(response.reasonPhrase);
    }
  }

  ///return a place with [placeId].
  static Future<Place> getPlaceById(String placeId) async {
    Request request = Request(
      'GET',
      Uri.parse(
        '$placeById/json?placeid=$placeId&fields=formatted_address,geometry,place_id,types,url,utc_offset,vicinity&key=$key',
      ),
    );
    StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      Map<String, dynamic> result =
          jsonDecode(await response.stream.bytesToString());
      handleMapApiResult(result);
      return Place.fromMap(result['result']);
    } else {
      log(response.reasonPhrase.toString());
      throw Exception(response.reasonPhrase);
    }
  }

  static void handleMapApiResult(Map<String, dynamic> result) {
    try {
      switch (result['status']) {
        case 'OK':
        case 'ZERO_RESULTS':
          break;
        default:
          throw Exception(result['status']);
      }
    } on Exception catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
