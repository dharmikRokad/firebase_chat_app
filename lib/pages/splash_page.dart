import 'dart:developer';
import 'package:chat_app/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/providers/auth_provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
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
          (user) async {
            if (user == null) {
              log('not any logged in user.');
              if (!mounted) return;
              context.goNamed(RouteNames.loginPage.name);
            } else {
              log('found the logged in user - ${user.email}');
              if (!mounted) return;
              context.goNamed(
                await context
                        .read<AuthenticationProvider>()
                        .isObBoarded(user.uid)
                    ? RouteNames.homePage.name
                    : RouteNames.setupProfilePage.name,
              );
            }
          },
        );
      },
    );
  }
}
