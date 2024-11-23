import 'package:chat_app/services/supa_auth_service.dart';
import 'package:chat_app/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person),
          ),
          IconButton(
            onPressed: () async {
              await SupaAuthService().signOut();
              if (!context.mounted) return;
              context.goNamed(RouteNames.loginPage.name);
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: ListView(),
    );
  }
}
