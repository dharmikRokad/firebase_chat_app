import 'package:chat_app/utils/extensions/object_extensions.dart';
import 'package:chat_app/utils/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/providers/auth_provider.dart';

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
    var duration = const Duration(milliseconds: 2000);
    return Future.delayed(
      duration,
      () {
        if (!mounted) return;
        context.read<AuthenticationProvider>().authStateChanges().listen(
          (authState) async {
            if (authState?.session == null) {
              log('not any logged in user.');
              if (!mounted) return;
              context.goNamed(AppRoutes.loginPage.name);
            } else {
              log(
                  'found the logged in user - ${authState?.session?.user.email}');
              if (!mounted) return;

              context.goNamed(
                await context
                        .read<AuthenticationProvider>()
                        .isObBoarded(authState?.session?.user.id ?? '')
                    ? AppRoutes.homePage.name
                    : AppRoutes.setupProfilePage.name,
              );
            }
          },
        );
      },
    );
  }
}
