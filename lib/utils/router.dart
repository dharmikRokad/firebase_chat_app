import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/home_page.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/set_up_profile.dart';
import 'package:chat_app/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum RouteNames {
  splashPage,
  loginPage,
  setupProfilePage,
  homePage,
  chatScreen,
}

extension PathName on RouteNames {
  String get path =>
      switch (this) { RouteNames.homePage => "/", _ => "/$name" };
}

class AppRouter {
  AppRouter._();

  static final _rootNavigator = GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> get rootNavigator => _rootNavigator;

  static final router = GoRouter(
    initialLocation: RouteNames.splashPage.path,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigator,
    routes: [
      GoRoute(
        path: RouteNames.splashPage.path,
        name: RouteNames.splashPage.name,
        builder: (context, state) => SplashPage(key: state.pageKey),
      ),
      GoRoute(
        path: RouteNames.loginPage.path,
        name: RouteNames.loginPage.name,
        builder: (context, state) => LoginPage(key: state.pageKey),
      ),
      GoRoute(
        path: RouteNames.setupProfilePage.path,
        name: RouteNames.setupProfilePage.name,
        builder: (context, state) => SetUpProfileScreen(key: state.pageKey),
      ),
      GoRoute(
        path: RouteNames.homePage.path,
        name: RouteNames.homePage.name,
        builder: (context, state) => HomePage(key: state.pageKey),
        routes: [
          GoRoute(
            path: RouteNames.chatScreen.path,
            name: RouteNames.chatScreen.name,
            builder: (context, state) => ChatPage(key: state.pageKey),
          ),
        ],
      )
    ],
  );
}
