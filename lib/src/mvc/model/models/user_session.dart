import 'package:flutter/material.dart';

import '../../../extensions.dart';
import '../../../tools.dart';
import '../../controller/hives.dart';
import '../../controller/services.dart';
import '../enums.dart';
import 'author.dart';

/// this model represents user session
class UserSession with ChangeNotifier {
  /// user authentication sate
  AuthState authState;

  /// user Id
  String? uid;
  String? phoneNumber;
  //FIXME
  String? photoUrl;
  AccountType? accountType;
  String? bio;
  List<String>? preferences;
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
  bool? _isActive;
  bool? _isVerified;
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
    required bool? isActive,
    required bool? isVerified,
  })  : _isVerified = isVerified,
        _isActive = isActive;

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
      // uid:
      //     'c0688dfe-f914-45fb-817a-ffa6ff71f7cf', //'e400f468-7876-40ea-baba-148e06fb1140',
      // phoneNumber: '+237698305411', //'+237698305411',
      photoUrl: null,
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
      uniqueRegisterNumber: null,
      streetAddress: null,
      twitterUrl: null,
      isActive: null,
      isVerified: null,
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
      photoUrl: json['photoUrl'],
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
      uniqueRegisterNumber: json['uniqueRegisterNumber'],
      streetAddress: json['streetAddress'],
      twitterUrl: json['twitterUrl'],
      isActive: json['isActive'],
      isVerified: json['isVerified'],
    );
  }

  Map<dynamic, dynamic> get toAuthorMap => {
        'isCompanyOrClient': true,
        'isVerified': false,
        'uuid': uid,
        'phoneNumber': phoneNumber,
        if (firstName.isNotNullOrEmpty) 'firstName': firstName,
        if (lastName.isNotNullOrEmpty) 'lastName': lastName,
        if (email.isNotNullOrEmpty) 'email': email,
        if (birthDate.isNotNullOrEmpty) 'birthdate': birthDate,
        if (city.isNotNullOrEmpty) 'city': city,
        if (bio.isNotNullOrEmpty) 'bio': bio,
        if (streetAddress.isNotNullOrEmpty) 'streetAddress': streetAddress,
        if (postalCode.isNotNullOrEmpty) 'postalCode': postalCode,
        if (region.isNotNullOrEmpty) 'region': region,
        'country': country,
        if (companyName.isNotNullOrEmpty) 'companyName': companyName,
        if (facebookUrl.isNotNullOrEmpty) 'facebookUrl': facebookUrl,
        if (linkedinUrl.isNotNullOrEmpty) 'linkedinUrl': linkedinUrl,
        if (twitterUrl.isNotNullOrEmpty) 'twitterUrl': twitterUrl,
        if (uniqueRegisterNumber.isNotNullOrEmpty)
          'uniqueRegisterNumber': uniqueRegisterNumber,
        'preferenceList': preferences ?? [],
      };

  Author get toAuthor => Author(
        uid: uid!,
        phoneNumber: phoneNumber!,
        photoUrl: photoUrl,
        firstName: firstName,
        lastName: lastName,
        companyName: companyName,
        accountType: accountType!,
        bio: bio,
        birthDate: birthDate,
        city: city,
        country: country,
        email: email,
        facebookUrl: facebookUrl,
        linkedinUrl: linkedinUrl,
        postalCode: postalCode,
        preferences: preferences!,
        region: region,
        uniqueRegisterNumber: uniqueRegisterNumber,
        streetAddress: streetAddress,
        twitterUrl: twitterUrl,
        isActive: isActive,
        isVerified: isVerified,
      );

  /// return a `Map` of this instance
  Map<String, dynamic> get toMap => {
        'uid': uid,
        'phoneNumber': phoneNumber,
        'photoUrl': photoUrl,
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
        'uniqueRegisterNumber': uniqueRegisterNumber,
        'streetAddress': streetAddress,
        'twitterUrl': twitterUrl,
        'isActive': _isActive,
        'isVerified': _isVerified,
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

  bool get isActive => _isActive == true;

  bool get isVerified => _isVerified == true;

  Future<void> updateUserSession(
    BuildContext context,
    void Function(void Function()) setState,
  ) async {
    await Dialogs.of(context).runAsyncAction(
      future: () async {
        await UserServices.postUser(userSession: this);
      },
      onComplete: (_) => setState(() {}),
    );
  }

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
      UserServices.getUser(this);
    } else {
      authState = user.authState;
      phoneNumber = user.phoneNumber;
      photoUrl = user.photoUrl;
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
      uniqueRegisterNumber = user.uniqueRegisterNumber;
      streetAddress = user.streetAddress;
      _isActive = user._isActive;
      _isVerified = user._isVerified;

      notifyListeners();
    }
  }

  Future<void> onSignInCompleted(Map<String, dynamic> json) async {
    uid = json['uuid'];
    phoneNumber = json['phoneNumber'];
    accountType = null;
    if (json['firstName'] is String) {
      accountType = AccountType.person;
      photoUrl = json['photoUrl'];
      //  ??
      //     'https://images.squarespace-cdn.com/content/v1/51ef4493e4b0561c90fa76d6/1667315513383-NIYMELXNAZDL63LEAGAH/20210210_SLP0397-Edit2.jpg?format=1000w';
    }
    if (json['companyName'] is String) {
      accountType = AccountType.company;
      photoUrl = json['photoUrl'];
      //  ??
      //     'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDLL2FyAeYaShg5h1YrW3gEyDHDCUb5o2_lw&usqp=CAU';
    }
    firstName = json['firstName'];
    lastName = json['lastName'];
    companyName = json['companyName'];
    bio = json['bio'];
    birthDate = json['birthdate'];
    city = json['city'];
    country = json['country'];
    email = json['email'];
    facebookUrl = json['facebookUrl'];
    linkedinUrl = json['linkedinUrl'];
    postalCode = json['postalCode'];
    preferences = json['preferences'];
    region = json['region'];
    uniqueRegisterNumber = json['uniqueRegisterNumber'];
    streetAddress = json['streetAddress'];
    twitterUrl = json['twitterUrl'];
    _isActive = json['isActive'];
    _isVerified = json['isVerified'];
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
