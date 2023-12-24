import 'dart:convert';

import 'package:bayam/src/extensions.dart';
import 'package:http/http.dart' as http;

import '../../../tools.dart';
import '../../model/models.dart';
import '../services.dart';

class CountriesServices {
  static const String baseUrl = 'https://api.bayam.site';

  final UserSession userSession;

  CountriesServices(this.userSession);

  static CountriesServices of(UserSession userSession) {
    return CountriesServices(userSession);
  }

  /// Get `Country` by [id].
  Future<Country> getById(String id) async {
    var request = http.Request(
      'GET',
      Uri.parse(
        '$baseUrl/api/countries/$id',
      ),
    );
    request.headers.addAll(Services.headerAcceptldJson);
    http.Response response = await HttpRequest.attemptHttpCall(
      request,
      forceSkipRetries: true,
    );
    if (response.statusCode == 200) {
      return response.toCountry;
    } else {
      throw Functions.throwExceptionFromResponse(userSession, response);
    }
  }

  /// Get all countries.
  Future<void> get({
    required String search,
    required int page,
    required bool refresh,
    required void Function(
      Set<Country>, //result
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
          '$baseUrl/api/countries/?itemsPerPage=20&page=${page + 1}',
        ),
      );
    } else {
      request = http.Request(
        'GET',
        Uri.parse(
          '$baseUrl/api/countries/?itemsPerPage=20&page=${page + 1}&name=$search',
        ),
      );
    }
    request.headers.addAll(Services.headerAcceptldJson);
    http.Response response = await HttpRequest.attemptHttpCall(request);
    if (response.statusCode == 200) {
      Map<dynamic, dynamic> result = jsonDecode(response.body);
      update(
        List.from(result['hydra:member'])
            .map((e) => Country.fromMap(e))
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

  /// Get country by name.
  Future<Country?> find({
    required String search,
  }) async {
    late http.Request request;
    request = http.Request(
      'GET',
      Uri.parse(
        '$baseUrl/api/countries/?itemsPerPage=50&page=1&name=$search',
      ),
    );
    request.headers.addAll(Services.headerAcceptldJson);
    http.Response response = await HttpRequest.attemptHttpCall(request);
    if (response.statusCode == 200) {
      Map<dynamic, dynamic> result = jsonDecode(response.body);
      try {
        return List.from(result['hydra:member'])
            .map((e) => Country.fromMap(e))
            .first;
      } catch (e) {
        return null;
      }
    } else {
      throw Functions.throwExceptionFromResponse(userSession, response);
    }
  }
}
