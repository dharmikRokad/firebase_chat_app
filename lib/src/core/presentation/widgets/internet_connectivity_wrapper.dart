import 'package:chat_app/src/core/app_provider.dart';
import 'package:chat_app/src/core/extensions/object_extensions.dart';
import 'package:chat_app/src/core/presentation/widgets/no_internet_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InternetConnectivityWrapper extends StatefulWidget {
  const InternetConnectivityWrapper({super.key, required this.child});

  final Widget child;

  @override
  State<InternetConnectivityWrapper> createState() =>
      _InternetConnectivityWrapperState();
}

class _InternetConnectivityWrapperState
    extends State<InternetConnectivityWrapper> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (_, provider, __) {
      log("connection status ${provider.isConnected}");
      if (provider.isConnected) {
        return widget.child;
      } else {
        return const NoInternetWidget();
      }
    });
  }
}
