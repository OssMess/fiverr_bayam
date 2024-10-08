import 'dart:io';

export './services/ad_promoted_services.dart';
export './services/ad_services.dart';
export './services/auth_services.dart';
export './services/categories_services.dart';
export './services/categories_sub_services.dart';
export './services/chat_gpt_services.dart';
export './services/cities_services.dart';
export './services/company_services.dart';
export './services/countries_services.dart';
export './services/discussion_services.dart';
export './services/favorites_services.dart';
export './services/google_maps_api.dart';
export './services/http_request.dart';
export './services/message_services.dart';
export './services/other_services.dart';
export './services/plan_services.dart';
export './services/report_services.dart';
export './services/subscription_services.dart';
export './services/support_services.dart';
export './services/tag_services.dart';
export './services/user_services.dart';

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

  static Map<String, String> get headerPatchldJson => {
        HttpHeaders.contentTypeHeader: mergePatchJson,
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
