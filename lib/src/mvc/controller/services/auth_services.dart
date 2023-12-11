import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../tools.dart';
import '../../model/models.dart';
import '../hives.dart';
import '../services.dart';

class AuthServices {
  static const String baseUrl = 'https://api.bayam.site';

  final UserSession userSession;

  AuthServices(this.userSession);

  static AuthServices of(UserSession userSession) {
    return AuthServices(userSession);
  }

  /// Refresh current user token.
  Future<void> refresh() async {
    var request = http.Request(
      'POST',
      Uri.parse(
        '$baseUrl/api/login/token/refresh',
      ),
    );
    request.headers.addAll(Services.headersldJson);
    request.body = json.encode({
      ...HiveTokens.tokens,
    });
    http.Response response = await HttpRequest.attemptHttpCall(
      request,
      ignoreAuthorization: true,
    );
    if (response.statusCode == 201) {
      await userSession.onSignInCompleted(
        jsonDecode(response.body),
      );
    } else {
      throw Functions.throwExceptionFromResponse(userSession, response);
    }
  }

  /// Send OTP to [phoneNumber].
  Future<void> sendOTP(String phoneNumber) async {
    var request = http.Request(
      'POST',
      Uri.parse(
        '$baseUrl/api/notify/sms/send',
      ),
    );
    request.headers.addAll(Services.headersldJson);
    request.body = json.encode({
      'phoneNumber': phoneNumber,
    });
    http.Response response = await HttpRequest.attemptHttpCall(
      request,
      ignoreAuthorization: true,
    );
    if (response.statusCode == 201) {
      return;
    } else {
      Functions.throwExceptionFromResponse(userSession, response);
    }
  }

  /// Verify sent [otp] to [phoneNumber].
  Future<void> verifyOTP(
    String phoneNumber,
    String otp,
  ) async {
    var request = http.Request(
      'GET',
      Uri.parse(
        '$baseUrl/api/notify/$phoneNumber/verify/$otp',
      ),
    );
    request.headers.addAll(Services.headerAcceptldJson);
    http.Response response = await HttpRequest.attemptHttpCall(
      request,
      ignoreAuthorization: true,
    );
    if (response.statusCode == 200) {
      await userSession.onSignInCompleted(
        jsonDecode(response.body)['receiver'],
      );
    } else {
      throw Functions.throwExceptionFromResponse(userSession, response);
    }
  }
}
