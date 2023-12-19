import 'dart:convert';

class ReverseGeocode {
  ReverseGeocode({
    required this.results,
    required this.status,
  });

  final List<ResultAddresses> results;
  final String status;

  factory ReverseGeocode.fromJson(Map<dynamic, dynamic> json) => ReverseGeocode(
        results: List<ResultAddresses>.from(
          json['results'].map(
            (x) => ResultAddresses.fromMap(x),
          ),
        ),
        status: json['status'],
      );

  Map<String, dynamic> toMap() => {
        'results': List<dynamic>.from(results.map((x) => x.toMap())),
        'status': status,
      };

  String get formattedAddress => results.first.formattedAddress;
}

class ResultAddresses {
  ResultAddresses({
    required this.formattedAddress,
  });

  final String formattedAddress;

  factory ResultAddresses.fromJson(String str) =>
      ResultAddresses.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResultAddresses.fromMap(Map<String, dynamic> json) => ResultAddresses(
        formattedAddress: json['formatted_address'],
      );

  Map<String, dynamic> toMap() => {
        'formatted_address': formattedAddress,
      };
}
