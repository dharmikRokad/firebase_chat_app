import 'package:chat_app/src/core/app_assets.dart';
import 'package:chat_app/src/core/routes/app_routes.dart';
import 'package:chat_app/src/core/strings.dart';
import 'package:chat_app/src/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class ProfileCompletedScreen extends StatelessWidget {
  const ProfileCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          children: [
            SizedBox(
              width: 1.sw,
              height: .5.sh,
              child: Lottie.asset(
                AnimationAppAsset().completedProfile,
                repeat: false,
              ),
            ),
            50.h.verticalSpace,
            Text(
              Strings.completed,
              style: Theme.of(context).textTheme.headlineMedium?.apply(
                    fontWeightDelta: 2,
                  ),
            ),
            20.h.verticalSpace,
            Text(
              Strings.completedDesc,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.apply(
                    fontWeightDelta: 2,
                  ),
            ),
            const Spacer(),
            AppButton(
              onPressed: () {
                context.pushReplacementNamed(AppRoutes.chats.name);
              },
              title: Strings.letsGo,
            )
          ],
        ),
      ),
    );
  }
}
