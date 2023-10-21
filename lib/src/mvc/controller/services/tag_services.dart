import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/models.dart';
import '../services.dart';

class TagServices {
  static const String baseUrl = 'https://api.bayam.site';

  static Future<Tag> get(String name) async {
    var request = http.Request(
      'GET',
      Uri.parse(
        '$baseUrl/api/tag/$name',
      ),
    );
    http.Response response = await HttpRequest.attemptHttpCall(
      request,
      forceSkipRetries: true,
    );
    if (response.statusCode == 200) {
      return Tag.fromJson(jsonDecode(response.body));
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

  static Future<Tag> post(String name) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request(
      'POST',
      Uri.parse(
        '$baseUrl/api/tag',
      ),
    );
    request.body = json.encode({
      'name': name,
      'description': '',
    });
    request.headers.addAll(headers);
    http.Response response = await HttpRequest.attemptHttpCall(
      request,
      forceSkipRetries: true,
    );
    if (response.statusCode == 201) {
      return Tag.fromJson(jsonDecode(response.body));
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
}
