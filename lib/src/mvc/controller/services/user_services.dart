import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../extensions.dart';
import '../../model/models.dart';
import '../services.dart';

class UserServices {
  static const String baseUrl = 'https://api.bayam.site';

  final UserSession userSession;

  UserServices(this.userSession);

  static UserServices of(UserSession userSession) {
    return UserServices(userSession);
  }

  Future<void> get() async {
    var request = http.Request(
      'GET',
      Uri.parse(
        '$baseUrl/api/user/me',
      ),
    );
    request.headers.addAll(Services.headersldJson);
    http.Response response = await HttpRequest.attemptHttpCall(request);
    if (response.statusCode == 200) {
      await userSession.onSignInCompleted(
        jsonDecode(
          response.body,
        ),
      );
    } else {
      Map<int, String> statusCodesPhrases = {
        404: 'user-not-found',
        500: 'internal-server-error',
      };
      throw BackendException(
        code: statusCodesPhrases[response.statusCode],
        statusCode: response.statusCode,
      );
    }
  }

  Future<void> post() async {
    var request = http.Request(
      'PATCH',
      Uri.parse(
        '$baseUrl/api/users',
      ),
    );
    request.headers.addAll({
      HttpHeaders.contentTypeHeader: 'application/merge-patch+json',
      ...Services.headerAcceptldJson,
    });
    request.body = json.encode({
      'isCompanyOrClient': true,
      'isVerified': false,
      'phoneNumber': userSession.phoneNumber,
      if (userSession.firstName.isNotNullOrEmpty)
        'firstName': userSession.firstName,
      if (userSession.lastName.isNotNullOrEmpty)
        'lastName': userSession.lastName,
      if (userSession.email.isNotNullOrEmpty) 'email': userSession.email,
      if (userSession.birthDate.isNotNullOrEmpty)
        'birthdate': userSession.birthDate,
      if (userSession.city.isNotNullOrEmpty) 'city': userSession.city,
      if (userSession.bio.isNotNullOrEmpty) 'bio': userSession.bio,
      if (userSession.streetAddress.isNotNullOrEmpty)
        'streetAddress': userSession.streetAddress,
      if (userSession.postalCode.isNotNullOrEmpty)
        'postalCode': userSession.postalCode,
      if (userSession.region.isNotNullOrEmpty) 'region': userSession.region,
      'country': userSession.country,
      if (userSession.companyName.isNotNullOrEmpty)
        'companyName': userSession.companyName,
      if (userSession.facebookUrl.isNotNullOrEmpty)
        'facebookUrl': userSession.facebookUrl,
      if (userSession.linkedinUrl.isNotNullOrEmpty)
        'linkedinUrl': userSession.linkedinUrl,
      if (userSession.twitterUrl.isNotNullOrEmpty)
        'twitterUrl': userSession.twitterUrl,
      if (userSession.uniqueRegisterNumber.isNotNullOrEmpty)
        'uniqueRegisterNumber': userSession.uniqueRegisterNumber,
      'preferenceList': userSession.preferences ?? [],
    });
    http.Response response = await HttpRequest.attemptHttpCall(request);
    if (response.statusCode == 200) {
      await userSession.onSignInCompleted(
        jsonDecode(
          response.body,
        ),
      );
    } else {
      Map<int, String> statusCodesPhrases = {
        400: 'Invalid input',
        422: 'Unprocessable entity',
        500: 'internal-server-error',
      };
      throw BackendException(
        code: statusCodesPhrases[response.statusCode],
        statusCode: response.statusCode,
      );
    }
  }
}
