import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../tools.dart';
import '../../model/models.dart';
import '../services.dart';

class CompanyServices {
  static const String baseUrl = 'https://api.bayam.site';

  final UserSession userSession;

  CompanyServices(this.userSession);

  static CompanyServices of(UserSession userSession) {
    return CompanyServices(userSession);
  }

  /// like company.
  Future<void> like(UserMin userMin) async {
    var request = http.Request(
      'POST',
      Uri.parse(
        '$baseUrl/api/company/${userMin.uid}/like',
      ),
    );
    request.body = json.encode({});
    request.headers.addAll(Services.headersldJson);
    http.Response response = await HttpRequest.attemptHttpCall(
      request,
      forceSkipRetries: true,
    );
    if (response.statusCode == 201) {
    } else {
      throw Functions.throwExceptionFromResponse(userSession, response);
    }
  }

  Future<void> get({
    required int page,
    required bool refresh,
    required void Function(
      Set<UserMin>, //result
      int, //totalPages
      int, // currentPage
      bool, // error,
      bool, // refresh,
    ) update,
  }) async {
    var request = http.Request(
      'GET',
      Uri.parse(
        '$baseUrl/api/company/most-popular',
      ),
    );
    request.headers.addAll(
      Services.headersldJson,
    );
    request.body = json.encode({
      'actionLikeType': '',
    });
    http.Response response = await HttpRequest.attemptHttpCall(
      request,
      forceSkipRetries: true,
    );
    if (response.statusCode == 200) {
      Map<dynamic, dynamic> result = jsonDecode(response.body);
      update(
        List.from(result['hydra:member'])
            .map((json) => UserMin.fromMap(json))
            .toSet(),
        result['hydra:totalItems'] ?? 0,
        page + 1,
        false,
        refresh,
      );
    } else {
      throw Functions.throwExceptionFromResponse(userSession, response);
    }
  }
}
