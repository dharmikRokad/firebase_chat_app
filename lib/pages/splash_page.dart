import 'package:chat_app/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
    return Future.delayed(duration, () {
      // context.goNamed(AppRoute.createPostScreen.name, extra: PostType.blog);
      if (!mounted) return;
      if (2 == 1) {
        context.goNamed(RouteNames.homePage.name);
      } else {
        context.goNamed(RouteNames.loginPage.name);
      }
    });
  }
}
