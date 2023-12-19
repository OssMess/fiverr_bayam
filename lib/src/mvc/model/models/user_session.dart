import 'package:flutter/material.dart';

import '../../../extensions.dart';
import '../../../tools.dart';
import '../../controller/hives.dart';
import '../../controller/services.dart';
import '../enums.dart';
import '../list_models.dart';
import '../models.dart';

/// this model represents user session
class UserSession with ChangeNotifier {
  /// user authentication sate
  AuthState authState;

  /// user Id
  String? uid;
  String? phoneNumber;
  ImageProvider<Object>? imageProfile;
  String? imageProfileUrl;
  List<ImageProvider<Object>>? imageUserIdentity;
  List<String>? imageUserIdentityUrl;
  ImageProvider<Object>? imageCompany;
  String? imageCompanyUrl;
  List<ImageProvider<Object>>? imageCompanyTax;
  List<String>? imageCompanyTaxUrl;
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

  //lists
  ListAdsPromoted? listAdsPromoted;
  ListAds? listAds;
  ListCategoriesSub? listCategoriesSub;
  ListCategories? listCategories;
  ListDiscussions? listDiscussions;
  ListChatBotMessages? listChatBotMessages;

  UserSession({
    required this.authState,
    required this.uid,
    required this.phoneNumber,
    required this.imageProfile,
    required this.imageProfileUrl,
    required this.imageUserIdentity,
    required this.imageUserIdentityUrl,
    required this.imageCompany,
    required this.imageCompanyUrl,
    required this.imageCompanyTax,
    required this.imageCompanyTaxUrl,
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
    this.listAds,
    this.listAdsPromoted,
    this.listCategories,
    this.listCategoriesSub,
    this.listDiscussions,
    this.listChatBotMessages,
  })  : _isVerified = isVerified,
        _isActive = isActive;

  /// creates an instance of `UserSession` where `authState` is set to `authState: AuthState.unauthenticated`.
  /// this is used to reset `UserSession` instance to a unauthenticated state.
  factory UserSession.initUnauthenticated() => UserSession._init(
        authState: AuthState.unauthenticated,
      );

  /// creates an instance of `UserSession` where `authState` is set to `authState: AuthState.authenticated`.
  factory UserSession.initAuthenticated() => UserSession._init(
        authState: AuthState.authenticated,
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
      imageProfile: null,
      imageProfileUrl: null,
      imageUserIdentity: null,
      imageUserIdentityUrl: null,
      imageCompany: null,
      imageCompanyUrl: null,
      imageCompanyTax: null,
      imageCompanyTaxUrl: null,
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
      listAds: null,
      listAdsPromoted: null,
      listCategories: null,
      listCategoriesSub: null,
      listDiscussions: null,
      listChatBotMessages: null,
    );
    // AuthStateChange.save(user);
    if (authState == AuthState.awaiting) {
      user.getAuthState();
    }
    return user;
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

  UserMin get toUserMin => UserMin(
        uid: uid!,
        phoneNumber: phoneNumber!,
        imageProfile: imageProfile,
        imageProfileUrl: imageProfileUrl,
        imageCompany: imageCompany,
        imageCompanyUrl: imageCompanyUrl,
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
        region: region,
        streetAddress: streetAddress,
        twitterUrl: twitterUrl,
        isActive: isActive,
        isVerified: isVerified,
      );

  Author get toAuthor => Author(
        uid: uid!,
        phoneNumber: phoneNumber!,
        photoUrl: null,
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
        await UserServices.of(this).post();
      },
      onComplete: (_) => setState(() {}),
    );
  }

  /// while the authState is `AuthState.awaiting`, initialize and retrieve last known user session from `AuthStateChange`,
  /// and clone it into `this`, and rebuild the widget tree to sync the changes.
  Future<void> getAuthState() async {
    var user = await HiveTokens.getAuthState();
    updateFromUserSession(user);
  }

  /// copy the attributes from [user] to `this` user session, and notify
  /// listeners to rebuild the widget tree and sync the changes
  void updateFromUserSession(UserSession user) {
    uid = user.uid;
    authState = user.authState;
    phoneNumber = user.phoneNumber;
    imageProfile = user.imageProfile;
    imageProfileUrl = user.imageProfileUrl;
    imageUserIdentity = user.imageUserIdentity;
    imageUserIdentityUrl = user.imageUserIdentityUrl;
    imageCompany = user.imageCompany;
    imageCompanyUrl = user.imageCompanyUrl;
    imageCompanyTax = user.imageCompanyTax;
    imageCompanyTaxUrl = user.imageCompanyTaxUrl;
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
    if (user.isAuthenticated) {
      listAds = ListAds(userSession: this);
      listAdsPromoted = ListAdsPromoted(userSession: this);
      listCategories = ListCategories(userSession: this);
      listCategoriesSub = ListCategoriesSub(userSession: this);
      listDiscussions = ListDiscussions(userSession: this);
      listChatBotMessages = ListChatBotMessages(userSession: this);
    } else {
      listAds = null;
      listAdsPromoted = null;
      listCategories = null;
      listCategoriesSub = null;
      listDiscussions = null;
      listChatBotMessages = null;
    }

    notifyListeners();
  }

  void onSignInCompleted(Map<String, dynamic> json) {
    uid = json['uuid'];
    phoneNumber = json['phoneNumber'];
    accountType = null;
    if (json['firstName'] is String) {
      accountType = AccountType.person;
    }
    if (json['companyName'] is String) {
      accountType = AccountType.company;
    }
    imageProfileUrl = json['imageProfile'];
    imageProfile = imageProfileUrl.toImageProvider;
    imageUserIdentityUrl =
        List<String>.from(json['imageUserIdentity'] ?? []).toList();
    imageUserIdentity =
        (imageUserIdentityUrl ?? []).map((e) => e.toImageProvider!).toList();
    imageCompanyUrl = List<String>.from(json['imageCompany'] ?? []).firstOrNull;
    imageCompany = imageCompanyUrl.toImageProvider;
    imageCompanyTaxUrl =
        List<String>.from(json['imageCompanyTax'] ?? []).toList();
    imageCompanyTax =
        (imageCompanyTaxUrl ?? []).map((e) => e.toImageProvider!).toList();
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
    preferences = json['preferences'] ??
        [
          '9e837e03-4cba-470f-8b5a-eda270a7fd39',
          'ca175607-9064-4f1f-8cc1-9a05f1fd2277',
          '64008c47-c19f-4afd-b1e0-d9b2a06dc3b4',
        ];
    region = json['region'];
    uniqueRegisterNumber = json['uniqueRegisterNumber'];
    streetAddress = json['streetAddress'];
    twitterUrl = json['twitterUrl'];
    _isActive = json['isActive'];
    _isVerified = json['isVerified'];
    authState = AuthState.authenticated;
    listDiscussions = ListDiscussions(userSession: this);
    listChatBotMessages = ListChatBotMessages(userSession: this);
    HiveMessages.init(this);
    notifyListeners();
  }

  Future<void> onSignout() async {
    updateFromUserSession(UserSession.initUnauthenticated());
    await HiveCookies.clear();
    await HiveTokens.clear();
    await HiveMessages.clear();
    notifyListeners();
  }

  String get displayName => companyName ?? '$firstName $lastName';
  ImageProvider<Object>? get image => imageProfile ?? imageCompany;
}
