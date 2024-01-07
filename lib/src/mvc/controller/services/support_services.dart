import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../tools.dart';
import '../../model/models.dart';
import '../services.dart';

class SupportServices {
  static const String baseUrl = 'https://api.bayam.site';

  final UserSession userSession;

  SupportServices(this.userSession);

  static SupportServices of(UserSession userSession) {
    return SupportServices(userSession);
  }

  Future<void> post({
    required String subject,
    required String department,
    required String message,
  }) async {
    var request = http.Request(
      'POST',
      Uri.parse(
        '$baseUrl/api/user/ask',
      ),
    );
    request.body = json.encode({
      'subject': subject,
      'message': message,
      'speciality': department,
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
