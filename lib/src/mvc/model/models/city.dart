import 'dart:convert';

City jsonToCity(Map<String, dynamic> json) => City.fromMap(json);

class City {
  final int id;
  final String name;
  final String cityStateId;
  final String cityStateCode;
  final String cityStateName;
  final String cityCountryId;
  final String cityCountryCode;
  final String cityCountryName;
  final String latitude;
  final String longitude;
  // final String wikiDataId;
  // final String stateId;
  // final String stateCode;
  // final String stateName;
  // final String countryId;
  // final String countryCode;
  // final String countryName;

  City({
    required this.id,
    required this.name,
    required this.cityStateId,
    required this.cityStateCode,
    required this.cityStateName,
    required this.cityCountryId,
    required this.cityCountryCode,
    required this.cityCountryName,
    required this.latitude,
    required this.longitude,
    // required this.wikiDataId,
    // required this.stateId,
    // required this.stateCode,
    // required this.stateName,
    // required this.countryId,
    // required this.countryCode,
    // required this.countryName,
  });

  factory City.fromMap(Map<dynamic, dynamic> json) => City(
        id: json['id'],
        name: json['name'],
        cityStateId: json['state_id'],
        cityStateCode: json['state_code'],
        cityStateName: json['state_name'],
        cityCountryId: json['country_id'],
        cityCountryCode: json['country_code'],
        cityCountryName: json['country_name'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        // wikiDataId: json['wikiDataId'],
        // stateId: json['stateId'],
        // stateCode: json['stateCode'],
        // stateName: json['stateName'],
        // countryId: json['countryId'],
        // countryCode: json['countryCode'],
        // countryName: json['countryName'],
      );

  static City fromResponse(String body) => City.fromMap(jsonDecode(body));
}
