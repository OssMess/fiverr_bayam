import 'dart:io';

export './services/ad_services.dart';
export './services/auth_services.dart';
export './services/discussion_services.dart';
export './services/message_services.dart';
export './services/http_request.dart';
export './services/other_services.dart';
export './services/categories_services.dart';
export './services/categories_sub_services.dart';
export './services/ad_promoted_services.dart';
export './services/tag_services.dart';
export './services/user_services.dart';
export './services/chat_gpt_services.dart';
export './services/google_maps_api.dart';

class Services {
  static String get json => 'application/json';
  static String get ldjson => 'application/ld+json';
  static String get mergePatchJson => 'application/merge-patch+json';

  static Map<String, String> get headerContentTypeJson => {
        HttpHeaders.contentTypeHeader: json,
      };

  static Map<String, String> get headerContentTypeldJson => {
        HttpHeaders.contentTypeHeader: ldjson,
      };

  static Map<String, String> get headerAcceptldJson => {
        HttpHeaders.acceptHeader: ldjson,
      };

  static Map<String, String> get headerAcceptJson => {
        HttpHeaders.acceptHeader: json,
      };

  static Map<String, String> get headersldJson => {
        HttpHeaders.contentTypeHeader: ldjson,
        HttpHeaders.acceptHeader: ldjson,
      };
}
