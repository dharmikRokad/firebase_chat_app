import 'package:chat_app/src/core/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  SharedPrefs._();

  static final SharedPrefs _instance = SharedPrefs._();

  static SharedPrefs get instance => _instance;

  late final SharedPreferences _prefs;

  init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Theme ///
  String? get theme => _prefs.getString(Consts.kThemeKey);

  setTheme(String theme) => _prefs.setString(Consts.kThemeKey, theme);

  Future resetTheme() => _prefs.remove(Consts.kThemeKey);
}
