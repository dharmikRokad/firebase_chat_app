import 'package:chat_app/pages/set_up_profile.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/services/supa_auth_service.dart';
import 'package:chat_app/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
              await context.read<AuthenticationProvider>().signOut();
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
