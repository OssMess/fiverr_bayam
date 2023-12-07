import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/models.dart';
import '../services.dart';

class CategoriesSubServices {
  static const String baseUrl = 'https://api.bayam.site';

  static Future<Set<CategorySub>> get() async {
    var request = http.Request(
      'GET',
      Uri.parse(
        '$baseUrl/api/preferences/sub/categories',
      ),
    );
    request.headers.addAll(Services.headerAcceptldJson);
    http.Response response = await HttpRequest.attemptHttpCall(request);
    if (response.statusCode == 200) {
      return List.from(jsonDecode(response.body)['hydra:member'])
          .map((e) => CategorySub.fromJson(e))
          .toSet();
    } else {
      Map<int, String> statusCodesPhrases = {
        500: 'internal-server-error',
      };
      throw BackendException(
        code: statusCodesPhrases[response.statusCode],
        statusCode: response.statusCode,
      );
    }
  }

  Future<CategorySub> post({
    required String name,
    required String description,
    required String category,
  }) async {
    var request = http.Request(
      'POST',
      Uri.parse(
        '$baseUrl/api/preferences/sub/category',
      ),
    );
    request.headers.addAll(Services.headersldJson);
    request.body = json.encode({
      'name': name,
      'description': description,
      'category': category,
    });
    http.Response response = await HttpRequest.attemptHttpCall(request);
    if (response.statusCode == 201) {
      return CategorySub.fromJson(jsonDecode(response.body));
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
