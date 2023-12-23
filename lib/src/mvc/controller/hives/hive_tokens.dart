import 'dart:convert';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../../model/models/user_session.dart';
import '../services.dart';

class HiveTokens {
  /// Hive box named `tokens` used to store token and refresh token
  static late Box _box;

  /// a set of currently saved tokens..
  // ignore: unused_field
  static Map<String, dynamic> _set = {};

  /// Initialises and opens `_box`, load all saved tokens in `_box` to `_set` for quick access.
  static Future<void> init() async {
    _box = await Hive.openBox('tokens');
    if (_box.isNotEmpty) {
      _set = Map<String, dynamic>.from(_box.values.first);
    }
  }

  /// Save [json] to `_box`.
  static Future<void> save(Map<String, dynamic> json) async {
    await clear();
    for (var key in json.keys) {
      _set[key] = json[key];
    }
    await _box.put(
      'tokens',
      _set,
    );
  }

  /// Clear Hive `_box`
  static Future<void> clear() async {
    await _box.clear();
    _set.clear();
  }

  static Map<String, dynamic> get tokens => _set;

  static Map<String, String> get authorization => {
        if (_set['token'] != null)
          HttpHeaders.authorizationHeader: 'Bearer ${_set['token']}',
      };

  /// Update saved tokens to `_box` and `_set` using http [response], to save or
  /// refresh user session.
  static Future<void> update(http.Response response) async {
    if (response.statusCode >= 300) return;
    try {
      Map<String, dynamic> mapTokens = {};
      for (var entry in jsonDecode(response.body).entries.where(
          (element) => ['token', 'refreshToken'].contains(element.key))) {
        mapTokens[entry.key] = entry.value;
      }
      if (mapTokens.isNotEmpty) {
        await save(mapTokens);
      }
      // ignore: empty_catches
    } catch (e) {}
  }

  ///return saved user session.
  static Future<UserSession> getAuthState() async {
    try {
      late UserSession userSession;
      if (_set.isEmpty) {
        userSession = UserSession.initUnauthenticated();
      } else {
        userSession = UserSession.initAuthenticated();
      }
      if (userSession.isAuthenticated) {
        await AuthServices.of(userSession).refresh();
      }
      return userSession;
    } catch (e) {
      return UserSession.initUnauthenticated();
    }
  }
}
