import 'package:chat_app/src/core/app_assets.dart';
import 'package:chat_app/src/core/app_provider.dart';
import 'package:chat_app/src/core/themes/app_colors.dart';
import 'package:chat_app/src/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            
            // Expanded(
            //   flex: 4,
            //   child: LottieBuilder.asset(AnimationAppAsset().noInternet),
            // ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 700,
                      child: Text(
                        "It seems you’re not connected to the internet right now. Please check your connection settings and try again. Once you're back online, all features will be available, and you can continue where you left off!",
                        style: Theme.of(context).textTheme.bodyMedium?.apply(
                              color: AppColors.lTextSecondary,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    AppButton(
                      title: 'Reload',
                      prefix: Icon(
                        Icons.refresh,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      onPressed: context
                          .read<AppProvider>()
                          .getCurrentConnectivityStatus,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
