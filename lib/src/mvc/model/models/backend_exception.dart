import 'package:http/http.dart' as http;

class BackendException implements Exception {
  final String? code;
  final int statusCode;

  BackendException({
    required this.code,
    required this.statusCode,
  });

  factory BackendException.fromJson(Map<String, dynamic> json) {
    return BackendException(
      code: json['code'],
      statusCode: json['statusCode'],
    );
  }

  factory BackendException.fromResponse(http.StreamedResponse response) {
    return BackendException(
      code: response.reasonPhrase,
      statusCode: response.statusCode,
    );
  }
}
