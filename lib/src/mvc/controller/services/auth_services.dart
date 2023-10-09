import 'dart:convert';

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

  static Future<void> postUserClient({
    required UserSession userSession,
  }) async {
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
      'phoneNumber': userSession.phoneNumber ?? '',
      'firstName': userSession.firstName ?? '',
      'lastName': userSession.lastName ?? '',
      'isCompanyOrClient': true,
      'email': userSession.email ?? '',
      'birthdate': userSession.birthDate ?? '',
      'city': userSession.city ?? '',
      'bio': userSession.bio ?? '',
      'streetAddress': userSession.streetAddress ?? '',
      'postalCode': userSession.postalCode ?? '',
      'region': userSession.region ?? '',
      'country': userSession.country,
      'companyName': userSession.companyName ?? '',
      'uuid': userSession.uid,
      'facebookUrl': userSession.facebookUrl ?? '',
      'linkedinUrl': userSession.linkedinUrl ?? '',
      'twitterUrl': userSession.twitterUrl ?? '',
      'uniqueRegisterNumber': userSession.registrationNumber ?? '',
      'preferenceList': userSession.preferences ?? [],
      'isVerified': false,
    });
    request.headers.addAll(headers);
    http.Response response = await HttpRequest.attemptHttpCall(request);
    if (response.statusCode == 201) {
      await userSession.onSignUpCompleted();
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

  static Future<void> postUserCompany({
    required UserSession userSession,
  }) async {
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
      'phoneNumber': userSession.phoneNumber ?? '',
      'firstName': userSession.firstName ?? '',
      'lastName': userSession.lastName ?? '',
      'isCompanyOrClient': true,
      'email': userSession.email ?? '',
      'birthdate': userSession.birthDate ?? '',
      'city': userSession.city ?? '',
      'bio': userSession.bio ?? '',
      'streetAddress': userSession.streetAddress ?? '',
      'postalCode': userSession.postalCode ?? '',
      'region': userSession.region ?? '',
      'country': userSession.country,
      'companyName': userSession.companyName ?? '',
      'uuid': userSession.uid,
      'facebookUrl': userSession.facebookUrl ?? '',
      'linkedinUrl': userSession.linkedinUrl ?? '',
      'twitterUrl': userSession.twitterUrl ?? '',
      'uniqueRegisterNumber': userSession.registrationNumber ?? '',
      'preferenceList': userSession.preferences ?? [],
      'isVerified': false,
    });
    request.headers.addAll(headers);
    http.Response response = await HttpRequest.attemptHttpCall(request);
    if (response.statusCode == 201) {
      await userSession.onSignUpCompleted();
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
