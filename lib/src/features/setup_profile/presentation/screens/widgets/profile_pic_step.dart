import 'dart:io';

import 'package:chat_app/src/core/extensions/object_extensions.dart';
import 'package:chat_app/src/core/img_picker_helper.dart';
import 'package:chat_app/src/core/presentation/widgets/app_button.dart';
import 'package:chat_app/src/core/strings.dart';
import 'package:chat_app/src/core/themes/app_colors.dart';
import 'package:chat_app/src/features/setup_profile/presentation/providers/setup_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wizard_stepper/wizard_stepper.dart';

class ProfilePicStep extends StatelessWidget with WizardStep {
  ProfilePicStep({super.key});

  late SetupProfileProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<SetupProfileProvider>(context, listen: true);
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            5.verticalSpace,
            Text(
              Strings.profilePicStepHeading,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.apply(fontWeightDelta: 2),
            ),
            10.verticalSpace,
            Text(
              Strings.profilePicStepSubheading,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            30.verticalSpace,
            Container(
              height: .85.sw,
              width: .85.sw,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                border: Border.all(color: AppColors.lDarkBg),
                image: provider.profilePic != null
                    ? DecorationImage(
                        image: FileImage(File(provider.profilePic?.path ?? '')),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
            ),
            30.verticalSpace,
            AppButton(
              title: provider.profilePic == null
                  ? Strings.addPhoto
                  : Strings.removePhoto,
              onPressed: () async {
                if (provider.profilePic != null) {
                  provider.setProfilePic(null);
                  completeStep(false);
                  return;
                }
                provider.setProfilePic(
                    await ImagePickweHelper().pickImage(context));
                completeStep(true);
                log('image = ${provider.profilePic?.path}');
              },
            ),
          ],
        ),
      ),
    );
  }
}
