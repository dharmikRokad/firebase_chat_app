import 'package:chat_app/ui/auth/profile_completed_screen.dart';
import 'package:chat_app/ui/chat/chat_screen.dart';
import 'package:chat_app/ui/home/home_screen.dart';
import 'package:chat_app/ui/auth/login_screen.dart';
import 'package:chat_app/ui/auth/set_up_profile_screen.dart';
import 'package:chat_app/ui/splash/splash_screen.dart';
import 'package:chat_app/utils/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter._();

  static final _rootNavigator = GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> get rootNavigator => _rootNavigator;

  static final router = GoRouter(
    initialLocation: AppRoutes.splashPage.path,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigator,
    routes: [
      // splash
      GoRoute(
        path: AppRoutes.splashPage.path,
        name: AppRoutes.splashPage.name,
        builder: (context, state) => SplashScreen(key: state.pageKey),
      ),

      // auth
      GoRoute(
        path: AppRoutes.loginPage.path,
        name: AppRoutes.loginPage.name,
        builder: (context, state) => LoginScreen(key: state.pageKey),
      ),
      GoRoute(
        path: AppRoutes.setupProfilePage.path,
        name: AppRoutes.setupProfilePage.name,
        builder: (context, state) => SetUpProfileScreen(key: state.pageKey),
      ),
      GoRoute(
        path: AppRoutes.profileCompleted.path,
        name: AppRoutes.profileCompleted.name,
        builder: (context, state) => ProfileCompletedScreen(key: state.pageKey),
      ),

      // home
      GoRoute(
        path: AppRoutes.homePage.path,
        name: AppRoutes.homePage.name,
        builder: (context, state) => HomeScreen(key: state.pageKey),
        routes: [
          GoRoute(
            path: AppRoutes.chatScreen.path,
            name: AppRoutes.chatScreen.name,
            builder: (context, state) => ChatScreen(key: state.pageKey),
          ),
        ],
      )
    ],
  );
}
