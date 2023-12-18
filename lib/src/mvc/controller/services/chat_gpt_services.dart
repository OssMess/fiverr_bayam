import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../model/models.dart';

class ChatGPTServices {
  static const String baseUrl = 'https://api.openai.com/v1/chat/completions';

  static Future<Message> sendMessage({
    required String message,
  }) async {
    var request = http.Request(
      'POST',
      Uri.parse(
        'https://api.openai.com/v1/chat/completions',
      ),
    );
    request.headers.addAll({
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader:
          'Bearer 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',
    });
    var body = {
      'model': 'gpt-3.5-turbo',
      'messages': [
        {
          'role': 'user',
          'content': message,
        },
      ],
    };
    request.body = json.encode(body);
    http.StreamedResponse streamedResponse = await request.send();
    if (streamedResponse.statusCode == 200) {
      http.Response response = await http.Response.fromStream(streamedResponse);
      var body = jsonDecode(response.body);
      return Message.initChatBotMessage(
        false,
        List.from(body['choices'])[0]['message']['content'],
      );
    } else {
      throw Exception(streamedResponse);
    }
  }
}
// {
//     "id": "chatcmpl-8XBnZxiqBBIDQPOWZ1mB1PvbIoYx2",
//     "object": "chat.completion",
//     "created": 1702920869,
//     "model": "gpt-3.5-turbo-0613",
//     "choices": [
//         {
//             "index": 0,
//             "message": {
//                 "role": "assistant",
//                 "content": "The OpenAI mission is to ensure that artificial general intelligence (AGI) benefits all of humanity. AGI refers to highly autonomous systems that outperform humans in most economically valuable work. OpenAI is committed to developing and distributing AGI in a manner that is safe, beneficial, and aligned with human values. Their core principles include broadly distributing benefits, long-term safety, technical leadership, and cooperative orientation. They aim to actively cooperate with other institutions and work towards creating a global community to address the challenges posed by AGI."
//             },
//             "logprobs": null,
//             "finish_reason": "stop"
//         }
//     ],
//     "usage": {
//         "prompt_tokens": 14,
//         "completion_tokens": 105,
//         "total_tokens": 119
//     },
//     "system_fingerprint": null
// }