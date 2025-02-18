import 'package:chat_app/src/core/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  SharedPrefs._();

  static final SharedPrefs _instance = SharedPrefs._();

  static SharedPrefs get instance => _instance;

  late final SharedPreferences _prefs;

  final String _uidKey = "uid";
  final String _accessTokenKey = "token";
  final String _refreshTokenKey = "refresh_token";
  final String _themeKey = "theme";

  init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// UID ///
  String? get uid => _prefs.getString(_uidKey);

  Future<bool> setUID(String token) => _prefs.setString(_uidKey, token);

  Future<bool> removeUID() => _prefs.remove(_uidKey);

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
