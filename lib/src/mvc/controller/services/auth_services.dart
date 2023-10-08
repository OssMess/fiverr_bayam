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

  static Future<String> verifyOTP(String phoneNumber, String otp) async {
    var request = http.Request(
      'GET',
      Uri.parse(
        '$baseUrl/api/notify/$phoneNumber/verify/$otp',
      ),
    );
    http.Response response = await HttpRequest.attemptHttpCall(request);
    if (response.statusCode == 200) {
      return jsonDecode(
        response.body,
      )['uuid'];
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
      //client
      'phoneNumber': userSession.phoneNumber ?? '',
      'firstName': userSession.firstName ?? '',
      'lastName': userSession.lastName ?? '',
      'isCompanyOrClient': true,
      //campany
      'email': userSession.email ?? '',
      'birthdate': userSession.birthDate ?? '',
      'city': userSession.city ?? '',
      'bio': userSession.bio ?? '',
      'streetAddress': userSession.streetAddress ?? '',
      'postalCode': userSession.postalCode ?? '',
      'region': userSession.region ?? '',
    });
    request.headers.addAll(headers);
    http.Response response = await HttpRequest.attemptHttpCall(request);
    if (response.statusCode == 201) {
      userSession.onRegisterClientCompleted();
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
