import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../model/models.dart';
import '../services.dart';

class OtherServices {
  /// Get user Location `IpLocation` from IP adress
  /// - route: `http://ip-api.com/json`.
  /// - status code `200`: return `IpLocation` from `response.body`.
  /// - else, throw an exception.
  static Future<IPLocation?> getIPLocation() async {
    var request = http.Request(
      'GET',
      Uri.parse(
        'http://ip-api.com/json',
      ),
    );
    http.Response response = await HttpRequest.attemptHttpCall(request);
    if (response.statusCode == 200) {
      return jsonToIPLocation(response.body);
    } else {
      return null;
    }
  }
}
