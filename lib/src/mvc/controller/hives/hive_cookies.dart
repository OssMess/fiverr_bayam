import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:sweet_cookie_jar/sweet_cookie_jar.dart';

import '../../../extensions.dart';

class HiveCookies {
  /// Hive box named `temporary_reset_token` used to store cookies
  static late Box _box;

  /// a set of currently saved cookies. Added to `cookie` header in `HTTP requests`.
  static final Set<Cookie> _set = {};

  /// Initialises and opens `_box`, load all saved cookies in `_box` to `_set` for quick access, and finally delete `temporary_reset_token` cookie from `_box` and `_set` if any is saved.
  static Future<void> init() async {
    _box = await Hive.openBox('cookies');
    _set.addAll(
      _box.values.map(
        (string) => Cookie.fromSetCookieValue(string),
      ),
    );
    await HiveCookies.deleteById('temporary_reset_token');
  }

  /// Save [cookie] to `_box` and also add it to `_set`.
  static Future<void> save(Cookie cookie) async {
    await HiveCookies.deleteById(cookie.name);
    if (cookie.value.isEmpty) return;
    await _box.put(
      cookie.name,
      cookie.toString(),
    );
    _set.insertWhere(
      cookie,
      test: (value) => value.name == cookie.name,
      overwrite: true,
    );
  }

  /// Delete and clear [cookie] from `_box` and `_set` respectivelly.
  static Future<void> delete(Cookie cookie) async {
    await _box.delete(cookie.name);
    _set.removeWhere((element) => element.name == cookie.name);
  }

  /// Delete and clear cookie with [id] from `_box` and `_set` respectivelly.
  /// e.g. deleteCookieById(temporary_reset_token).
  static Future<void> deleteById(String id) async {
    await _box.delete(id);
    _set.removeWhere((element) => element.name == id);
  }

  /// Delete and clear all saved and stored cookies in `_box` and `_set`, respectivelly.
  static Future<void> clear() async {
    await _box.clear();
    _set.clear();
  }

  /// Update stored and saved cookies in `_box` and `_set`.
  static Future<void> update(
    http.Response response,
  ) async {
    String? setCookie = response.headers[HttpHeaders.setCookieHeader];
    if (setCookie == null) return;
    SweetCookieJar sweetCookieJar = SweetCookieJar.from(
      response: response,
    );
    Cookie cookieRefresh = sweetCookieJar.find(name: 'client_token');
    await HiveCookies.save(cookieRefresh);
  }

  /// returns a map with one key: `cookie` and value: `all saved cookies`.
  /// Add it to HTTP request headers.
  static Map<String, String> get allCookies => {
        if (_set.isNotEmpty)
          HttpHeaders.cookieHeader: _set.map((e) => e.toString()).join('; '),
      };

  /// returns a map with one key: `cookie` and value: `all saved and expired cookies`.
  /// Add it to HTTP request headers.
  static Map<String, String> get expiredCookies => {
        HttpHeaders.cookieHeader: _set
            .where((element) => element.isExpired)
            .map((e) => e.toString())
            .join('; '),
      };

  /// returns a map with one key: `cookie` and value: `all saved and valide cookies`.
  /// Add it to HTTP request headers.
  static Map<String, String> get valideCookies => {
        HttpHeaders.cookieHeader: _set
            .where((element) => element.isNotExpired)
            .map((e) => e.toString())
            .join('; '),
      };

  static bool get isAuthenticated =>
      _set.where((element) => element.isNotExpired).isNotEmpty;

  static bool get isUnAuthenticated =>
      _set.where((element) => element.isNotExpired).isEmpty;
}
