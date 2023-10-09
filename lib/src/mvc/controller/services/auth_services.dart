import 'dart:convert';

import 'package:bayam/src/extensions.dart';
import 'package:http/http.dart' as http;

import '../../model/models.dart';
import '../services.dart';

class AuthServices {
  static const String baseUrl = 'https://api.bayam.site';

  static Future<void> sendOTP(String phoneNumber) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request(
      'POST',
      Uri.parse(
        '$baseUrl/api/notify/sms/send',
      ),
    );
    request.body = json.encode({
      'phoneNumber': phoneNumber,
    });
    request.headers.addAll(headers);
    http.Response response = await HttpRequest.attemptHttpCall(request);
    if (response.statusCode == 201) {
      return;
    } else {
      Map<int, String> statusCodesPhrases = {
        400: 'Unauthorized',
        422: 'Unprocessable entity',
        500: 'internal-server-error',
      };
      throw BackendException(
        code: statusCodesPhrases[response.statusCode],
        statusCode: response.statusCode,
      );
    }
  }

  static Future<void> verifyOTP(
    UserSession userSession,
    String phoneNumber,
    String otp,
  ) async {
    var request = http.Request(
      'GET',
      Uri.parse(
        '$baseUrl/api/notify/$phoneNumber/verify/$otp',
      ),
    );
    http.Response response = await HttpRequest.attemptHttpCall(request);
    if (response.statusCode == 200) {
      await userSession.onSignInCompleted(
        jsonDecode(
          response.body,
        )['receiver'],
      );
    } else {
      Map<int, String> statusCodesPhrases = {
        404: 'Resource not found',
        500: 'internal-server-error',
      };
      throw BackendException(
        code: statusCodesPhrases[response.statusCode],
        statusCode: response.statusCode,
      );
    }
  }

  static Future<void> getUser(
    UserSession userSession,
  ) async {
    var request = http.Request(
      'GET',
      Uri.parse(
        '$baseUrl/api/user/me/${userSession.uid}',
      ),
    );
    http.Response response = await HttpRequest.attemptHttpCall(request);
    if (response.statusCode == 200) {
      await userSession.onSignInCompleted(
        jsonDecode(
          response.body,
        ),
      );
    } else {
      Map<int, String> statusCodesPhrases = {
        404: 'Resource not found',
        500: 'internal-server-error',
      };
      throw BackendException(
        code: statusCodesPhrases[response.statusCode],
        statusCode: response.statusCode,
      );
    }
  }

  static Future<void> postUser({
    required UserSession userSession,
  }) async {
    var headers = {
      'Content-Type': 'application/merge-patch+json',
    };
    var request = http.Request(
      'PATCH',
      Uri.parse(
        '$baseUrl/api/users',
      ),
    );
    request.body = json.encode({
      'isCompanyOrClient': true,
      'isVerified': false,
      'uuid': userSession.uid,
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
      if (userSession.registrationNumber.isNotNullOrEmpty)
        'uniqueRegisterNumber': userSession.registrationNumber,
      'preferenceList': userSession.preferences ?? [],
    });
    request.headers.addAll(headers);
    http.Response response = await HttpRequest.attemptHttpCall(request);
    if (response.statusCode == 200) {
      await userSession.onSignInCompleted(
        jsonDecode(
          response.body,
        ),
      );
      // await userSession.onSignUpCompleted();
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
