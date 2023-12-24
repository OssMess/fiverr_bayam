import 'dart:convert';

Country jsonToCountry(Map<String, dynamic> json) => Country.fromMap(json);

class Country {
  final int id;
  final String name;
  final String iso3;
  final String iso2;
  final String countryNumericCode;
  final String countryPhoneCode;
  final String capital;
  final String currency;
  final String countryCurrencyName;
  final String countryCurrencySymbol;
  final String tld;
  final String native;
  final String region;
  final String countryRegionId;
  final String subregion;
  final String countrySubregionId;
  final String nationality;
  // final List<String> timezones;
  final String latitude;
  final String longitude;
  final String emoji;
  final String emojiU;
  final String numericCode;
  final String phoneCode;
  final String currencyName;
  final String currencySymbol;
  final String regionId;
  final String subregionId;

  Country({
    required this.id,
    required this.name,
    required this.iso3,
    required this.iso2,
    required this.countryNumericCode,
    required this.countryPhoneCode,
    required this.capital,
    required this.currency,
    required this.countryCurrencyName,
    required this.countryCurrencySymbol,
    required this.tld,
    required this.native,
    required this.region,
    required this.countryRegionId,
    required this.subregion,
    required this.countrySubregionId,
    required this.nationality,
    // required this.timezones,
    required this.latitude,
    required this.longitude,
    required this.emoji,
    required this.emojiU,
    required this.numericCode,
    required this.phoneCode,
    required this.currencyName,
    required this.currencySymbol,
    required this.regionId,
    required this.subregionId,
  });

  factory Country.fromMap(Map<dynamic, dynamic> json) => Country(
        id: json['id'],
        name: json['name'],
        iso3: json['iso3'],
        iso2: json['iso2'],
        countryNumericCode: json['numeric_code'],
        countryPhoneCode: json['phone_code'],
        capital: json['capital'],
        currency: json['currency'],
        countryCurrencyName: json['currency_name'],
        countryCurrencySymbol: json['currency_symbol'],
        tld: json['tld'],
        native: json['native'],
        region: json['region'],
        countryRegionId: json['region_id'],
        subregion: json['subregion'],
        countrySubregionId: json['subregion_id'],
        nationality: json['nationality'],
        // timezones: List<String>.from(json['timezones'].map((x) => x)),
        latitude: json['latitude'],
        longitude: json['longitude'],
        emoji: json['emoji'],
        emojiU: json['emojiU'],
        numericCode: json['numericCode'],
        phoneCode: json['phoneCode'],
        currencyName: json['currencyName'],
        currencySymbol: json['currencySymbol'],
        regionId: json['regionId'],
        subregionId: json['subregionId'],
      );

  static Country fromResponse(String body) => Country.fromMap(jsonDecode(body));
}
