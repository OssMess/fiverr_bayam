import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/models.dart';
import '../services.dart';

class DiscussionServices {
  static const String baseUrl = 'https://api.bayam.site';

  static Future<Set<Discussion>> get() async {
    var request = http.Request(
      'GET',
      Uri.parse(
        '$baseUrl/api/discussions/me/',
      ),
    );
    request.headers.addAll(Services.headerAcceptldJson);
    http.Response response = await HttpRequest.attemptHttpCall(request);
    if (response.statusCode == 200) {
      return (jsonDecode(
        response.body,
      )['hydra:member'] as List<Map<dynamic, dynamic>>)
          .map((json) => Discussion.fromJson(json))
          .toSet();
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

  static Future<Discussion> post({
    required String receiverId,
  }) async {
    var request = http.Request(
      'POST',
      Uri.parse(
        '$baseUrl/api/discussion',
      ),
    );
    request.headers.addAll(Services.headersldJson);
    request.body = json.encode({
      {
        'receiver': receiverId,
      },
    });
    http.Response response = await HttpRequest.attemptHttpCall(request);
    if (response.statusCode == 201) {
      return jsonToDiscussion(
        jsonDecode(response.body),
      );
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
