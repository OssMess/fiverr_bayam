import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../extensions.dart';
import '../../../tools.dart';
import '../../model/models.dart';
import '../services.dart';

class TagServices {
  static const String baseUrl = 'https://api.bayam.site';

  final UserSession userSession;

  TagServices(this.userSession);

  static TagServices of(UserSession userSession) {
    return TagServices(userSession);
  }

  /// Get `Tag` by [id].
  Future<Tag> get(String id) async {
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
      return response.toTag;
    } else {
      throw Functions.throwExceptionFromResponse(userSession, response);
    }
  }

  /// Create tag with [name] and return `Tag`.
  Future<Tag> post(String name) async {
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
      return response.toTag;
    } else {
      throw Functions.throwExceptionFromResponse(userSession, response);
    }
  }
}
