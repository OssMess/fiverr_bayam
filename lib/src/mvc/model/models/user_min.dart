import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../extensions.dart';
import '../../../tools.dart';
import '../../controller/services.dart';
import '../enums.dart';
import 'user_session.dart';

/// this model represents user session
class UserMin with ChangeNotifier {
  String uid;
  String phoneNumber;
  ImageProvider<Object>? imageProfile;
  String? imageProfileUrl;
  List<ImageProvider<Object>>? imageCompany;
  List<String>? imageCompanyUrl;
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
  DateTime? lastSeenOnline;
  int? countLiked;
  ActionLikeType? actionLikeType;

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
    required this.lastSeenOnline,
    required this.countLiked,
    required this.actionLikeType,
  });

  factory UserMin.fromMap(Map<dynamic, dynamic> json) {
    return UserMin(
      uid: json['uuid'],
      phoneNumber: json['phoneNumber'],
      imageProfile: (json['imageProfile'] as String?).toImageProvider,
      imageProfileUrl: (json['imageProfile'] as String?),
      imageCompany: List.from(json['imageCompany'] ?? [])
          .map((e) => (e as String).toImageProvider!)
          .toList(),
      imageCompanyUrl: List.from(json['imageCompany'] ?? []),
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
      lastSeenOnline: DateTime.tryParse(json['lastSeenOnline'] ?? ''),
      countLiked: json['countLiked'],
      actionLikeType: (json['actionLikeType'] as String?).toActionLikeType,
    );
  }

  /// return `true` if user is of type `AccountType.person`
  bool get isPerson => accountType == AccountType.person;

  /// return `true` if user is of type `AccountType.company`
  bool get isCompany => accountType == AccountType.company;

  String get displayName => companyName ?? '$firstName $lastName';

  static UserMin fromResponse(String body) => UserMin.fromMap(jsonDecode(body));

  bool get isOnline =>
      lastSeenOnline != null &&
      DateTime.now().difference(lastSeenOnline!).inMinutes < 15;

  bool get isLiked => actionLikeType == ActionLikeType.like;

  String? elapsedOnline(BuildContext context) {
    if (lastSeenOnline == null) return null;
    int inMinutes = DateTime.now().difference(lastSeenOnline!).inMinutes;
    return inMinutes < 15
        ? '0'
        : DateTimeUtils.of(context).formatElapsed(lastSeenOnline!);
  }

  Future<void> likeCompany(
    BuildContext context,
    UserSession userSession,
  ) async {
    await Dialogs.of(context).runAsyncAction<(int, ActionLikeType?)>(
      future: () async {
        return await CompanyServices.of(userSession).like(this);
      },
      onComplete: (result) {
        countLiked = result?.$1;
        actionLikeType = result?.$2;
        notifyListeners();
      },
    );
  }

  Map<String, dynamic> get toMapInit => {
        'uid': uid,
        'phoneNumber': phoneNumber,
        'imageProfile': imageProfileUrl,
        'imageCompany': imageCompanyUrl,
        'firstName': firstName,
        'lastName': lastName,
        'companyName': companyName,
        'bio': bio,
        'birthDate': birthDate,
        'email': email,
        'facebookUrl': facebookUrl,
        'linkedinUrl': linkedinUrl,
        'twitterUrl': twitterUrl,
        'city': city,
        'country': country,
        'postalCode': postalCode,
        'region': region,
        'streetAddress': streetAddress,
        'isActive': isActive,
        'isVerified': isVerified,
        'countLiked': countLiked,
        'actionLikeType': actionLikeType,
      };
}
