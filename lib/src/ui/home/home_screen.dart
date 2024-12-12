import 'package:chat_app/src/providers/auth_provider.dart';
import 'package:chat_app/src/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              await context.read<AuthenticationProvider>().signOut();
              if (!context.mounted) return;
              context.goNamed(AppRoutes.loginPage.name);
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: ListView(),
    );
  }
}
