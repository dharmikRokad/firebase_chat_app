import 'package:chat_app/src/core/app_assets.dart';
import 'package:chat_app/src/core/strings.dart';
import 'package:chat_app/src/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: widget.navigationShell.currentIndex,
        onDestinationSelected: (i) => widget.navigationShell.goBranch(i),
        destinations: [
          _buildNavigationDestination(
            0,
            Strings.message,
            ImagesAppAsset().messages,
          ),
          _buildNavigationDestination(
            0,
            Strings.profile,
            ImagesAppAsset().settings,
          ),
        ],
      ),
    );
  }

  _buildNavigationDestination(int index, String label, String icon) {
    return NavigationDestination(
      label: label,
      icon: Image.asset(icon),
      selectedIcon: Image.asset(icon, color: AppColors.lPrimary),
    );
  }
}
