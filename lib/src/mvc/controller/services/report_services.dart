import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../tools.dart';
import '../../model/models.dart';
import '../services.dart';

class ReportServices {
  static const String baseUrl = 'https://api.bayam.site';

  final UserSession userSession;

  ReportServices(this.userSession);

  static ReportServices of(UserSession userSession) {
    return ReportServices(userSession);
  }

  /// Create a report for [ad] with [message].
  Future<void> post(Ad ad, String message) async {
    var request = http.Request(
      'POST',
      Uri.parse(
        '$baseUrl/api/post/report',
      ),
    );
    request.body = json.encode({
      'description': message,
      'post': ad.uuid,
    });
    request.headers.addAll(Services.headersldJson);
    http.Response response = await HttpRequest.attemptHttpCall(
      request,
      forceSkipRetries: true,
    );
    if (response.statusCode != 201) {
      throw Functions.throwExceptionFromResponse(userSession, response);
    }
  }
}
