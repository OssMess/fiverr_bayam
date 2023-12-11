import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../extensions.dart';
import '../../../tools.dart';
import '../../model/models.dart';
import '../services.dart';

class DiscussionServices {
  static const String baseUrl = 'https://api.bayam.site';

  final UserSession userSession;

  DiscussionServices(this.userSession);

  static DiscussionServices of(UserSession userSession) {
    return DiscussionServices(userSession);
  }

  Future<void> get({
    required DateTime lastDate,
    required int page,
    required bool refresh,
    required void Function(
      Set<Discussion>, //result
      int, //totalPages
      int, // currentPage
      bool, // error,
      bool, // refresh,
    ) update,
  }) async {
    var request = http.Request(
      'GET',
      Uri.parse(
        '$baseUrl/api/discussions/me/?page=${page + 1}&lastDate=${lastDate.formatDate()}',
      ),
    );
    request.headers.addAll(Services.headerAcceptldJson);
    http.Response response = await HttpRequest.attemptHttpCall(request);
    if (response.statusCode == 200) {
      Map<dynamic, dynamic> result = jsonDecode(response.body);
      update(
        List.from(result['hydra:member'])
            .map((json) => Discussion.fromJson(json, userSession))
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

  Future<Discussion> post({
    required String receiverId,
  }) async {
    var request = http.Request(
      'POST',
      Uri.parse(
        '$baseUrl/api/discussion',
      ),
    );
    request.headers.addAll(Services.headersldJson);
    request.body = json.encode({
      {
        'receiver': receiverId,
      },
    });
    http.Response response = await HttpRequest.attemptHttpCall(request);
    if (response.statusCode == 201) {
      return jsonToDiscussion(
        jsonDecode(response.body),
        userSession,
      );
    } else {
      throw Functions.throwExceptionFromResponse(userSession, response);
    }
  }
}
