import 'package:chat_app/src/chat_app_injector.dart' show sl;
import 'package:chat_app/src/core/extensions/object_extensions.dart';
import 'package:chat_app/src/core/routes/app_routes.dart';
import 'package:chat_app/src/core/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/src/features/auth/presentation/providers/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Chat App",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      floatingActionButton: const Text(
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          "Ver 1.0"),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  startTimer() {
    return Future.delayed(
      const Duration(milliseconds: 2000),
      () {
        if (!mounted) return;
        context.read<AuthenticationProvider>().authStateChanges().listen(
          (authState) async {
            if (authState?.session == null) {
              log('not any logged in user.');
              if (!mounted) return;

              sl<SharedPrefs>().removeUser();
              sl<SharedPrefs>().removeAccessToken();
              sl<SharedPrefs>().removeRefreshToken();

              context.goNamed(AppRoutes.loginPage.name);
            } else {
              log('found the logged in user - ${authState?.session?.user.email}');
              if (!mounted) return;

              sl<SharedPrefs>()
                  .setUser(authState?.session?.user.toJson() ?? {});
              sl<SharedPrefs>()
                  .setAccessToken(authState?.session?.accessToken ?? '');
              sl<SharedPrefs>()
                  .setRefreshToken(authState?.session?.refreshToken ?? '');

              context.goNamed(
                await context
                        .read<AuthenticationProvider>()
                        .isObBoarded(authState?.session?.user.id ?? '')
                    ? AppRoutes.chats.name
                    : AppRoutes.setupProfile.name,
              );
            }
          },
        );
      },
    );
  }
}
