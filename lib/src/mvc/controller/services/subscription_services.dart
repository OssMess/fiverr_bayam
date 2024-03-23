import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../../extensions.dart';
import '../../../tools.dart';
import '../../model/models.dart';
import '../services.dart';

class SubscriptionServices {
  static const String baseUrl = 'https://api.bayam.site';

  final UserSession userSession;

  SubscriptionServices(this.userSession);

  static SubscriptionServices of(UserSession userSession) {
    return SubscriptionServices(userSession);
  }

  Future<void> subscribe() async {
    await OneSignal.login(userSession.uid!);
    if (OneSignal.User.pushSubscription.token.isNullOrEmpty) return;
    var request = http.Request(
      'POST',
      Uri.parse(
        '$baseUrl/api/notification/subscribe',
      ),
    );
    request.body = json.encode({
      'enabled': true,
      'type': Platform.isAndroid ? 'android' : 'iOS',
      'device': Platform.isAndroid ? 'androidPUSH' : 'IOSPUSH',
      'subscriptionId': OneSignal.User.pushSubscription.token,
    });
    request.headers.addAll(Services.headersldJson);
    http.Response response = await HttpRequest.attemptHttpCall(
      request,
    );
    if (response.statusCode != 201) {
      throw Functions.throwExceptionFromResponse(userSession, response);
    }
  }

  Future<bool> get() async {
    await OneSignal.login(userSession.uid!);
    if (OneSignal.User.pushSubscription.token.isNullOrEmpty) return false;
    var request = http.Request(
      'GET',
      Uri.parse(
        '$baseUrl/api/notification/subscribe/${OneSignal.User.pushSubscription.token}',
      ),
    );
    request.headers.addAll(Services.headerAcceptldJson);
    http.Response response = await HttpRequest.attemptHttpCall(request);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['enabled'] ?? false;
    } else if (response.statusCode == 500) {
      return false;
    } else {
      throw Functions.throwExceptionFromResponse(userSession, response);
    }
  }

  Future<void> unsubscribe() async {
    await OneSignal.login(userSession.uid!);
    if (OneSignal.User.pushSubscription.token.isNullOrEmpty) return;
    var request = http.Request(
      'DELETE',
      Uri.parse(
        '$baseUrl/api/notification/subscribe/${OneSignal.User.pushSubscription.token}',
      ),
    );
    http.Response response = await HttpRequest.attemptHttpCall(request);
    if (response.statusCode != 204) {
      throw Functions.throwExceptionFromResponse(userSession, response);
    }
  }
}
