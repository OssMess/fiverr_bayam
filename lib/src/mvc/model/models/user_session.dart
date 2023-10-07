import 'package:flutter/material.dart';

import '../../../extensions.dart';
import '../../controller/hives.dart';
import '../enums.dart';

/// this model represents user session
class UserSession with ChangeNotifier {
  /// user authentication sate
  AuthState authState;

  /// user Id
  int? uid;
  String? phoneNumber;
  String? firstName;
  String? lastName;
  AccountType? accountType;

  UserSession({
    required this.authState,
    required this.uid,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.accountType,
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
      firstName: null,
      lastName: null,
      accountType: null,
    );
    if (authState == AuthState.awaiting) {
      user.getAuthState();
    }
    return user;
  }

  factory UserSession.fromMap(Map<String, dynamic> json) {
    var uid = json['uid'];
    return UserSession(
      authState: AuthState.authenticated,
      uid: uid,
      phoneNumber: json['phoneNumber'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      accountType: (json['accountType'] as String?)?.toAccountType,
    );
  }

  /// return a `Map` of this instance
  Map<String, dynamic> get toMap => {
        'uid': uid,
        'phoneNumber': phoneNumber,
        'firstName': firstName,
        'lastName': lastName,
        'accountType': accountType?.key,
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
      isAuthenticated && firstName.isNullOrEmpty;

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
    authState = user.authState;
    uid = user.uid;
    phoneNumber = user.phoneNumber;
    firstName = user.firstName;
    lastName = user.lastName;
    accountType = user.accountType;
    notifyListeners();
  }

  ///Once the call for `/api/client/mobile/register` endpoint finishes with
  ///statusCode `200`, update user session with [uid].
  void onRegisterCompleted({
    required int uid,
    required AccountType accountType,
    required String firstName,
    required String lastName,
  }) async {
    this.uid = uid;
    this.accountType = accountType;
    this.firstName = firstName;
    this.lastName = lastName;
    authState = AuthState.authenticated;
    await AuthStateChange.save(this);
    // updateFromMap(
    //   await APIClient.of(this).getAccountDetails(),
    // );
    notifyListeners();
  }

  ///Once the call for `/api/client/mobile/confirm/[user.uid]` endpoint finishes
  ///with statusCode `200`, update user session with [uid] and also save user
  ///session to hive box `auth_state_change`.
  Future<void> onSignInCompleted({
    required String phoneNumber,
  }) async {
    this.phoneNumber = phoneNumber;
    authState = AuthState.authenticated;
    await AuthStateChange.save(this);
    notifyListeners();
  }

  /// on signout, reset all attributes related to current user session, and notify
  /// listeners to rebuild the widget tree.
  Future<void> onSignout() async {
    updateFromUserSession(
      await AuthStateChange.clear(),
    );
    await Cookies.clear();
    notifyListeners();
  }
}
