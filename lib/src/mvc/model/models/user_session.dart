import 'package:flutter/material.dart';

import '../../../extensions.dart';
import '../../controller/hives.dart';
import '../../controller/services.dart';
import '../enums.dart';

/// this model represents user session
class UserSession with ChangeNotifier {
  /// user authentication sate
  AuthState authState;

  /// user Id
  String? uid;
  String? phoneNumber;
  AccountType? accountType;
  String? bio;
  List<String>? preferences;
  String? email;
  String? city;
  String? streetAddress;
  String? postalCode;
  String? region;
  String? country;
  String? uniqueRegistrationNumber;
  String? registrationNumber;
  String? facebookUrl;
  String? linkedinUrl;
  String? twitterUrl;
  //user
  String? firstName;
  String? lastName;
  String? birthDate;
  //company
  String? companyName;

  UserSession({
    required this.authState,
    required this.uid,
    required this.phoneNumber,
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
    required this.registrationNumber,
    required this.streetAddress,
    required this.twitterUrl,
    required this.uniqueRegistrationNumber,
  });

  /// creates an instance of `UserSession` where `authState` is set to `authState: AuthState.unauthenticated`.
  /// this is used to reset `UserSession` instance to a unauthenticated state.
  factory UserSession.initUnauthenticated() => UserSession._init(
        authState: AuthState.unauthenticated,
      );

  /// creates an instance of `UserSession` where `authState` is set to `authState: AuthState.awaiting`,
  /// this will make the `UserSession` instance call `AuthStateChange` Hive to retrieve last known user session if it exists.
  factory UserSession.initAwaiting() => UserSession._init(
        authState: AuthState.awaiting,
      );

  /// creates an instance of `UserSession` where `authState` is set to [authState].
  factory UserSession._init({
    required AuthState authState,
  }) {
    var user = UserSession(
      authState: authState,
      uid: null,
      phoneNumber: null,
      // authState: AuthState.authenticated,
      // uid: 'e400f468-7876-40ea-baba-148e06fb1140',
      // phoneNumber: '+237698305411',
      firstName: null,
      lastName: null,
      companyName: null,
      accountType: null,
      bio: null,
      birthDate: null,
      city: null,
      country: null,
      email: null,
      facebookUrl: null,
      linkedinUrl: null,
      postalCode: null,
      preferences: null,
      region: null,
      registrationNumber: null,
      streetAddress: null,
      twitterUrl: null,
      uniqueRegistrationNumber: null,
    );
    // AuthStateChange.save(user);
    if (authState == AuthState.awaiting) {
      user.getAuthState();
    }
    return user;
  }

  factory UserSession.fromMap(Map<String, dynamic> json) {
    return UserSession(
      authState: AuthState.authenticated,
      uid: json['uid'],
      phoneNumber: json['phoneNumber'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      companyName: json['companyName'],
      accountType: (json['accountType'] as String?)?.toAccountType,
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
      registrationNumber: json['registrationNumber'],
      streetAddress: json['streetAddress'],
      twitterUrl: json['twitterUrl'],
      uniqueRegistrationNumber: json['uniqueRegistrationNumber'],
    );
  }

  /// return a `Map` of this instance
  Map<String, dynamic> get toMap => {
        'uid': uid,
        'phoneNumber': phoneNumber,
        'firstName': firstName,
        'lastName': lastName,
        'companyName': companyName,
        'accountType': accountType?.key,
        'preferences': preferences,
        'bio': bio,
        'birthDate': birthDate,
        'city': city,
        'country': country,
        'email': email,
        'facebookUrl': facebookUrl,
        'linkedinUrl': linkedinUrl,
        'postalCode': postalCode,
        'region': region,
        'registrationNumber': registrationNumber,
        'streetAddress': streetAddress,
        'twitterUrl': twitterUrl,
        'uniqueRegistrationNumber': uniqueRegistrationNumber,
      };

  /// return true if awaiting for user sessions
  bool get isAwaitingAuth => authState == AuthState.awaiting;

  /// return true if user is signed in
  bool get isAuthenticated => authState == AuthState.authenticated;

  /// return true if user is signed out
  bool get isUnAuthenticated => authState == AuthState.unauthenticated;

  /// return `true` if user session is not complete. This indicates that it is required
  /// to call a route toretrieve current user profile.
  bool get requiredInitAccountDetails => isAuthenticated && false;

  /// return `true` if user account requires completion
  bool get requireCompleteRegistration =>
      isAuthenticated && firstName.isNullOrEmpty && companyName.isNullOrEmpty;

  /// return `true` if user is of type `AccountType.person`
  bool get isPerson => accountType == AccountType.person;

  /// return `true` if user is of type `AccountType.company`
  bool get isCompany => accountType == AccountType.company;

  /// while the authState is `AuthState.awaiting`, initialize and retrieve last known user session from `AuthStateChange`,
  /// and clone it into `this`, and rebuild the widget tree to sync the changes.
  Future<void> getAuthState() async {
    var user = await AuthStateChange.init();
    updateFromUserSession(user);
  }

  /// copy the attributes from [user] to `this` user session, and notify
  /// listeners to rebuild the widget tree and sync the changes
  void updateFromUserSession(UserSession user) {
    uid = user.uid;
    if (uid.isNotNullOrEmpty) {
      AuthServices.getUser(this);
    } else {
      authState = user.authState;
      phoneNumber = user.phoneNumber;
      firstName = user.firstName;
      lastName = user.lastName;
      companyName = user.companyName;
      accountType = user.accountType;
      bio = user.bio;
      birthDate = user.birthDate;
      city = user.city;
      country = user.country;
      email = user.email;
      facebookUrl = user.facebookUrl;
      linkedinUrl = user.linkedinUrl;
      postalCode = user.postalCode;
      preferences = user.preferences;
      region = user.region;
      registrationNumber = user.registrationNumber;
      streetAddress = user.streetAddress;
      twitterUrl = user.facebookUrl;
      uniqueRegistrationNumber = user.uniqueRegistrationNumber;

      notifyListeners();
    }
  }

  // Future<void> onSignUpCompleted() async {
  //   authState = AuthState.authenticated;
  //   await AuthStateChange.save(this);
  //   notifyListeners();
  // }

  Future<void> onSignInCompleted(Map<String, dynamic> json) async {
    uid = json['uuid'];
    phoneNumber = json['phoneNumber'];
    accountType = null;
    if (json['firstName'] is String) {
      accountType = AccountType.person;
    }
    if (json['companyName'] is String) {
      accountType = AccountType.company;
    }
    firstName = json['firstName'];
    lastName = json['lastName'];
    companyName = json['companyName'];
    bio = json['bio'];
    birthDate = json['birthDate'];
    city = json['city'];
    country = json['country'];
    email = json['email'];
    facebookUrl = json['facebookUrl'];
    linkedinUrl = json['linkedinUrl'];
    postalCode = json['postalCode'];
    preferences = json['preferences'];
    region = json['region'];
    registrationNumber = json['registrationNumber'];
    streetAddress = json['streetAddress'];
    twitterUrl = json['facebookUrl'];
    uniqueRegistrationNumber = json['uniqueRegistrationNumber'];
    authState = AuthState.authenticated;
    await AuthStateChange.save(this);
    notifyListeners();
  }

  Future<void> onSignout() async {
    updateFromUserSession(
      await AuthStateChange.clear(),
    );
    await Cookies.clear();
    notifyListeners();
  }
}
