import 'dart:convert';

import 'package:bayam/src/mvc/model/enums/ad_type.dart';
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
    );
    if (response.statusCode == 201) {
      return response.toAdPost(userSession);
    } else {
      throw Functions.throwExceptionFromResponse(userSession, response);
    }
  }

  Future<String> networkImageToBase64(String imageUrl) async {
    http.Response response = await http.get(Uri.parse(imageUrl));
    final bytes = response.bodyBytes;
    return base64Encode(bytes);
  }

  /// Update [ad].
  Future<Ad> patch(Ad ad) async {
    var request = http.Request(
      'PATCH',
      Uri.parse(
        '$baseUrl/api/posts/${ad.uuid}',
      ),
    );
    List<String> imagesBase64 = [];
    for (var imageUrl in ad.imagesUrl) {
      imagesBase64.add(await networkImageToBase64(imageUrl));
    }
    if (ad.imagesFile.isNotEmpty) {
      for (var image in ad.imagesFile) {
        imagesBase64.add(await image.toFile.toBase64String());
      }
    }
    request.body = json.encode({
      ...ad.toMapInit,
      'images': imagesBase64,
    });
    request.headers.addAll(Services.headerPatchldJson);
    http.Response response = await HttpRequest.attemptHttpCall(
      request,
    );
    if (response.statusCode == 200) {
      return response.toAdPost(userSession);
    } else {
      throw Functions.throwExceptionFromResponse(userSession, response);
    }
  }

  /// like post.
  Future<(int, bool)> like(Ad ad) async {
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
    );
    var body = jsonDecode(response.body);
    //FIXME
    if (response.statusCode != 201) {
      throw Functions.throwExceptionFromResponse(userSession, response);
    } else {
      return ((body['totalLikeNumber'] as int? ?? 0), true);
    }
  }

  /// unlike post.
  Future<(int, bool)> unlike(Ad ad) async {
    var request = http.Request(
      'POST',
      Uri.parse(
        '$baseUrl/api/post/like',
      ),
    );
    request.body = json.encode({
      'post': ad.uuid,
      'actionType': 'unlike',
    });
    request.headers.addAll(Services.headersldJson);
    http.Response response = await HttpRequest.attemptHttpCall(
      request,
    );
    var body = jsonDecode(response.body);
    //FIXME
    if (response.statusCode != 201) {
      throw Functions.throwExceptionFromResponse(userSession, response);
    } else {
      return ((body['totalLikeNumber'] as int? ?? 0), false);
    }
  }

  /// like post.
  Future<(int, bool)> reactions(Ad ad) async {
    var request = http.Request(
      'GET',
      Uri.parse(
        '$baseUrl/api/reactions/${ad.uuid}',
      ),
    );
    request.headers.addAll(Services.headerAcceptldJson);
    http.Response response = await HttpRequest.attemptHttpCall(
      request,
    );
    var body = jsonDecode(response.body);
    if (response.statusCode != 200) {
      throw Functions.throwExceptionFromResponse(userSession, response);
    } else {
      return (
        List.from(body['hydra:member']).length,
        List.from(body['hydra:member'])
            .where((element) => element['user']['uuid'] == userSession.uid)
            .isNotEmpty,
      );
    }
  }

  /// like post.
  Future<void> delete(Ad ad) async {
    var request = http.Request(
      'DELETE',
      Uri.parse(
        '$baseUrl/api/posts/${ad.uuid}',
      ),
    );

    request.headers.addAll(Services.headerAcceptldJson);
    http.Response response = await HttpRequest.attemptHttpCall(
      request,
    );
    if (response.statusCode == 204) {
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
    );
    if (response.statusCode == 201) {
      return response.toAdComment(userSession);
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
    request.body = json.encode({});
    request.headers.addAll(Services.headersldJson);
    http.Response response = await HttpRequest.attemptHttpCall(
      request,
    );
    if (response.statusCode != 201) {
      throw Functions.throwExceptionFromResponse(userSession, response);
    }
  }

  /// Get ad by [id].
  Future<Ad> getById(String id) async {
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
    );
    if (response.statusCode == 200) {
      return response.toAd(userSession);
    } else {
      throw Functions.throwExceptionFromResponse(userSession, response);
    }
  }

  Future<void> get({
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
    );
    if (response.statusCode == 200) {
      Map<dynamic, dynamic> result = jsonDecode(response.body);
      update(
        List.from(result['hydra:member'])
            .map((json) => Ad.fromMapGet(json, userSession))
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

  Future<void> getMy({
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
        '$baseUrl/api/post/?page=${page + 1}',
      ),
    );
    request.headers.addAll(
      Services.headerAcceptldJson,
    );
    http.Response response = await HttpRequest.attemptHttpCall(
      request,
    );
    if (response.statusCode == 200) {
      Map<dynamic, dynamic> result = jsonDecode(response.body);
      update(
        List.from(result['hydra:member'])
            .map((json) => Ad.fromMapPost(json, userSession))
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
    );
    if (response.statusCode == 200) {
      Map<dynamic, dynamic> result = jsonDecode(response.body);
      update(
        List.from(result['hydra:member'])
            .map((json) => AdComment.fromMap(
                  json,
                  userSession,
                ))
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

  Future<void> getSearch({
    required String search,
    required void Function(
      Set<Ad> result,
      bool error,
      bool refresh,
    ) update,
  }) async {
    var request = http.Request(
      'GET',
      Uri.parse(
        '$baseUrl/api/post/search?content=$search',
      ),
    );
    request.headers.addAll(
      Services.headerAcceptldJson,
    );
    http.Response response = await HttpRequest.attemptHttpCall(
      request,
    );
    if (response.statusCode == 200) {
      Map<dynamic, dynamic> result = jsonDecode(response.body);
      update(
        List.from(result['hydra:member'])
            .map((json) => Ad.fromMapSearch(
                  json,
                  userSession,
                ))
            .toSet(),
        false,
        true,
      );
    } else {
      update(
        {},
        true,
        true,
      );
      throw Functions.throwExceptionFromResponse(userSession, response);
    }
  }

  Future<void> filterAds({
    String? content,
    String? country,
    String? region,
    AdType? type,
    required int page,
    required bool refresh,
    required void Function(
      Set<Ad> result,
      int totalPages,
      int currentPage,
      bool error,
      bool refresh,
    ) update,
  }) async {
    String url = '$baseUrl/api/post/search/?page=${page + 1}';
    // if (content.isNotNullOrEmpty ||
    //     region.isNotNullOrEmpty ||
    //     country.isNotNullOrEmpty ||
    //     type != null) {
    //   url += '/?';
    // }
    {
      if (content.isNotNullOrEmpty) {
        url += 'content=$content';
      }
      if (country.isNotNullOrEmpty) {
        url += 'country=$country';
      }
      if (region.isNotNullOrEmpty) {
        url += 'region=$region';
      }
      if (type != null) {
        url += 'type=${type.key}';
      }
    }
    var request = http.Request(
      'GET',
      Uri.parse(url),
    );
    request.headers.addAll(
      Services.headerAcceptldJson,
    );
    http.Response response = await HttpRequest.attemptHttpCall(
      request,
    );
    if (response.statusCode == 200) {
      Map<dynamic, dynamic> result = jsonDecode(response.body);
      update(
        List.from(result['hydra:member'])
            .map((json) => Ad.fromMapPost(
                  json,
                  userSession,
                ))
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
