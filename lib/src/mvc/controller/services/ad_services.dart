import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../model/models.dart';
import '../services.dart';

class AdServices {
  static const String baseUrl = 'https://api.bayam.site';

  static Future<Ad> post(Ad ad) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request(
      'POST',
      Uri.parse(
        '$baseUrl/api/post',
      ),
    );
    request.body = json.encode(ad.toMapInit);
    request.headers.addAll(headers);
    http.Response response = await HttpRequest.attemptHttpCall(
      request,
      forceSkipRetries: true,
    );
    if (response.statusCode == 201) {
      return Ad.fromResponse(response.body);
    } else {
      log(response.body);
      Map<int, String> statusCodesPhrases = {
        400: 'Invalid input',
        422: 'Unprocessable entity',
        500: 'internal-server-error',
      };
      throw BackendException(
        code: statusCodesPhrases[response.statusCode],
        statusCode: response.statusCode,
      );
    }
  }

  static Future<void> get(String id) async {
    var request = http.Request(
      'GET',
      Uri.parse(
        '$baseUrl/api/post/$id',
      ),
    );
    http.Response response = await HttpRequest.attemptHttpCall(
      request,
      forceSkipRetries: true,
    );
    if (response.statusCode == 200) {
      return;
    } else {
      Map<int, String> statusCodesPhrases = {
        404: 'Resource not found',
        500: 'internal-server-error',
      };
      throw BackendException(
        code: statusCodesPhrases[response.statusCode],
        statusCode: response.statusCode,
      );
    }
  }

  static Future<void> list() async {}
}
