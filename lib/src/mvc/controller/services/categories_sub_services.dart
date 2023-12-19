import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../tools.dart';
import '../../model/models.dart';
import '../services.dart';

class CategoriesSubServices {
  static const String baseUrl = 'https://api.bayam.site';

  final UserSession userSession;

  CategoriesSubServices(this.userSession);

  static CategoriesSubServices of(UserSession userSession) {
    return CategoriesSubServices(userSession);
  }

  /// Get all sub-categories.
  Future<Set<CategorySub>> get() async {
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
          .map((e) => CategorySub.fromMap(e))
          .toSet();
    } else {
      throw Functions.throwExceptionFromResponse(userSession, response);
    }
  }

  /// Create new sub-category with [name],[description] and [categoryId].
  Future<CategorySub> post({
    required String name,
    required String description,
    required String categoryId,
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
      'category': categoryId,
    });
    http.Response response = await HttpRequest.attemptHttpCall(request);
    if (response.statusCode == 201) {
      return CategorySub.fromMap(jsonDecode(response.body));
    } else {
      throw Functions.throwExceptionFromResponse(userSession, response);
    }
  }
}
