import 'package:flutter/material.dart';

import '../enums.dart';

class Author with ChangeNotifier {
  String uid;
  String phoneNumber;
  String? photoUrl;
  AccountType accountType;
  String? bio;
  List<String> preferences;
  String? email;
  String? city;
  String? streetAddress;
  String? postalCode;
  String? region;
  String? country;
  String? uniqueRegisterNumber;
  String? facebookUrl;
  String? linkedinUrl;
  String? twitterUrl;
  bool isActive;
  bool isVerified;
  //user
  String? firstName;
  String? lastName;
  String? birthDate;
  //company
  String? companyName;

  Author({
    required this.uid,
    required this.phoneNumber,
    required this.photoUrl,
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
    required this.preferences,
    required this.region,
    required this.uniqueRegisterNumber,
    required this.streetAddress,
    required this.twitterUrl,
    required this.isActive,
    required this.isVerified,
  });

  factory Author.fromMap(Map<dynamic, dynamic> json) {
    return Author(
      uid: json['uid'],
      phoneNumber: json['phoneNumber'],
      photoUrl: json['photoUrl'],
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
      preferences: json['preferences'],
      region: json['region'],
      uniqueRegisterNumber: json['uniqueRegisterNumber'],
      streetAddress: json['streetAddress'],
      twitterUrl: json['twitterUrl'],
      isActive: json['isActive'],
      isVerified: json['isVerified'],
    );
  }

  /// return `true` if user is of type `AccountType.person`
  bool get isPerson => accountType == AccountType.person;

  /// return `true` if user is of type `AccountType.company`
  bool get isCompany => accountType == AccountType.company;

  String get fullName => companyName ?? '$firstName $lastName';
}
