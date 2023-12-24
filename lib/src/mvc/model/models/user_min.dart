import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../extensions.dart';
import '../enums.dart';

/// this model represents user session
class UserMin with ChangeNotifier {
  String uid;
  String phoneNumber;
  ImageProvider<Object>? imageProfile;
  String? imageProfileUrl;
  ImageProvider<Object>? imageCompany;
  String? imageCompanyUrl;
  AccountType accountType;
  String? email;
  String? city;
  String? streetAddress;
  String? postalCode;
  String? region;
  String? country;
  bool isActive;
  bool isVerified;
  String? firstName;
  String? lastName;
  String? birthDate;
  String? companyName;

  String? bio;
  String? facebookUrl;
  String? linkedinUrl;
  String? twitterUrl;

  UserMin({
    required this.uid,
    required this.phoneNumber,
    required this.imageProfile,
    required this.imageProfileUrl,
    required this.imageCompany,
    required this.imageCompanyUrl,
    required this.firstName,
    required this.lastName,
    required this.companyName,
    required this.accountType,
    required this.bio,
    required this.birthDate,
    required this.city,
    required this.country,
    required this.email,
    required this.facebookUrl,
    required this.linkedinUrl,
    required this.postalCode,
    required this.region,
    required this.streetAddress,
    required this.twitterUrl,
    required this.isActive,
    required this.isVerified,
  });

  factory UserMin.fromMap(Map<dynamic, dynamic> json) {
    return UserMin(
      uid: json['uuid'],
      phoneNumber: json['phoneNumber'],
      imageProfile: (json['imageProfile'] as String?).toImageProvider,
      imageProfileUrl: (json['imageProfile'] as String?),
      imageCompany: List.from(json['imageCompany'] ?? [])
          .map((e) => (e as String).toImageProvider!)
          .firstOrNull,
      imageCompanyUrl: List.from(json['imageCompany'] ?? []).firstOrNull,
      firstName: json['firstName'],
      lastName: json['lastName'],
      companyName: json['companyName'],
      accountType: json['companyName'] != null
          ? AccountType.company
          : AccountType.person,
      bio: json['bio'],
      birthDate: json['birthDate'],
      city: json['city'],
      country: json['country'],
      email: json['email'],
      facebookUrl: json['facebookUrl'],
      linkedinUrl: json['linkedinUrl'],
      postalCode: json['postalCode'],
      region: json['region'],
      streetAddress: json['streetAddress'],
      twitterUrl: json['twitterUrl'],
      isActive: json['isActive'] ?? false,
      isVerified: json['isVerified'],
    );
  }

  /// return `true` if user is of type `AccountType.person`
  bool get isPerson => accountType == AccountType.person;

  /// return `true` if user is of type `AccountType.company`
  bool get isCompany => accountType == AccountType.company;

  String get displayName => companyName ?? '$firstName $lastName';

  ImageProvider<Object>? get image => imageProfile ?? imageCompany;

  String? get imageUrl => imageProfileUrl ?? imageCompanyUrl;

  static UserMin fromResponse(String body) => UserMin.fromMap(jsonDecode(body));
}
