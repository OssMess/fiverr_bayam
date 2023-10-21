import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../extensions.dart';
import '../../model/enums.dart';
import '../../model/models.dart';
import '../services.dart';

class AdServices {
  static const String baseUrl = 'https://api.bayam.site';

  static Future<void> post({
    required String uid,
    required String title,
    required String description,
    required String location,
    required AdType adType,
    required Category category,
    required List<Tag> tags,
  }) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request(
      'POST',
      Uri.parse(
        '$baseUrl/api/post',
      ),
    );
    request.body = json.encode({
      'author': uid,
      'isPromotion': true,
      'location': location,
      'content': description,
      'tags': tags.map((e) => e.id).toList(),
      'category': category.key,
    });
    request.headers.addAll(headers);
    http.Response response = await HttpRequest.attemptHttpCall(
      request,
      forceSkipRetries: true,
    );
    if (response.statusCode == 201) {
      //FIXME return  ad
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
}
