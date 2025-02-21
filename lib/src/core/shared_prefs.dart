import 'dart:convert';

import 'package:chat_app/src/core/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SharedPrefs {
  SharedPrefs._();

  static final SharedPrefs _instance = SharedPrefs._();

  static SharedPrefs get instance => _instance;

  late final SharedPreferences _prefs;

  final String _userKey = "user";
  final String _accessTokenKey = "token";
  final String _refreshTokenKey = "refresh_token";
  final String _themeKey = "theme";

  init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// User ///

  User? get user =>
      User.fromJson(jsonDecode(_prefs.getString(_userKey) ?? '{}'));

  Future<bool> setUser(Map<String, dynamic> user) => _prefs.setString(
        _userKey,
        user.toString(),
      );

  Future<bool> removeUser() => _prefs.remove(_userKey);

  /// ACCESS TOKEN ///
  String? get accessToken => _prefs.getString(_accessTokenKey);

  Future<bool> setAccessToken(String token) =>
      _prefs.setString(_accessTokenKey, token);

  Future<bool> removeAccessToken() => _prefs.remove(_accessTokenKey);

  /// REFRESH TOKEN ///
  String? get refreshToken => _prefs.getString(_refreshTokenKey);

  Future<bool> setRefreshToken(String token) =>
      _prefs.setString(_refreshTokenKey, token);

  Future<bool> removeRefreshToken() => _prefs.remove(_refreshTokenKey);

  /// Theme ///
  String? get theme => _prefs.getString(_themeKey);

  setTheme(String theme) => _prefs.setString(_themeKey, theme);

  Future resetTheme() => _prefs.remove(_themeKey);
}
