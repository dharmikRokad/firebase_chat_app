import 'package:chat_app/src/core/presentation/widgets/internet_connectivity_wrapper.dart';
import 'package:chat_app/src/features/setup_profile/presentation/screens/profile_completed_screen.dart';
import 'package:chat_app/src/features/setup_profile/presentation/screens/setup_profile_screen.dart';
import 'package:chat_app/src/ui/chat/chat_screen.dart';
import 'package:chat_app/src/ui/home/home_screen.dart';
import 'package:chat_app/src/features/auth/presentation/screens/login_screen.dart';
import 'package:chat_app/src/features/auth/presentation/screens/set_up_profile_screen.dart';
import 'package:chat_app/src/ui/profile/profile_screen.dart';
import 'package:chat_app/src/core/presentation/splash_screen.dart';
import 'package:chat_app/src/core/routes/app_routes.dart';
import 'package:chat_app/src/ui/tabs/tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter._();

  static final _rootNavigator = GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> get rootNavigator => _rootNavigator;

  static final _chatsNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: "Chats Nav");

  static final _profileNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: "Profile Mav");

  static final router = GoRouter(
    initialLocation: AppRoutes.splashPage.path,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigator,
    routes: [
      // Splash ================================
      GoRoute(
        path: AppRoutes.splashPage.path,
        name: AppRoutes.splashPage.name,
        builder: (context, state) => SplashScreen(key: state.pageKey),
      ),

      // Auth ================================
      GoRoute(
        path: AppRoutes.loginPage.path,
        name: AppRoutes.loginPage.name,
        builder: (context, state) => InternetConnectivityWrapper(
          child: LoginScreen(key: state.pageKey),
        ),
      ),

      // Setup Profile ================================
      GoRoute(
        path: AppRoutes.setupProfile.path,
        name: AppRoutes.setupProfile.name,
        builder: (context, state) => InternetConnectivityWrapper(
          child: SetupProfileScreen(key: state.pageKey),
        ),
      ),
      GoRoute(
        path: AppRoutes.profileCompleted.path,
        name: AppRoutes.profileCompleted.name,
        builder: (context, state) => InternetConnectivityWrapper(
          child: ProfileCompletedScreen(key: state.pageKey),
        ),
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            InternetConnectivityWrapper(
          child: TabsScreen(navigationShell: navigationShell),
        ),
        branches: [
          /// Chat's Branch ================================
          StatefulShellBranch(
            navigatorKey: _chatsNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoutes.chats.path,
                name: AppRoutes.chats.name,
                builder: (context, state) => InternetConnectivityWrapper(
                  child: HomeScreen(key: state.pageKey),
                ),
                routes: [
                  GoRoute(
                    path: AppRoutes.chatScreen.path,
                    name: AppRoutes.chatScreen.name,
                    builder: (context, state) => InternetConnectivityWrapper(
                      child: ChatScreen(key: state.pageKey),
                    ),
                  ),
                ],
              )
            ],
          ),

          /// Profile's Branch ================================
          StatefulShellBranch(
            navigatorKey: _profileNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoutes.profile.path,
                name: AppRoutes.profile.name,
                builder: (context, state) => InternetConnectivityWrapper(
                  child: ProfileScreen(key: state.pageKey),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
