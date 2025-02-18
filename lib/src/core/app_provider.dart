import 'package:chat_app/src/chat_app_injector.dart';
import 'package:chat_app/src/core/extensions/object_extensions.dart';
import 'package:chat_app/src/core/shared_prefs.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/src/core/extensions/string_extension.dart';

class AppProvider extends ChangeNotifier {
  /// Constructor
  AppProvider() {
    getCurrentConnectivityStatus();
    addConnectivityListner();
  }

  /// Tabs
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void changeIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  /// Connectivity
  bool? _isConnected;

  bool get isConnected => _isConnected ?? false;

  addConnectivityListner() {
    Connectivity().onConnectivityChanged.listen((result) {
      log("connectivity status $result");
      _isConnected = result.contains(ConnectivityResult.wifi) ||
          result.contains(ConnectivityResult.mobile) ||
          result.contains(ConnectivityResult.ethernet) ||
          result.contains(ConnectivityResult.vpn);
      notifyListeners();
    });
  }

  getCurrentConnectivityStatus() async {
    notifyListeners();
    Connectivity().checkConnectivity().then((value) {
      log("value in getCurrentConnectivityStatus $value");
      _isConnected = value.contains(ConnectivityResult.wifi) ||
          value.contains(ConnectivityResult.mobile) ||
          value.contains(ConnectivityResult.ethernet) ||
          value.contains(ConnectivityResult.vpn);
      notifyListeners();
    });
  }

  /// THEME
  ThemeMode _currentThemeMode =
      sl<SharedPrefs>().theme?.toTheme ?? ThemeMode.system;

  ThemeMode get currentThemeMode => _currentThemeMode;

  void changeThemeMode(ThemeMode newThemeMode) {
    _currentThemeMode = newThemeMode;
    sl<SharedPrefs>().setTheme(newThemeMode.name);
    notifyListeners();
  }
}
