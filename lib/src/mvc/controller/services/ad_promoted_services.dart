import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../tools.dart';
import '../../model/enums.dart';
import '../../model/models.dart';
import '../services.dart';

class AdPromotedServices {
  static const String baseUrl = 'https://api.bayam.site';

  final UserSession userSession;

  AdPromotedServices(this.userSession);

  static AdPromotedServices of(UserSession userSession) {
    return AdPromotedServices(userSession);
  }

  Future<AdPromoted> post({
    required DateTime startDate,
    required DateTime endDate,
    required Ad ad,
    required Plan plan,
    required LatLng location,
  }) async {
    GeoCodingLocation? geoCodingLocation =
        await GeoCodingLocation.getLatLngGeoCodingLocation(
      location,
      'en',
    );
    //TODO if geoCodingLocation == null
    Map<String, dynamic> body = {};
    if (plan.place == PlanPlace.byCountry) {
      Country? country = await CountriesServices.of(userSession)
          .find(search: geoCodingLocation!.country!);
      //TODO if country == null
      body['localization'] = [
        {
          'type': 'country',
          'id_localization': country!.id,
        },
      ];
    } else {
      City? city = await CitiesServices.of(userSession)
          .find(search: geoCodingLocation!.city!);
      //TODO if city == null
      body['localization'] = [
        {
          'type': 'city',
          'id_localization': city!.id,
        },
      ];
    }
    body.addAll(
      {
        'post': ad.uuid,
        'plan': plan.uuid,
        'startDate': DateFormat('yyyy/MM/dd').format(startDate),
        'endDate': DateFormat('yyyy/MM/dd').format(endDate),
      },
    );
    var request = http.Request(
      'POST',
      Uri.parse(
        '$baseUrl/api/post/ads',
      ),
    );
    request.headers.addAll(Services.headersldJson);
    request.body = json.encode(body);
    http.Response response = await HttpRequest.attemptHttpCall(
      request,
      forceSkipRetries: true,
    );
    if (response.statusCode == 201) {
      return AdPromoted.fromMap(jsonDecode(response.body));
    } else {
      throw Functions.throwExceptionFromResponse(userSession, response);
    }
  }

  // Future<AdPromoted> get() async {
  //   var request = http.Request(
  //     'GET',
  //     Uri.parse(
  //       '$baseUrl/api/ads/',
  //     ),
  //   );
  //   request.headers.addAll(Services.headerAcceptldJson);
  //   http.Response response = await HttpRequest.attemptHttpCall(
  //     request,
  //     forceSkipRetries: true,
  //   );
  //   if (response.statusCode == 200) {
  //     return AdPromoted.fromMap(jsonDecode(response.body));
  //   } else {
  //     throw Functions.throwExceptionFromResponse(userSession, response);
  //   }
  // }
}
