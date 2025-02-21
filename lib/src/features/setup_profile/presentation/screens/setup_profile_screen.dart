import 'package:chat_app/src/chat_app_injector.dart';
import 'package:chat_app/src/core/extensions/context_extensions.dart';
import 'package:chat_app/src/core/extensions/object_extensions.dart';
import 'package:chat_app/src/core/routes/app_routes.dart';
import 'package:chat_app/src/core/shared_prefs.dart';
import 'package:chat_app/src/features/setup_profile/presentation/providers/setup_profile_provider.dart';
import 'package:chat_app/src/features/setup_profile/presentation/screens/widgets/address_step.dart';
import 'package:chat_app/src/features/setup_profile/presentation/screens/widgets/otp_step.dart';
import 'package:chat_app/src/features/setup_profile/presentation/screens/widgets/personal_info_step.dart';
import 'package:chat_app/src/features/setup_profile/presentation/screens/widgets/phone_step.dart';
import 'package:chat_app/src/features/setup_profile/presentation/screens/widgets/profile_pic_step.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:wizard_stepper/wizard_stepper.dart';

class SetupProfileScreen extends StatefulWidget {
  const SetupProfileScreen({super.key});

  @override
  State<SetupProfileScreen> createState() => _SetupProfileScreenState();
}

class _SetupProfileScreenState extends State<SetupProfileScreen> {
  late final WizardStepperController _stepperController;

  @override
  void initState() {
    super.initState();

    _stepperController = WizardStepperController(
      showNavigationButtons: true,
      onSelectedStep: (step) {
        log("current step == $step");
      },
      onMovedToLastStep: () async {
        await context.read<SetupProfileProvider>().updateProfile(
          sl<SharedPrefs>().user?.id ?? '',
          sl<SharedPrefs>().user?.email ?? '',
          onSuccess: (_) {
            context.pushReplacementNamed(AppRoutes.profileCompleted.name);
            context.read<SetupProfileProvider>().resetValues();
          },
          onFailure: context.showError,
        );
      },
      onStepCompleted: (index, isCompleted) {
        log("step $index is completed == $isCompleted");
      },
      orientation: WizardStepperOrientation.vertical,
      position: WizardStepperPosition.left,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _addListner();
    });
  }

  _addListner() {
    _stepperController.stepChanges.listen((event) {
      for (WizardStepperMetadata data in event.steps) {
        log(data.toString());
      }

      if (event.steps[3].isComplete && event.steps[4].isCurrentStep) {
        if (!mounted) return;
        context.read<SetupProfileProvider>().sendOtp();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: WizardStepper(
            controller: _stepperController,
            steps: [
              ProfilePicStep(),
              PersonalInfoStep(),
              AddressStep(),
              PhoneStep(),
              OtpStep(),
            ],
          ),
        ),
      ),
    );
  }
}
