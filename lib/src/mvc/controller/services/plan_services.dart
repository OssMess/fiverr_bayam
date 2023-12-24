import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../tools.dart';
import '../../model/models.dart';
import '../services.dart';

class PlanServices {
  static const String baseUrl = 'https://api.bayam.site';

  final UserSession userSession;

  PlanServices(this.userSession);

  static PlanServices of(UserSession userSession) {
    return PlanServices(userSession);
  }

  /// Get all Plan.
  Future<void> get({
    required int page,
    required bool refresh,
    required void Function(
      Set<Plan>, //result
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
        '$baseUrl/api/plan/?page=${page + 2}',
      ),
    );
    request.headers.addAll(Services.headerAcceptldJson);
    http.Response response = await HttpRequest.attemptHttpCall(request);
    if (response.statusCode == 200) {
      Map<dynamic, dynamic> result = jsonDecode(response.body);
      List<Plan> sortedList = List.from(result['hydra:member'])
          .map((e) => Plan.fromMap(e))
          .toList();
      sortedList.sort((a, b) => a.budget.compareTo(b.budget));
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
}
