import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../extensions.dart';
import '../../../tools.dart';
import '../../controller/hives.dart';
import '../../controller/services.dart';
import '../enums.dart';
import '../list_models.dart';
import '../models.dart';
import '../models_ui.dart';

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
  List<ImageProvider<Object>>? imageCompany;
  List<String>? imageCompanyUrl;
  List<ImageProvider<Object>>? imageCompanyTax;
  List<String>? imageCompanyTaxUrl;
  AccountType? accountType;
  String? bio;
  List<String>? preferences;
  String? email;
  String? streetAddress;
  String? postalCode;
  String? region;
  String? country;
  String? city;
  List<Country>? countries;
  List<City>? cities;
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
  int? countLiked;

  DateTime? lastSeenOnline;

  //lists
  ListAds? listAds;
  ListCompaniesPopular? listCompaniesPopular;
  ListAdsMy? listAdsMy;
  ListAdsPromoted? listAdsPromoted;
  ListAdsPromotedMy? listAdsPromotedMy;
  ListDiscussions? listDiscussions;
  ListChatBotMessages? listChatBotMessages;

  //Shared
  ListCategories? listCategories;
  ListCategoriesSub? listCategoriesSub;
  ListCountries? listCountries;
  ListCities? listCities;
  ListPlans? listPlans;
  Bouncer bouncer = Bouncer.fromMinutes(15);

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
    required this.countLiked,
    required this.accountType,
    required this.bio,
    required this.birthDate,
    required this.country,
    required this.city,
    required this.countries,
    required this.cities,
    required this.email,
    required this.facebookUrl,
    required this.linkedinUrl,
    required this.postalCode,
    required this.preferences,
    required this.region,
    required this.uniqueRegisterNumber,
    required this.streetAddress,
    required this.twitterUrl,
    required this.lastSeenOnline,
    required bool? isActive,
    required bool? isVerified,
    this.listAdsPromoted,
    this.listAdsPromotedMy,
    this.listDiscussions,
    this.listAds,
    this.listCompaniesPopular,
    this.listAdsMy,
    this.listChatBotMessages,
    this.listCategories,
    this.listCategoriesSub,
    this.listCountries,
    this.listCities,
    this.listPlans,
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
      countLiked: null,
      accountType: null,
      bio: null,
      birthDate: null,
      country: null,
      city: null,
      countries: null,
      cities: null,
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
      listAdsPromoted: null,
      listAdsPromotedMy: null,
      listDiscussions: null,
      listAds: null,
      listCompaniesPopular: null,
      listAdsMy: null,
      listChatBotMessages: null,
      listCategories: null,
      listCategoriesSub: null,
      listCountries: null,
      listCities: null,
      listPlans: null,
      lastSeenOnline: null,
    );
    user.initLists();
    if (authState == AuthState.awaiting) {
      user.getAuthState();
    }
    return user;
  }

  void initLists() {
    listAds = ListAds(userSession: this);
    listAdsMy = ListAdsMy(userSession: this);
    listAdsPromoted = ListAdsPromoted(userSession: this);
    listAdsPromotedMy = ListAdsPromotedMy(userSession: this);
    listCategories = ListCategories(userSession: this);
    listCategoriesSub = ListCategoriesSub(userSession: this);
    listChatBotMessages = ListChatBotMessages(userSession: this);
    listCities = ListCities(userSession: this);
    listCompaniesPopular = ListCompaniesPopular(userSession: this);
    listCountries = ListCountries(userSession: this);
    listDiscussions = ListDiscussions(userSession: this);
    listPlans = ListPlans(userSession: this);
  }

  void resetLists() {
    listAds?.reset();
    listAdsMy?.reset();
    listAdsPromoted?.reset();
    listAdsPromotedMy?.reset();
    listChatBotMessages?.reset();
    listCompaniesPopular?.reset();
    listDiscussions?.reset();
  }

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
        countLiked: countLiked,
        accountType: accountType!,
        bio: bio,
        birthDate: birthDate,
        country: country,
        city: city,
        cities: cities ?? [],
        countries: countries ?? [],
        email: email,
        facebookUrl: facebookUrl,
        linkedinUrl: linkedinUrl,
        postalCode: postalCode,
        region: region,
        streetAddress: streetAddress,
        twitterUrl: twitterUrl,
        isActive: isActive,
        isVerified: isVerified,
        lastSeenOnline: lastSeenOnline,
        actionLikeType: null,
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
    country = user.country;
    city = user.city;
    countries = user.countries;
    cities = user.cities;
    email = user.email;
    facebookUrl = user.facebookUrl;
    linkedinUrl = user.linkedinUrl;
    postalCode = user.postalCode;
    preferences = user.preferences;
    region = user.region;
    uniqueRegisterNumber = user.uniqueRegisterNumber;
    streetAddress = user.streetAddress;
    lastSeenOnline = user.lastSeenOnline;
    _isActive = user._isActive;
    _isVerified = user._isVerified;
    notifyListeners();
  }

  void updateLastSeen() {
    UserServices.of(this).updateLastSeen();
    bouncer.run(UserServices.of(this).updateLastSeen);
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
    imageCompanyUrl = List<String>.from(json['imageCompany'] ?? []);
    imageCompany =
        imageCompanyUrl?.map((e) => CachedNetworkImageProvider(e)).toList();
    imageCompanyTaxUrl =
        List<String>.from(json['imageCompanyTax'] ?? []).toList();
    imageCompanyTax =
        (imageCompanyTaxUrl ?? []).map((e) => e.toImageProvider!).toList();
    firstName = json['firstName'];
    lastName = json['lastName'];
    companyName = json['companyName'];
    bio = json['bio'];
    birthDate = json['birthdate'];
    country = json['country'];
    city = json['city'];
    cities = List.from(json['cities'] ?? [])
        .map((e) => (e as Map<dynamic, dynamic>).toCity)
        .toList();
    countries = List.from(json['countries'] ?? [])
        .map((e) => (e as Map<dynamic, dynamic>).toCountry)
        .toList();
    email = json['email'];
    facebookUrl = json['facebookUrl'];
    linkedinUrl = json['linkedinUrl'];
    postalCode = json['postalCode'];
    preferences = List.from(json['preferenceList'] ?? [])
        .map((e) => (e['@id'] as String)
            .replaceAll('/api/preference_sub_categories/', ''))
        .toList();
    region = json['region'];
    uniqueRegisterNumber = json['uniqueRegisterNumber'];
    streetAddress = json['streetAddress'];
    twitterUrl = json['twitterUrl'];
    _isActive = json['isActive'];
    _isVerified = json['isVerified'];
    authState = AuthState.authenticated;
    lastSeenOnline = DateTime.tryParse(json['lastSeenOnline'] ?? '');
    countLiked = json['countLiked'];
    HiveMessages.init(this);
    notifyListeners();
  }

  Future<void> onSignout() async {
    bouncer.cancel();
    updateFromUserSession(UserSession.initUnauthenticated());
    resetLists();
    await HiveCookies.clear();
    await HiveTokens.clear();
    await HiveMessages.clear();
    await HiveSearchHistory.clear();
    notifyListeners();
  }

  Future<void> updateCountriesCities() async {
    bool update = false;
    if (listCities == null || listCountries == null) return;
    (Country?, City?)? data;
    if (await Permissions.getLocationEnabled() &&
        await Permissions.getLocationPermission()) {
      data = await GeoCodingLocation.getCountryCityFromCurrentLocation(
        this,
        'en',
      );
    } else {
      data = await GeoCodingLocation.getCountryCityFromIP(this, 'en');
    }
    if (data.$1 != null &&
        countries!.where((element) => element.id == data!.$1!.id).isEmpty) {
      countries!.add(data.$1!);
      update = true;
    }
    if (data.$2 != null &&
        cities!.where((element) => element.id == data!.$2!.id).isEmpty) {
      cities!.add(data.$2!);
      update = true;
    }
    try {
      if (update) {
        await UserServices.of(this).post();
      }
      // ignore: empty_catches
    } catch (e) {}
  }

  String get displayName => companyName ?? '$firstName $lastName';
}
