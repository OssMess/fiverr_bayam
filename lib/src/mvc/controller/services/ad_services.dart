import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../extensions.dart';
import '../../../tools.dart';
import '../../model/models.dart';
import '../services.dart';

class AdServices {
  static const String baseUrl = 'https://api.bayam.site';

  final UserSession userSession;

  AdServices(this.userSession);

  static AdServices of(UserSession userSession) {
    return AdServices(userSession);
  }

  /// Create new [ad].
  Future<Ad> post(Ad ad) async {
    var request = http.Request(
      'POST',
      Uri.parse(
        '$baseUrl/api/post',
      ),
    );
    List<String> imagesBase64 = [];
    if (ad.imagesFile.isNotEmpty) {
      for (var image in ad.imagesFile) {
        imagesBase64.add(await image.toFile.toBase64String());
      }
    }
    request.body = json.encode({
      ...ad.toMapInit,
      'images': imagesBase64,
    });
    request.headers.addAll(Services.headersldJson);
    http.Response response = await HttpRequest.attemptHttpCall(
      request,
      forceSkipRetries: true,
    );
    if (response.statusCode == 201) {
      return response.toAd;
    } else {
      throw Functions.throwExceptionFromResponse(userSession, response);
    }
  }

  Future<void> markAsVisited(Ad ad) async {
    var request = http.Request(
      'POST',
      Uri.parse(
        '$baseUrl/api/user/post/timeline/${ad.uuid}/read',
      ),
    );

    request.headers.addAll(Services.headerAcceptldJson);
    http.Response response = await HttpRequest.attemptHttpCall(
      request,
      forceSkipRetries: true,
    );
    if (response.statusCode != 201) {
      throw Functions.throwExceptionFromResponse(userSession, response);
    }
  }

  /// Get ad by [id].
  Future<void> get(String id) async {
    var request = http.Request(
      'GET',
      Uri.parse(
        '$baseUrl/api/post/$id',
      ),
    );
    http.Response response = await HttpRequest.attemptHttpCall(
      request,
      forceSkipRetries: true,
    );
    if (response.statusCode == 200) {
      return;
    } else {
      throw Functions.throwExceptionFromResponse(userSession, response);
    }
  }

  Future<void> like({
    required String userId,
    required String adId,
    required String actionType,
  }) async {
    var headers = {
      'Content-Type': 'application/Id+json',
    };
    var request = http.Request(
      'POST',
      Uri.parse(
        '$baseUrl/api/post/like',
      ),
    );
    request.body = json.encode({
      'user': userId,
      'post': adId,
      'actionType': actionType,
    });
    request.headers.addAll(headers);
    http.Response response = await HttpRequest.attemptHttpCall(
      request,
      forceSkipRetries: true,
    );
    if (response.statusCode != 201) {
      throw Functions.throwExceptionFromResponse(userSession, response);
    }
  }

  Future<void> comment({
    required String userId,
    required String adId,
    required String content,
  }) async {
    var headers = {
      'Content-Type': 'application/Id+json',
    };
    var request = http.Request(
      'POST',
      Uri.parse(
        '$baseUrl/api/post/comment',
      ),
    );
    request.body = json.encode({
      'user': userId,
      'post': adId,
      'content': content,
    });
    request.headers.addAll(headers);
    http.Response response = await HttpRequest.attemptHttpCall(
      request,
      forceSkipRetries: true,
    );
    if (response.statusCode != 201) {
      throw Functions.throwExceptionFromResponse(userSession, response);
    }
  }
}
