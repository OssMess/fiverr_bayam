import 'dart:convert';

import 'package:bayam/src/extensions.dart';
import 'package:http/http.dart' as http;

import '../../model/models.dart';
import '../services.dart';

class TagServices {
  static const String baseUrl = 'https://api.bayam.site';

  /// Get `Tag` by [id].
  static Future<Tag> get(String id) async {
    var request = http.Request(
      'GET',
      Uri.parse(
        '$baseUrl/api/tag/$id',
      ),
    );
    request.headers.addAll(Services.headerAcceptldJson);
    http.Response response = await HttpRequest.attemptHttpCall(
      request,
      forceSkipRetries: true,
    );
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as Map<dynamic, dynamic>).toTag;
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

  /// Create tag with [name] and return `Tag`.
  static Future<Tag> post(String name) async {
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
    request.headers.addAll(Services.headersldJson);
    http.Response response = await HttpRequest.attemptHttpCall(
      request,
      forceSkipRetries: true,
    );
    if (response.statusCode == 201) {
      return Tag.fromMap(jsonDecode(response.body));
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
}
