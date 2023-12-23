import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../extensions.dart';
import '../../../tools.dart';
import '../../model/models.dart';
import '../services.dart';

class CategoriesServices {
  static const String baseUrl = 'https://api.bayam.site';

  final UserSession userSession;

  CategoriesServices(this.userSession);

  static CategoriesServices of(UserSession userSession) {
    return CategoriesServices(userSession);
  }

  /// Get all sub-categories.
  Future<void> get({
    required String search,
    required int page,
    required bool refresh,
    required void Function(
      Set<Category>, //result
      int, //totalPages
      int, // currentPage
      bool, // error,
      bool, // refresh,
    ) update,
  }) async {
    late http.Request request;
    if (search.isEmpty) {
      request = http.Request(
        'GET',
        Uri.parse(
          '$baseUrl/api/preference_categories/?itemsPerPage=20&page=${page + 1}',
        ),
      );
    } else {
      request = http.Request(
        'GET',
        Uri.parse(
          '$baseUrl/api/preference_categories/?itemsPerPage=20&page=${page + 1}&name=$search',
        ),
      );
    }
    request.headers.addAll(Services.headerAcceptldJson);
    http.Response response = await HttpRequest.attemptHttpCall(request);
    if (response.statusCode == 200) {
      Map<dynamic, dynamic> result = jsonDecode(response.body);
      update(
        List.from(result['hydra:member'])
            .map((e) => Category.fromMap(e))
            .toSet(),
        result['hydra:totalItems'],
        page + 1,
        false,
        refresh,
      );
    } else {
      throw Functions.throwExceptionFromResponse(userSession, response);
    }
  }

  /// Get category by id.
  Future<Category> getById(String id) async {
    http.Request request = http.Request(
      'GET',
      Uri.parse(
        '$baseUrl/api/preference_categories/$id',
      ),
    );
    request.headers.addAll(Services.headerAcceptldJson);
    http.Response response = await HttpRequest.attemptHttpCall(request);
    if (response.statusCode == 200) {
      return response.toCategory;
    } else {
      throw Functions.throwExceptionFromResponse(userSession, response);
    }
  }

  /// Create new category with [name] and [description].
  Future<Category> post({
    required String name,
    required String description,
  }) async {
    var request = http.Request(
      'POST',
      Uri.parse(
        '$baseUrl/api/preferences/category',
      ),
    );
    request.headers.addAll(Services.headersldJson);
    request.body = json.encode({
      'name': name,
      'description': description,
    });
    http.Response response = await HttpRequest.attemptHttpCall(request);
    if (response.statusCode == 201) {
      return Category.fromMap(jsonDecode(response.body));
    } else {
      throw Functions.throwExceptionFromResponse(userSession, response);
    }
  }

  Future<void> update(Category category) async {
    var request = http.Request(
      'PATCH',
      Uri.parse(
        '$baseUrl/api/preference_categories/${category.uuid}',
      ),
    );
    request.headers.addAll(Services.headersldJson);
    request.body = json.encode({
      'name': category.name,
      'description': category.description,
    });
    http.Response response = await HttpRequest.attemptHttpCall(request);
    if (response.statusCode != 200) {
      throw Functions.throwExceptionFromResponse(userSession, response);
    }
  }
}
