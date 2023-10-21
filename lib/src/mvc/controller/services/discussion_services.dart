import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/models.dart';
import '../services.dart';

class DiscussionServices {
  static const String baseUrl = 'https://api.bayam.site';

  static Future<List<Discussion>> get({
    required String uid,
  }) async {
    var request = http.Request(
      'GET',
      Uri.parse(
        '$baseUrl/api/discussions/me/$uid',
      ),
    );
    http.Response response = await HttpRequest.attemptHttpCall(request);
    if (response.statusCode == 200) {
      return (jsonDecode(
        response.body,
      )['hydra:member'] as List<Map<dynamic, dynamic>>)
          .map((json) => Discussion.fromJson(json))
          .toList();
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
    required String senderId,
    required String receiverId,
  }) async {
    var headers = {
      'Content-Type': 'application/Id+json',
    };
    var request = http.Request(
      'POST',
      Uri.parse(
        '$baseUrl/api/discussion',
      ),
    );
    request.body = json.encode({
      {
        'receiver': receiverId,
        'sender': senderId,
      },
    });
    request.headers.addAll(headers);
    http.Response response = await HttpRequest.attemptHttpCall(request);
    if (response.statusCode == 201) {
      return jsonToDiscussion(
        jsonDecode(
          response.body,
        ),
      );
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
