import 'package:chat_app/src/core/extensions/object_extensions.dart';
import 'package:chat_app/src/core/themes/app_colors.dart';
import 'package:chat_app/src/providers/auth_provider.dart';
import 'package:chat_app/src/core/routes/app_routes.dart';
import 'package:chat_app/src/providers/chat_provider.dart';
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
            onPressed: _showLogOutDialogue,
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Consumer<ChatProvider>(builder: (context, provider, _) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const Text("Users"),
              const SizedBox(height: 10),
              StreamBuilder(
                stream: provider.getUsers(),
                builder: (context, snapshot) {
                  /// Loading View
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    log("loading status.");
                    return const Center(child: CircularProgressIndicator());
                  }

                  /// Error View
                  if (snapshot.hasError) {
                    log("snappshot has error.");
                    log(snapshot.error.toString());
                    return const Center(
                      child: Text(
                          "Something went wrong.\nPlease try again later."),
                    );
                  }

                  /// Active View
                  if (snapshot.connectionState == ConnectionState.active) {
                    log("active status.");

                    /// Active - No Data View
                    if (!snapshot.hasData) {
                      log("snapshot has no data.");
                      return const Center(
                        child: Text("Nothing to show here yet."),
                      );
                    }

                    /// Active - With Data View.
                    final users = snapshot.data!;
                    log("users => $users");
                    return Container(color: AppColors.primaryColor);
                  }

                  return Container();
                },
              ),
            ],
          ),
        );
      }),
    );
  }

  void _showLogOutDialogue() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Alert!"),
          content: const Text(
            "Are you sure want to log out from the app?",
          ),
          actions: [
            TextButton(
              onPressed: context.pop,
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await context.read<AuthenticationProvider>().signOut();
                if (!context.mounted) return;
                context.goNamed(AppRoutes.loginPage.name);
              },
              child: const Text('Log out'),
            ),
          ],
        );
      },
    );
  }
}
