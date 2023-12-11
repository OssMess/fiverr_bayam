import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/models.dart';
import '../services.dart';

class AdPromotedServices {
  static const String baseUrl = 'https://api.bayam.site';

  static Future<AdPromoted> post({
    required String id,
    required DateTime startDate,
    required DateTime endDate,
    required String content,
    required int budget,
  }) async {
    var request = http.Request(
      'POST',
      Uri.parse(
        '$baseUrl/api/post/promotion',
      ),
    );
    request.headers.addAll(Services.headersldJson);
    request.body = json.encode({
      'post': id,
      'startDate': startDate.toString(),
      'endDate': endDate.toString(),
      'content': content,
      'budget': budget,
    });
    http.Response response = await HttpRequest.attemptHttpCall(
      request,
      forceSkipRetries: true,
    );
    if (response.statusCode == 201) {
      return AdPromoted.fromMap(jsonDecode(response.body));
    } else {
      Map<int, String> statusCodesPhrases = {
        400: 'invalid-input',
        422: 'unprocessable-entity',
        500: 'internal-server-error',
      };
      throw BackendException(
        code: statusCodesPhrases[response.statusCode],
        statusCode: response.statusCode,
      );
    }
  }

  static Future<AdPromoted> get(String id) async {
    var request = http.Request(
      'GET',
      Uri.parse(
        '$baseUrl/api/ads/$id',
      ),
    );
    request.headers.addAll(Services.headerAcceptldJson);
    http.Response response = await HttpRequest.attemptHttpCall(
      request,
      forceSkipRetries: true,
    );
    if (response.statusCode == 200) {
      return AdPromoted.fromMap(jsonDecode(response.body));
    } else {
      Map<int, String> statusCodesPhrases = {
        404: 'resource-not-found',
        500: 'internal-server-error',
      };
      throw BackendException(
        code: statusCodesPhrases[response.statusCode],
        statusCode: response.statusCode,
      );
    }
  }
}
