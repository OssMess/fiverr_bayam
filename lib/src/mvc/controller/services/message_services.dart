import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../extensions.dart';
import '../../../tools.dart';
import '../../model/models.dart';
import '../services.dart';

class MessageServices {
  static const String baseUrl = 'https://api.bayam.site';

  final UserSession userSession;

  MessageServices(this.userSession);

  static MessageServices of(UserSession userSession) {
    return MessageServices(userSession);
  }

  /// Get list message in a discussion with [discussionId]
  Future<void> get({
    required String discussionId,
    required DateTime lastDate,
    required int page,
    required bool refresh,
    required void Function(
      Set<Message>, //result
      int, //totalPages
      int, // currentPage
      bool, // error,
      bool, // refresh,
    ) update,
  }) async {
    var request = http.Request(
      'GET',
      Uri.parse(
        '$baseUrl/api/message/me/receiver/?id=$discussionId&page=${page + 1}',
      ),
    );
    request.headers.addAll(Services.headerAcceptldJson);
    http.Response response = await HttpRequest.attemptHttpCall(request);
    if (response.statusCode == 200) {
      Map<dynamic, dynamic> result = jsonDecode(response.body);
      update(
        List.from(result['hydra:member'])
            .map((json) => Message.fromJson(json))
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

  /// Send a message with [receiverId], [discussionId],[message] and [images].
  Future<Message> post({
    required String receiverId,
    required String discussionId,
    required String message,
    required List<File> images,
  }) async {
    var request = http.Request(
      'POST',
      Uri.parse(
        '$baseUrl/api/message',
      ),
    );
    request.headers.addAll(Services.headersldJson);
    List<String> imagesBase64 = [];
    for (var image in images) {
      imagesBase64.add(await image.toBase64String());
    }
    request.body = json.encode({
      {
        'receiver': receiverId,
        'discussion': discussionId,
        'message': message,
        'images': imagesBase64,
      },
    });
    http.Response response = await HttpRequest.attemptHttpCall(request);
    if (response.statusCode == 201) {
      return jsonToMessage(
        jsonDecode(response.body),
      );
    } else {
      throw Functions.throwExceptionFromResponse(userSession, response);
    }
  }
}
