import 'package:hive/hive.dart';

import '../../model/models.dart';

class AuthStateChange {
  /// Hive box named `auth_state_change` used to store user session.
  static late Box _box;

  /// Current user session.
  static late UserSession _userSession;

  /// Initialises and opens `_box`, initiates initialisation of and returns a
  /// refrence to `_userSession` with last saved active session if it exists.
  static Future<UserSession> init() async {
    _box = await Hive.openBox('auth_state_change');
    if (_box.isEmpty) {
      // _box is empty, no saved session
      _userSession = UserSession.initUnauthenticated();
    } else {
      _userSession = UserSession.fromMap(
        Map<String, dynamic>.from(Map<String, dynamic>.from(_box.values.first)),
      );
    }
    return _userSession;
  }

  /// Save [userSession] to `_box` and `_userSession`.
  static Future<void> save(UserSession userSession) async {
    await clear();
    await _box.put(
      userSession.phoneNumber,
      userSession.toMap,
    );
    _userSession = userSession;
  }

  /// Clear Hive `_box` and reset `_userSession` to
  /// `userSession.initUnauthenticated()`
  static Future<UserSession> clear() async {
    await _box.clear();
    _userSession = UserSession.initUnauthenticated();
    return _userSession;
  }
}
