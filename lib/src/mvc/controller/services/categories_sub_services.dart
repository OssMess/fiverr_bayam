import 'dart:convert';

import 'package:bayam/src/extensions.dart';
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
  Future<void> get({
    required String search,
    required int page,
    required bool refresh,
    required void Function(
      Set<CategorySub>, //result
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
          '$baseUrl/api/preference_sub_categories/?page=${page + 1}',
        ),
      );
    } else {
      request = http.Request(
        'GET',
        Uri.parse(
          '$baseUrl/api/preference_sub_categories/?page=${page + 1}&content=$search',
        ),
      );
    }
    request.headers.addAll(Services.headerAcceptldJson);
    http.Response response = await HttpRequest.attemptHttpCall(request);
    if (response.statusCode == 200) {
      Map<dynamic, dynamic> result = jsonDecode(response.body);
      update(
        List.from(result['hydra:member'])
            .map((e) => CategorySub.fromMap(e))
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

  /// Get sub-category by id.
  Future<CategorySub> getById(String id) async {
    http.Request request = http.Request(
      'GET',
      Uri.parse(
        '$baseUrl/api/preference_sub_categories/$id',
      ),
    );
    request.headers.addAll(Services.headerAcceptldJson);
    http.Response response = await HttpRequest.attemptHttpCall(request);
    if (response.statusCode == 200) {
      return response.toCategorySub;
    } else {
      throw Functions.throwExceptionFromResponse(userSession, response);
    }
  }

  /// Create new sub-category with [name],[description], and [categoryId].
  Future<CategorySub> post({
    required String name,
    required String description,
    required String categoryId,
  }) async {
    var request = http.Request(
      'POST',
      Uri.parse(
        '$baseUrl/api/preference_sub_categories',
      ),
    );
    request.headers.addAll(Services.headersldJson);
    request.body = json.encode({
      'name': name,
      'description': description,
      'preferenceCategory': '/api/preference_categories/$categoryId',
    });
    http.Response response = await HttpRequest.attemptHttpCall(request);
    if (response.statusCode == 201) {
      return CategorySub.fromMap(jsonDecode(response.body));
    } else {
      throw Functions.throwExceptionFromResponse(userSession, response);
    }
  }

  Future<void> update(CategorySub categorySub) async {
    var request = http.Request(
      'PATCH',
      Uri.parse(
        '$baseUrl/api/preference_sub_categories/${categorySub.uuid}',
      ),
    );
    request.headers.addAll(Services.headersldJson);
    request.body = json.encode({
      'name': categorySub.name,
      'description': categorySub.description,
      'preferenceCategory': categorySub.categoryId,
    });
    http.Response response = await HttpRequest.attemptHttpCall(request);
    if (response.statusCode != 200) {
      throw Functions.throwExceptionFromResponse(userSession, response);
    }
  }
}
