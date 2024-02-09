import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../tools.dart';
import '../../model/models.dart';
import '../services.dart';

class FavoritesServices {
  static const String baseUrl = 'https://api.bayam.site';

  final UserSession userSession;

  FavoritesServices(this.userSession);

  static FavoritesServices of(UserSession userSession) {
    return FavoritesServices(userSession);
  }

  /// Get all Plan.
  Future<void> get({
    required int page,
    required bool refresh,
    required void Function(
      Set<Ad>, //result
      int, //totalPages
      int, // currentPage
      bool, // error,
      bool, // refresh,
    ) update,
  }) async {
    late http.Request request;
    request = http.Request(
      'GET',
      Uri.parse(
        '$baseUrl/api/favorites/?page=${page + 1}',
      ),
    );
    request.headers.addAll(Services.headerAcceptldJson);
    http.Response response = await HttpRequest.attemptHttpCall(request);
    if (response.statusCode == 200) {
      Map<dynamic, dynamic> result = jsonDecode(response.body);
      List<Ad> sortedList = List.from(result['hydra:member'])
          .map((e) => Ad.fromMapGet(e, userSession))
          .toList();
      update(
        sortedList.toSet(),
        result['hydra:totalItems'],
        page + 1,
        false,
        refresh,
      );
    } else {
      throw Functions.throwExceptionFromResponse(userSession, response);
    }
  }

  Future<void> post(String postId) async {
    var request = http.Request(
      'POST',
      Uri.parse(
        '$baseUrl/api/favorites',
      ),
    );
    request.body = json.encode({
      'post': postId,
    });
    request.headers.addAll(Services.headersldJson);
    http.Response response = await HttpRequest.attemptHttpCall(
      request,
    );
    if (response.statusCode != 201) {
      throw Functions.throwExceptionFromResponse(userSession, response);
    }
  }
}
