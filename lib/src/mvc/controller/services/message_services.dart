import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../extensions.dart';
import '../../model/models.dart';
import '../services.dart';

class MessageServices {
  static const String baseUrl = 'https://api.bayam.site';

  /// Get list message in a discussion with [discussionId]
  static Future<Set<Message>> get({
    required String discussionId,
  }) async {
    var request = http.Request(
      'GET',
      Uri.parse(
        '$baseUrl/api/message/me/receiver/$discussionId',
      ),
    );
    request.headers.addAll(Services.headerAcceptldJson);
    http.Response response = await HttpRequest.attemptHttpCall(request);
    if (response.statusCode == 200) {
      return (jsonDecode(
        response.body,
      )['hydra:member'] as List<Map<dynamic, dynamic>>)
          .map((json) => Message.fromJson(json))
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

  /// Send a message with [receiverId], [discussionId],[message] and [images].
  static Future<Message> post({
    required String receiverId,
    required String discussionId,
    required String message,
    required List<File> images,
  }) async {
    var request = http.Request(
      'POST',
      Uri.parse(
        '$baseUrl/api/message',
      ),
    );
    request.headers.addAll(Services.headersldJson);
    List<String> imagesBase64 = [];
    for (var image in images) {
      imagesBase64.add(await image.toBase64String());
    }
    request.body = json.encode({
      {
        'receiver': receiverId,
        'discussion': discussionId,
        'message': message,
        'images': imagesBase64,
      },
    });
    http.Response response = await HttpRequest.attemptHttpCall(request);
    if (response.statusCode == 201) {
      return jsonToMessage(
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
