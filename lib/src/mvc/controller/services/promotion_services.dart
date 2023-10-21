import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/models.dart';
import '../services.dart';

class PromotionServices {
  static const String baseUrl = 'https://api.bayam.site';

  static Future<void> post({
    required String id,
    required DateTime startDate,
    required DateTime endDate,
    required String content,
    required int budget,
  }) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request(
      'POST',
      Uri.parse(
        '$baseUrl/api/post/promotion',
      ),
    );
    request.body = json.encode({
      'post': id,
      'startDate': startDate.toString(),
      'endDate': endDate.toString(),
      'content': content,
      'budget': budget,
    });
    request.headers.addAll(headers);
    http.Response response = await HttpRequest.attemptHttpCall(
      request,
      forceSkipRetries: true,
    );
    if (response.statusCode == 201) {
      //FIXME return  promotion
      return;
    } else {
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
        '$baseUrl/api/post/promotion/$id',
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
}
