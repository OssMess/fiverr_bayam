import 'dart:convert';

IPLocation jsonToIPLocation(String str) =>
    IPLocation.fromJson(json.decode(str));

class IPLocation {
  final String status;
  final String country;
  final String countryCode;
  final String region;
  final String regionName;
  final String city;
  final String zip;
  final double lat;
  final double lon;
  final String timezone;
  final String isp;
  final String org;
  final String ipLocationAs;
  final String query;

  IPLocation({
    required this.status,
    required this.country,
    required this.countryCode,
    required this.region,
    required this.regionName,
    required this.city,
    required this.zip,
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.isp,
    required this.org,
    required this.ipLocationAs,
    required this.query,
  });

  factory IPLocation.fromJson(Map<String, dynamic> json) => IPLocation(
        status: json['status'],
        country: json['country'],
        countryCode: json['countryCode'],
        region: json['region'],
        regionName: json['regionName'],
        city: json['city'],
        zip: json['zip'],
        lat: json['lat']?.toDouble(),
        lon: json['lon']?.toDouble(),
        timezone: json['timezone'],
        isp: json['isp'],
        org: json['org'],
        ipLocationAs: json['as'],
        query: json['query'],
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'country': country,
        'countryCode': countryCode,
        'region': region,
        'regionName': regionName,
        'city': city,
        'zip': zip,
        'lat': lat,
        'lon': lon,
        'timezone': timezone,
        'isp': isp,
        'org': org,
        'as': ipLocationAs,
        'query': query,
      };
}
