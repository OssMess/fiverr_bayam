import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/models.dart';
import '../services.dart';

class PreferencesServices {
  static const String baseUrl = 'https://api.bayam.site';

  final UserSession userSession;

  PreferencesServices(this.userSession);

  static PreferencesServices of(UserSession userSession) {
    return PreferencesServices(userSession);
  }

  Future<List<Preference>> get() async {
    var request = http.Request(
      'GET',
      Uri.parse(
        '$baseUrl/api/preferences/categories',
      ),
    );
    request.headers.addAll(Services.headerAcceptldJson);
    http.Response response = await HttpRequest.attemptHttpCall(request);
    if (response.statusCode == 200) {
      return List.from(jsonDecode(response.body)['hydra:member'])
          .map((e) => Preference.fromJson(e))
          .toList();
    } else {
      Map<int, String> statusCodesPhrases = {
        500: 'internal-server-error',
      };
      throw BackendException(
        code: statusCodesPhrases[response.statusCode],
        statusCode: response.statusCode,
      );
    }
  }

  Future<Preference> post({
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
      return Preference.fromJson(jsonDecode(response.body));
    } else {
      Map<int, String> statusCodesPhrases = {
        400: 'invalid-input',
        500: 'internal-server-error',
      };
      throw BackendException(
        code: statusCodesPhrases[response.statusCode],
        statusCode: response.statusCode,
      );
    }
  }
}
