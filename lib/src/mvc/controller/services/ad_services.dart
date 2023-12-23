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
      return response.toAdPost(userSession);
    } else {
      throw Functions.throwExceptionFromResponse(userSession, response);
    }
  }

  /// like post.
  Future<void> like(Ad ad) async {
    var request = http.Request(
      'POST',
      Uri.parse(
        '$baseUrl/api/post/like',
      ),
    );
    request.body = json.encode({
      'post': ad.uuid,
      'actionType': 'like',
    });
    request.headers.addAll(Services.headersldJson);
    http.Response response = await HttpRequest.attemptHttpCall(
      request,
      forceSkipRetries: true,
    );
    if (response.statusCode == 201) {
    } else {
      throw Functions.throwExceptionFromResponse(userSession, response);
    }
  }

  Future<AdComment> comment(Ad ad, String comment) async {
    var request = http.Request(
      'POST',
      Uri.parse(
        '$baseUrl/api/post/comment',
      ),
    );
    request.body = json.encode({
      'post': ad.uuid,
      'content': 'comment',
    });
    request.headers.addAll(Services.headersldJson);
    http.Response response = await HttpRequest.attemptHttpCall(
      request,
      forceSkipRetries: true,
    );
    if (response.statusCode == 201) {
      return response.toAdComment;
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
  Future<Ad> get(String id) async {
    var request = http.Request(
      'GET',
      Uri.parse(
        '$baseUrl/api/post/$id',
      ),
    );
    request.headers.addAll(
      Services.headerAcceptldJson,
    );
    http.Response response = await HttpRequest.attemptHttpCall(
      request,
      forceSkipRetries: true,
    );
    if (response.statusCode == 200) {
      return response.toAd(userSession);
    } else {
      throw Functions.throwExceptionFromResponse(userSession, response);
    }
  }

  Future<void> getAds({
    required int page,
    required bool refresh,
    required void Function(
      Set<Ad>, //result
      int, //totalPages
      int, // currentPage
      bool, // error,
      bool, // refresh,
    ) update,
  }) async {
    var request = http.Request(
      'GET',
      Uri.parse(
        '$baseUrl/api/user/post/timeline/?page=${page + 1}',
      ),
    );
    request.headers.addAll(
      Services.headerAcceptldJson,
    );
    http.Response response = await HttpRequest.attemptHttpCall(
      request,
      forceSkipRetries: true,
    );
    if (response.statusCode == 200) {
      Map<dynamic, dynamic> result = jsonDecode(response.body);
      update(
        List.from(result['hydra:member'])
            .map((json) => Ad.fromMap(json, userSession))
            .toSet(),
        result['hydra:totalItems'],
        page + 1,
        false,
        refresh,
      );
    } else {
      throw Functions.throwExceptionFromResponse(userSession, response);
    }
  }

  Future<void> getAdComments({
    required String adId,
    required int page,
    required bool refresh,
    required void Function(
      Set<AdComment>, //result
      int, //totalPages
      int, // currentPage
      bool, // error,
      bool, // refresh,
    ) update,
  }) async {
    var request = http.Request(
      'GET',
      Uri.parse(
        '$baseUrl/api/post/$adId/comment/?page=${page + 1}',
      ),
    );
    request.headers.addAll(
      Services.headerAcceptldJson,
    );
    http.Response response = await HttpRequest.attemptHttpCall(
      request,
      forceSkipRetries: true,
    );
    if (response.statusCode == 200) {
      Map<dynamic, dynamic> result = jsonDecode(response.body);
      update(
        List.from(result['hydra:member'])
            .map((json) => AdComment.fromMap(json))
            .toSet(),
        result['hydra:totalItems'],
        page + 1,
        false,
        refresh,
      );
    } else {
      throw Functions.throwExceptionFromResponse(userSession, response);
    }
  }
}
